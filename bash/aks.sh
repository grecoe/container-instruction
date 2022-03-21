#!/bin/bash

# Generates three things currently
#   1. Resource Group
#   2. User Managed Identity
#       - Applies role of Contributor to the RG
#   3. AKS Instance (lots of defaults)
#       - Assigns the user managed identity to it


SUBSCRIPTIONID="YOUR_SUB_ID"
RESOURCE_GROUP="RESOURCE_GROUP_NAME"
REGION="eastus"
MANAGED_IDENTITY="USER_MANAGED_IDENTITY_NAME"
CLUSTER_NAME="AKS_CLUSTER_NAME"

eval_cli_command () {
    # $1 is command to execute
    # $2 is the file to store result to

    # If there is no file provided, do NOT try and write it out
    if [ -z "$2" ]; then
        echo $(eval "$1")
    else
        eval "$1" > $2
    fi
}

find_output () {
    # $1 is json file to obtain data from
    # $2 is the json field to extract value from
    #echo "Field is $2"

    if test -f "$1"; then
        command="grep -o '\"$2\": \"[^\"]*' $1 | grep -o '[^\"]*$'"
        value=$(eval "$command")
        echo $value
    else
        echo "The file $1 does not exist"
    fi
}

# Constants for validation
false=0
true=1

# Files we'll utilize
accountjson="account.json"
rgjson="resourcegroup.json"
identityjson="identity.json"
akscreatejson="aks.json"

################################################################
# Get the current account and see if we need to update it
eval_cli_command "az account show" $accountjson
account_id=$(find_output $accountjson "id")

if [[ $account_id != $SUBSCRIPTIONID ]]; then
    echo "Swtiching to account $SUBSCRIPTIONID from $account_id"
    eval_cli_command "az account set -s $SUBSCRIPTIONID"
else
    echo "Already in correct subscription $SUBSCRIPTIONID"
fi

#################################################################
# Create the group if it's not there, if it is the show's over
group_exists=$(eval_cli_command "az group exists -g $RESOURCE_GROUP")
if [[ $group_exists == "false" ]]; then
    echo "Creating Resource Group $RESOURCE_GROUP"
    eval_cli_command "az group create -l $REGION -n $RESOURCE_GROUP" $rgjson
else
    echo "Resource group $RESOURCE_GROUP exists, exiting script"
    exit
fi

#################################################################
# Create managed identity
echo "Creating Managed Identity $MANAGED_IDENTITY"
eval_cli_command "az identity create -n $MANAGED_IDENTITY -g $RESOURCE_GROUP" $identityjson 
sleep 1m

# Set Managed Identity Operator over the RG scope, don't need to save this output so run it directly
# Also unsure if this is correct
resource_group_id=$(find_output $rgjson "id")
identity_principal_id=$(find_output $identityjson "principalId")
identity_resource_id=$(find_output $identityjson "id")

# Use assignee-object-id instead of assignee to bypass graph and use for user managed
echo "Create Contributor Role Assignment on Resource Group" 
az role assignment create --role "Contributor" --assignee-object-id $identity_principal_id --resource-group $RESOURCE_GROUP

# Create an AKS cluster with an identity enabled
echo "Create AKS Cluster $CLUSTER_NAME"
eval_cli_command "az aks create -g $RESOURCE_GROUP -n $CLUSTER_NAME --generate-ssh-keys --enable-managed-identity --assign-identity $identity_resource_id" $akscreatejson

# You can now check that the identity is set with : 
az aks show -g $RESOURCE_GROUP -n $CLUSTER_NAME --query "identity"

# Cleanup files
rm -f $accountjson
rm -f $rgjson
rm -f $identityjson
rm -f $akscreatejson
exit

az role assignment create --assignee $identity_id --role "Managed Identity Operator" --scope $resource_group_id
sleep 1m 


