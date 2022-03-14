# Docker Examples

Details about creating/using containers in C# and Python(Flask) in both local docker (Linux containers) and Azure Container Instances. 

### [Getting Started](./docs/GetStarted.md)
Gives basic instructions on setting up Docker by getting a Docker Hub account, and setting up your local machine to do some real work. 

### [Building Containers](./docs/Containers.md)
This repo has two different types of containers that you can build. This page describes how to build the containers, run them locally, and perform some basic Docker commands to see your images/containers.

- .NET Rest API
- Python Flask API

<b>NOTE:</b> Neither of these basic examples utilize any type of security. 

### [.NET Container](./docs/DotNet.md)
Describes how you interact with the .NET code to build and test it.

### [Python Flask Container](./docs/Python.md)
Describes how you interact with the Python code to build and test it.

### [Azure Container Instance](./docs/ACI.md)
Instructions on how to set up an ACI instance with either of the two containers contained in this repository, but are generalized so that you can use this for any ACI. 

<b>TBD</b> 
- Figure out how to add in an NSG to restrict access then make it available to a smaller audience.
- API Management to poke through firewall? 

### [Azure Kubernetes Service](./docs/AKS.md)
How to set up your containers and scale them with AKS. 