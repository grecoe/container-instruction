# Helm Charts

## Requirements
- [Install Helm](https://helm.sh/docs/intro/install/)
- [Install From Choclatey - Windows](https://helm.sh/docs/intro/install/#from-chocolatey-windows)
    - Logs - C:\ProgramData\chocolatey\logs\chocolatey.log
    - [Install Chocolatey](https://chocolatey.org/install)
- [Follow the AKS setup](./AKS.md)
    - All steps from the beginning up to and including *Push your container to your ACR* 


# Usage

## Create a new chart
For creating a new HELM chart you use the HELM tool create, this will create a directory and all of the things you'll need in a directory given the name of the chart you are creating. 

> helm create [NAME]

```
If you are doing this for the first time, great. But there is an 
example chart already set up for you .... so continue reading.
```

## Verify your chart

With this installed now you can point your command prompt to the ./helm directory. That directory contains an example HELM chart already in the ./helm/example folder. 

With the command prompt in the ./helm folder enter the followign command:

> helm template example example

This will dump out the generated YAML files with all of the fills from the values.yaml file. 

## Deploy your chart

> <b>NOTE:</b> HELM assumes your kubectl context is correct. Ensure you are pointing at the right AKS cluster with kubectl. See [the AKS doc](./AKS.md) for kubectl context. 

> <b>NOTE:</b> You will also need to modify the ./helm/example/values.yaml to point to the repository in your ACR and the secret name you created in your AKS. Details for those can also be found in [the AKS doc](./AKS.md). 

Once you are satisfied with the output from HELM, you can install it on your AKS cluster. 

To do this, you use the [helm install](https://helm.sh/docs/helm/helm_install/) command and tell it which of the values files (we have only one right now) to use. You can have different values files for different deployments:

> helm install -f ./example/values.yaml example ./example

### Verify it worked....
Now you can use the Azure Portal or kubectl to ensure it worked. 

> kubectl get deployments

- Does it show up?
- Does it have the correct number of pods?

> kubectl get services

- Do you have a service (named from the values file?)
- Does it have an external IP? 

<sub><b>Note</b>You can also see this information with _kubectl get all_ </sub>

> helm list

Shows you your deployments with HELM with name and version.

> helm history example

Shows you your deployment information. 

### Uninstall it 
To remove the deployment as a whole from AKS run 

> helm uninstall example

At this point *helm list* will return nothing and *helm history example* will have an error. You can also re-run the kubectl commands and see that it's gone.  


# Learning
- [6 Minute Read Intro](https://medium.com/prodopsio/a-6-minute-introduction-to-helm-ab5949bf425)
    - OK but a little outdated
- [Beginners Intro Video](https://www.youtube.com/watch?v=5_J7RWLLVeQ)
    - Ok, decent intro and walk through about 30 minutes
    - [Github Repo](https://github.com/marcel-dempers/docker-development-youtube-series/tree/master/kubernetes)
- [Written Tutorial](https://www.freecodecamp.org/news/what-is-a-helm-chart-tutorial-for-kubernetes-beginners/amp/)
    - Also ok
- [Chart Developers Guide](https://helm.sh/docs/chart_template_guide/)
    - Actual HELM doc guide
- [Microsoft Free Learning - Helm](https://docs.microsoft.com/en-us/learn/modules/aks-app-package-management-using-helm/?WT.mc_id=containers-19838-ludossan)
    - Microsoft Learning free on Helm - full lifecylce simple demo

https://github.com/marcel-dempers/docker-development-youtube-series/blob/master/kubernetes/helm/example-app/templates/service.yaml