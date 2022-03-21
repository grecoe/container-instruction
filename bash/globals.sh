#!/bin/bash

# Global Variables and shared functions
SUBSCRIPTIONID="YOUR_SUB_ID"
RESOURCE_GROUP="RESOURCE_GROUP_NAME"
REGION="eastus"
MANAGED_IDENTITY="USER_MANAGED_IDENTITY_NAME"
CLUSTER_NAME="AKS_CLUSTER_NAME"



eval_cli_command () {
    # Function to run just about anything, but meant for az cli commands. Takes 
    # 2 parameters
    #
    #   $1 is command to execute
    #   $2 is the file to store result to
    #
    # If a file is sent in, it's output is put there, otherwise it's echoed out
    # and can be used as a return value. 

    # If there is no file provided, do NOT try and write it out
    if [ -z "$2" ]; then
        echo $(eval "$1")
    else
        eval "$1" > $2
    fi
}

find_output () {
    # With output from a previous call put to a file, this function will
    # parse a JSON file and find a value for you. It takes 2 parameters
    #
    # $1 is json file to obtain data from
    # $2 is the json field to extract value from
    #
    # Returns the value found. 

    if test -f "$1"; then
        command="grep -o '\"$2\": \"[^\"]*' $1 | grep -o '[^\"]*$'"
        value=$(eval "$command")
        echo $value
    else
        echo "The file $1 does not exist"
    fi
}
