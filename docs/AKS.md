# Azure Kubernetes Service

[kubectl cheat sheet](https://kubernetes.io/docs/reference/kubectl/cheatsheet/)

[Azure AKS Tutorial](https://docs.microsoft.com/en-us/azure/aks/tutorial-kubernetes-prepare-app)

[Connect to cluster](https://docs.microsoft.com/en-us/azure/aks/kubernetes-walkthrough#connect-to-the-cluster)
- Note that kubectl is installed with docker
- Location from the first command says config is C:\Users\grecoe\.kube\config

# Get configuration

> az aks get-credentials --resource-group RG --name CLUSTER

Merges the content into your kubectl config file, mine is found here:
> C:\Users\grecoe\.kube\config

- List contexts
    > kubectl config get-contexts
- Set Current Context
    > kubectl config use-context CONTEXT_NAME
- See nodes in cluster
    > kubectl get nodes