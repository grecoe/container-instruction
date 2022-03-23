#!/bin/bash


# Hard code in the storage account and key

echo "Building image with hard coded values"
docker build -t anddang/hardcode --build-arg AZACCTARG=StgAccountName --build-arg AZACCTKEYARG=StgAccountKey .

# No need for port because we aren't exposing it. Run it with the arguments above
echo "Run with what was placed during build"
docker run anddang/hardcode

# Now run it overriding the ENV vars
echo "Run with ENV overrides"
docker run anddang/hardcode -e "AZACCT=OverrideAccount" -e "AZACCTKEY=OverrideAccountKey"

echo "Build and Runs completed!"

# When run you will see output similar to this, note the environemnt variables AZACCT and AZACCTKEY
#   LANG = C.UTF-8
#   GPG_KEY = E3FF2839C048B25C084DEBE9B26995E310250568
#   PYTHON_VERSION = 3.9.11
#   PYTHON_PIP_VERSION = 22.0.4
#   PYTHON_SETUPTOOLS_VERSION = 58.1.0
#   PYTHON_GET_PIP_URL = https://github.com/pypa/get-pip/raw/38e54e5de07c66e875c11a1ebbdb938854625dd8/public/get-pip.py
#   PYTHON_GET_PIP_SHA256 = e235c437e5c7d7524fbce3880ca39b917a73dc565e0c813465b7a7a329bb279a
#   AZACCT = StgAccountName
#   AZACCTKEY = StgAccountKey
#   HOME = /root
#   Complete building

# Now run it like this 
# docker run -e "AZACCT=OverrideAccount" -e "AZACCTKEY=OverrideAccountKey" anddang/hardcode 