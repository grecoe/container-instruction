#!/bin/bash


# These would be environment variables set by docker launch itself.
AZURE_SUB=$(printenv AZURE_SUBSCRIPTION)
AZURE_RG=$(printenv EXPERIENCE_LABRG)

echo $AZURE_SUB
echo $AZURE_RG

# Now collect information about the user and specific instance.
echo "Log in user and set subscription"

az login --use-device-code > /dev/null
az account set -s $AZURE_SUB > /dev/null

USER=$(az ad signed-in-user show --query objectId -otsv)
TENANT=$(az account show --query tenantId -otsv)

# Collect information from the RG that MUST be an energy deployment
echo "Collect information with logged in user credentials"

KEYVAULT=$(az resource list -g $AZURE_RG --resource-type Microsoft.KeyVault/vaults --query [].name -otsv)
CLIENT=$(az keyvault secret show --name client-id --vault-name $KEYVAULT --query value -otsv)
SECRET=$(az keyvault secret show --name client-secret --vault-name $KEYVAULT --query value -otsv)
PLATFORM=$(az resource list -g $AZURE_RG --resource-type Microsoft.OpenEnergyPlatform/energyServices --query [].name -otsv)

export AZURE_USER=$USER
export AZURE_TENANT=$TENANT
export EXPERIENCE_CLIENT=$CLIENT
export EXPERIENCE_CRED=$SECRET
export ENERGY_PLATFORM=$PLATFORM

# With all the settings now in the environment, launch the application. 
echo "Launch Python application"
python app.py
