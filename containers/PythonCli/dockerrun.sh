#!/bin/bash

IMAGE_NAME="anddang/clitest"

echo "Building image with hard coded values"
docker build -t $IMAGE_NAME .

# Now run it overriding the ENV vars
echo "Run with ENV overrides"
docker run -e "AZURE_SUBSCRIPTION=YOUR_SUB_NAME" -e "EXPERIENCE_LABRG=YOUR_OSDU_RG_NAME" $IMAGE_NAME

docker start 589d35c1dd9c

echo "Build and Runs completed!"
