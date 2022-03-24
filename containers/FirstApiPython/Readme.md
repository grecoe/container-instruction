# FirstPythonAPI

This is a very simplistic Python Flask API that simply says hello and tries to print out the name of the user managed identity associated with the container. 

It is used in the main examples on how to use docker and then how to deploy to ACI and AKS either raw or with Helm. 

If you've found your way here...there is another way that combines a few topics togehter, primarily docker, bash and ACI into one shell script. 

# Shell Generation of ACI
The shell generation script - createaci.sh - performs a bunch of tasks for you. In order, they are

- Build docker image from this directory (you must have docker installed)
- Push docker image to Dockerhub (you must have an account configured and logged in)
- Create an Azure Resource Group
- Create an Azure User Managed Identity
- Create an ACI with the image you just created
- Your endpoint ${DNS_NAME}.${LOCATION}.azurecontainer.io will be available

A single run of this will generate an rg named [youralias]test[randomnumber] with the resources contained within it. 

When done you will have an image in your local docker and in your Dockerhub account that you will want to probably clear out. Further you'll have the Azure RG to delete as well. 

But you will be able to go to the ACI and get the URI/FQDN. 