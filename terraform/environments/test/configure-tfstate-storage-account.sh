#!/bin/bash
RESOURCE_GROUP_NAME="Azuredevops"
STORAGE_ACCOUNT_NAME="tfstate$RANDOM$RANDOM"
CONTAINER_NAME="tfstate"

# This command is not needed in the Udacity provided Azure account. 
# Create resource group
az group create --name $RESOURCE_GROUP_NAME --location eastus

# Create storage account
az storage account create --resource-group $RESOURCE_GROUP_NAME --name $STORAGE_ACCOUNT_NAME --sku Standard_LRS --encryption-services blob

# Get storage account key
ACCOUNT_KEY=$(az storage account keys list --resource-group $RESOURCE_GROUP_NAME --account-name $STORAGE_ACCOUNT_NAME --query '[0].value' -o tsv)
export ARM_ACCESS_KEY=$ACCOUNT_KEY

# Create blob container
az storage container create --name $CONTAINER_NAME --account-name $STORAGE_ACCOUNT_NAME --account-key $ACCOUNT_KEY
echo "RESOURCE_GROUP_NAME=$RESOURCE_GROUP_NAME"
echo "STORAGE_ACCOUNT_NAME=$STORAGE_ACCOUNT_NAME"
echo "CONTAINER_NAME=$CONTAINER_NAME"
echo "ACCOUNT_KEY=$ACCOUNT_KEY"

#note: this command must run in console or power shell của win, not bash shell of github
az ad sp create-for-rbac --role Contributor --scopes /subscriptions/29ae481a-5031-42bd-883d-5518885f31fd --query "{ client_id: appId, client_secret: password, tenant_id: tenant }" 
# it will return:
# Creating 'Contributor' role assignment under scope '/subscriptions/29ae481a-5031-42bd-883d-5518885f31fd'
# The output includes credentials that you must protect. Be sure that you do not include these credentials in your code or check the credentials into your source control. For more information, see https://aka.ms/azadsp-cli
# {
#   "client_id": "9f6dff3c-9e9e-4135-abe7-830c997a9319",
#   "client_secret": "Y568Q~fPP3~ylIxlrkecKV0YHPpdmMzT4DZXadAE",
#   "tenant_id": "53778f8a-4af4-4cf7-bb7b-c41cf2cc4d40"
# }

