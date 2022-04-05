# PythonCli

This example uses a base image including the Azure CLI to collect information about the user and the OSDU deployment they have created. Exhibits

- Use of Azure CLI image
    - Does not accept SP credentials, but requires user login with device code after container starts. 
    - All CLI executed in .sh file dockerscript.sh (the one bundled in the container)
- Launches a shell script first (dockerscript.sh) to use CLI to collect user login/kv secrets and sets to the environment for the Python script. 
- Python script reads all of the environment set by either docker or the shell script and performs some basic OSDU calls and just prints them out. So you'll need to use logs. 

## Environment Variables
This also uses environment variable that need to be set when running the container or it will fail for obvious reasons. To launch it with variables see dockerrun.sh, but you just provide the two pieces of information required:

> docker run -e "AZURE_SUBSCRIPTION=YOUR_SUB_NAME" -e "EXPERIENCE_LABRG=YOUR_OSDU_RG_NAME" $IMAGE_NAME

### Test Locally
You can mimic running the code outside of docker by using the dockerlauncex.sh file and providing the same Azure Sub and Resource Group information as above. 

## Run Locally
For running locally, run the dockerrun.sh script. In that file you'll need to 

1. Change the image name to be created
2. Provide an Azure Subscripiton ID and Azure Resource Group (with OSDU deployment) name
3. Run the script
    - Remember, when launched it will ask you to log in with a device code to Azure. 