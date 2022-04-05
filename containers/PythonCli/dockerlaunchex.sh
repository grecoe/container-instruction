#!/bin/bash

# This is an example of setting the Environment variables BEFORE launching 
# The docker container. 

# These would be the environment variables needed to setup the script to launch it.
export AZURE_SUBSCRIPTION="YOUR_AZURE_SUB_ID"
export EXPERIENCE_LABRG="YOUR_OSDU_RG_NAME"


bash ./dockerscript.sh