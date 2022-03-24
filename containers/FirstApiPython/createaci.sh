#!/bin/bash
RANDOM_NUMBER=$(echo $((RANDOM%9999)))
SUBSCRIPTION="b0844137-4c2f-4091-b7f1-bc64c8b60e9c"
RESOURCE_GROUP="test"$RANDOM_NUMBER # Prepended with username

MANAGED_IDENTITY="mgdid"$RANDOM_NUMBER # Prepended with username

ACI_NAME="testaci"$RANDOM_NUMBER # Prepended with username
DNS_NAME=$RANDOM_NUMBER # Prepended with username 
LOCATION="eastus"
IP_ADDRESS="Public" # or Private
OS_TYPE="Linux" # or Windows
PROTOCOL="TCP" # or UDP
IMAGE="anddang/pythonapi" # If you use anything but your repo name (username on docker) push fails
                          # unless you create a new repository up there

get_username(){
    # Get the username from the current account, which will be logged in user.
    email=$(az account show --query user.name -otsv)
    old_ifs="$IFS"
    IFS="@"

    for i in $email
    do
        echo $i
        break
    done

    IFS="$old_ifs"
}

# Get the email address of the user/alias
USER_NAME=$(get_username)

# Set up unique naming
RESOURCE_GROUP=$USER_NAME$RESOURCE_GROUP
ACI_NAME=$USER_NAME$ACI_NAME
DNS_NAME=$USER_NAME$DNS_NAME
MANAGED_IDENTITY=$USER_NAME$MANAGED_IDENTITY

# Build the image
echo "Creating docker image $IMAGE"
docker build -t $IMAGE .

sleep 5s

# Push the image to dockerhub
echo "Pushing docker image $IMAGE"
docker push $IMAGE

sleep 10s

# Delete the image locally from docker
# docker rmi $IMAGE

echo "Creating Azure Resources"

# Force the correct subscription
az account set -s $SUBSCRIPTION

# Create the resource group
az group create -n $RESOURCE_GROUP -l $LOCATION

# Create the managed identity - and give it time to get set
MANAGED_IDENTITY_ID=$(az identity create -n $MANAGED_IDENTITY -g $RESOURCE_GROUP --query id -otsv)
sleep 1m

# Create the ACI
az container create \
    -g $RESOURCE_GROUP \
    --name $ACI_NAME \
    --location $LOCATION \
    --image $IMAGE \
    --protocol $PROTOCOL \
    --ip-address $IP_ADDRESS \
    --dns-name-label $DNS_NAME \
    --os-type $OS_TYPE \
    --assign-identity $MANAGED_IDENTITY_ID
