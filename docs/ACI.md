# Azure Container Instances

The fastest way to test your container in Azure is to use an Azure Container Instance. Follow the instructions in the [containers](./Containers.md) document to create a container and push it to Docker Hub.

1. Log into the Azure Portal
2. Create a new resource of Container Instances type
3. Choose your sub and resource group
4. Under Image Source choose "Other Registry" and for "Image" enter in the settings [dockerhubname]/[image_name], it will look up the image for you. 
5. On the Networking tab, give it a DNS name and ensure the Port is 80.
    - Note, if you chnage the port in the dotnet Dockerfile or in the Flask application you will have to modify that port setting. 
6. Review and Create and wait for it to finish

Now you've created an Azure Container instance with your image. You can test the endpoint by going to the container instance you just created and on the Overview page get the FQDN 

Remember, NEITHER of the containers we've created have a certificate so no TLS/HTTPS connections will work. 

## .NET Container Test
In your browser navigate to:
> http://[FQDN]/weatherforecast

You will get a JSON object displayed with some mock weather information. 

## Python Flask Test
In your browser navigate to:
> http://[FQDN]

You will get some plain text displayed indicating it came from your Flask app.