# Azure Kubernetes Service

This page walks through moving your container from docker to an Azure Container Registry and then creating a pod/deployment in an Azure Kubernetes Service. 

## Pre-requisites
- [Follow Getting Started instructions](./GetStarted.md)
- [Create a local container](./Containers.md#build-local-container)
    - For this example we'll assume that the container you made is called myhubaccount/firstpythonapi to replace the format in previous documentation of [dockerhubname]/[image_name]

See the [References](#references) section for helpful links to articles related to the content in this file. 

## Topics
- [Configure ACR and AKS](#configure-acr-and-aks)
- [Push your container to your ACR](#push-your-container-to-your-acr)
- [Create AKS Workload](#create-an-aks-workload)


# Configure ACR and AKS
This example uses an ACR (Azure Container Registry) to host the images that we want the AKS (Azure Kubernetes Service) instance to pull images from.This section has you:

- Create an AKS and ACR instance
- [Configure docker to talk with your ACR](#docker-configuration-to-acr)
- [Configure kubectl to talk with your AKS](#kubectl-configuration-to-aks)
- [Configure RBAC between ACR and AKS](#configure-rbac-between-acr-and-aks)

Go to the Azure Portal and create a single ACR and single AKS instance in the same resource group. Using defaults (I think) for now is fine. 

## Docker configuration to ACR
You need to configure your docker installation to recognize and have access to your ACR. 

> az login (if you are not logged in already)

> az account set -s [your_subscription_id]

> az acr login --name [acrName]

This merges in the user information to the C:\Users\YOU\.docker\config file and makes the ACR accessible for push/pull events in your docker environment. The token used doesn't last forever so you may need to do this daily, or more frequently. 

### Get ACR Token and use directly
While this won't be needed very frequently, if at all, you can get a token from the ACR service and use it directly by [following these instructions](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-authentication?tabs=azure-cli#az-acr-login-with---expose-token).

### Switch back to docker hub creds for docker
> docker logout
> docker login -u [USER] -p [YOUR PASSWORD]

## kubectl configuration to AKS
kubectl is a tool installed with Docker Desktop that allows you to communication with your AKS (or any Kubernetes) system. 

To [configure kubectl](https://docs.microsoft.com/en-us/azure/aks/kubernetes-walkthrough#connect-to-the-cluster) to communication with your cluster you need to run a couple of az cli commands. 

> <sub><b>NOTE</b> Docker desktop installs kubectl so you do not need to run *az aks install-cli*</sub>

The following commands will update the kubectl config, which will be located at C:\Users\YOU\.kube\config 

> az login (if you are not logged in already)

> az account set -s [your_subscription_id]

> [az aks get-credentials](https://docs.microsoft.com/en-us/cli/azure/aks?view=azure-cli-latest#az-aks-get-credentials) --resource-group RG --name CLUSTER

This last command merges the credentials in your .kube/config file for you. You can now test kubectl to ensure you have connected. 

- List contexts (the contexts configured with kubectl, should only be one at this point)
    > kubectl config get-contexts
- Set Current Context (to change context, but don't do this now)
    > kubectl config use-context CONTEXT_NAME
- See nodes in cluster (should show you the nodes you defined in your cluster)
    > kubectl get nodes

For more on kubectl see the [kubectl cheat sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/).


## Configure RBAC between ACR and AKS
For your AKS instance to pull images from your ACR you need to provide AKS with credentials to do so. This happens in 3 steps. 

1. [Create an Azure Service Principal for RBAC](#create-service-principal)
2. [Configure credentials in AKS](#save-sp-credentials-to-aks-instance)

### Create Service Principal
> <sub><b>NOTE:</b> My version of az cli did not support the following command. This was changed in version 2.25 (use *az version* to see what version you have). However, running az update fails on my system based on some policies that were set on it so I had to download the msi installer </sub>

This section creates an Azure Service Principal and assigns contributor rights to the ACR instance. This will allow the SP to push/pull images from the ACR instance. 

Supporting Articles:
- [Create SP For AKS](https://docs.microsoft.com/en-us/azure-stack/aks-hci/deploy-azure-container-registry#create-an-azure-container-registry)
- [Create AKS Secret Store](https://docs.microsoft.com/en-us/azure-stack/aks-hci/deploy-azure-container-registry#deploy-an-image-from-the-acr-to-aks-on-azure-stack-hci)

Run the following command from a command prompt:

```code
az ad sp create-for-rbac
  --scopes /subscriptions/[SUBSCRIPTION_ID]/resourcegroups/[RG_NAME]/providers/Microsoft.ContainerRegistry/registries/[ACR_NAME]
  --role Contributor
  --name [SERVICE_PRINCIPAL_NAME]
```

> <sub><b>NOTE:</b> Record somewhere the name of the service principal you create so that you can go to Azure Active Directory and delete it when done.</sub>

The above command produces the following output:

```json
{
  "appId": "[AppId]",
  "displayName": "[SERVICE_PRINCIPAL_NAME]",
  "password": "[SpSecret]",
  "tenant": "[SpTenent]"
}
```

### Save SP Credentials to AKS instance
This crucial step allows the AKS instance to pull/push images with the ACR instance. Some values denoted in the command come from the step above. 

```code
kubectl create secret docker-registry [secret-name] \
    --namespace [namespace] \
    --docker-server=[ACR_NAME].azurecr.io \
    --docker-username=[AppId] \
    --docker-password=[SpSecret]
```

> <sub><b>NOTE:</b> Record somewhere the name of the [registry-secret] that is being created as you will need it when creating an AKS deployment or pod.<br><br>This is available by going to the AKS instance in the portal and from the menu Configuration>Secrets</sub>


# Push your container to your ACR
As mentioned at the beginning of this page, it was noted we are going to be working with the image myhubaccount/firstpythonapi. You can find this by running the following command

> docker images

You should use whatever the name is you have there for the FirstApiPython image that you created, but again, for this section we will assume it's myhubaccount/firstpythonapi. 

- [Supporting Article](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-get-started-docker-cli?tabs=azure-cli#create-an-alias-of-the-image)

This is a 2 step process. 

1. Tag your image for the ACR 
    > docker tag [dockerhubname]/[image_name]:[version] [AcrName].azurecr.io/samples/[image_name]

    Which translates to

    > docker tag myhubaccount/firstpythonapi:latest [AcrName].azurecr.io/samples/firstpythonapi

2. Push your image to the ACR
    > docker push [AcrName].azurecr.io/samples/[image_name]

    Which translates to

    > docker push [AcrName].azurecr.io/samples/firstpythonapi


# Create an AKS Workload

<b>TBD</b>
This section you will create an actual workflow with your image in the AKS instance

Supporting Articles
    - [Creating Objects](https://kubernetes.io/docs/reference/kubectl/cheatsheet/#creating-objects)
    - [Manifest File](https://docs.microsoft.com/en-us/azure/aks/concepts-clusters-workloads#deployments-and-yaml-manifests)
    - [Core Concepts](https://docs.microsoft.com/en-us/azure/aks/concepts-clusters-workloads#deployments-and-yaml-manifests)



Then you need a YAML file to import it

[Networking deep dive](https://jonathan18186.medium.com/azure-kubernetes-service-aks-networking-deep-dive-part-2-pod-and-service-communication-pod-and-336ad47518c)
> kubectl create -f pod-example.yaml


# References
- [kubectl cheat sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)
- [Azure AKS Tutorial](https://docs.microsoft.com/en-us/azure/aks/tutorial-kubernetes-prepare-app)
- [Connect to cluster](https://docs.microsoft.com/en-us/azure/aks/kubernetes-walkthrough#connect-to-the-cluster)
    - Note that kubectl is installed with docker
    - Location from the first command says config is C:\Users\grecoe\.kube\config
- [Article - Auth with ACR](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-authentication?tabs=azure-cli)
- [Using ACR token directly](https://docs.microsoft.com/en-us/azure/container-registry/container-registry-authentication?tabs=azure-cli#az-acr-login-with---expose-token)
- [Article - Deploy ACR image to AKS](https://docs.microsoft.com/en-us/azure-stack/aks-hci/deploy-azure-container-registry)
- [Create SP For AKS](https://docs.microsoft.com/en-us/azure-stack/aks-hci/deploy-azure-container-registry#create-an-azure-container-registry)
- [Create AKS Secret Store](https://docs.microsoft.com/en-us/azure-stack/aks-hci/deploy-azure-container-registry#deploy-an-image-from-the-acr-to-aks-on-azure-stack-hci)
- From some articles in 2018 concerning AML, these should probably have equivalents in kubectl
    > az acs scale -n [cluster_name] -g [resource_group] --new-agent-count [agent_count]

    > az ml service update realtime -i [az_ml_service_id] -z [pod_count]

    > az ml service update realtime -i [az_ml_service_id] --cpu [i.e. 0.3, 1]

    > az ml service update realtime -i [az_ml_service_id] --memory [i.e. 1G,500M]

    > az ml service update realtime -i [az_ml_service_id] --replica-max-concurrent-requests [i.e. 10,20]
