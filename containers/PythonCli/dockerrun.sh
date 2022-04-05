#!/bin/bash

IMAGE_NAME="anddang/clitest"

echo "Building image with hard coded values"
docker build -t $IMAGE_NAME .

# Now run it overriding the ENV vars
echo "Run with ENV overrides"
docker run -e "AZURE_SUBSCRIPTION=6cea88f7-c17b-48c1-b058-bec742bc100f" -e "EXPERIENCE_LABRG=experiencelab-grecoe" $IMAGE_NAME

echo "Build and Runs completed!"
