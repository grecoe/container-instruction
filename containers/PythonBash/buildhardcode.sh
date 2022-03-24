#!/bin/bash


# Hard code in the storage account and key

echo "Building image with hard coded values"
docker build -t anddang/hardcode --build-arg AZACCTARG=StgAccountName --build-arg AZACCTKEYARG=StgAccountKey .

# No need for port because we aren't exposing it. Run it with the arguments above
echo "Run with what was placed during build"
docker run anddang/hardcode

# Running you want to pay attention to the two environment variables:
# AZACCT
# AZACCTKEY

# Now run it overriding the ENV vars
echo "Run with ENV overrides"
docker run anddang/hardcode -e "AZACCT=OverrideAccount" -e "AZACCTKEY=OverrideAccountKey"

echo "Build and Runs completed!"
