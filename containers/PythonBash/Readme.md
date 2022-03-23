# Using arguments and environment in Docker

This example shows how to use argument (ARG) and environment variables (ENV) in a docker file. 

ARG is used within the script to replace things. 
ENV makes settings available to the actual container through the environment

Look at the Dockerfile file:

```text
ARG AZACCTARG="STG_ACCOUNT_HERE"
ARG AZACCTKEYARG="STG_ACCOUNT_KEY_HERE"

ENV AZACCT=${AZACCTARG}
ENV AZACCTKEY=${AZACCTKEYARG}
```

There are two ways to use these settings

# During docker build

When you build the container you can set ARG values

> docker build -t your/image --build-arg AZACCTARG=StgAccountName --build-arg AZACCTKEYARG=StgAccountKey .

When run, you will get output from the environment when run as:

> docker run your/image 

You will see
> AZACCT = StgAccountName

> AZACCTKEY = StgAccountKey

# During execution

When you run the container you can override ENV values

> docker run your/image -e "AZACCT=OverrideAccount" -e "AZACCTKEY=OverrideAccountKey"

You will see

> AZACCT = OverrideAccount

> AZACCTKEY = OverrideAccountKey

# Deployment YAML
You can also define environment overrides in a [YAML file](https://docs.docker.com/compose/environment-variables/#pass-environment-variables-to-containers) 

```yaml
    spec:
      nodeSelector:
        "kubernetes.io/os": linux
      containers:
      - name: firstpythonapi
        image: youracr.azurecr.io/your/image
        environment:
            - AZACCT=SomeValueHere
            - AZACCTKEY=AValueHere
        resources:
          requests:
            cpu: 100m
        ...
```

The side effect of the above is you can use a [HELM](../../docs/Helm.md) values file to override the settings if you set up the YAML to accept values from the .values data set. 

Then you can use BASH to deploy and write out the values.yaml file (or sed replace), then use BASH to launch the HELM Chart create then finally a *helm install* command making the script a one stop shop. 
