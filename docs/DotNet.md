# DOTNet Docker Container

The DotNet example uses a simple web api with no authentication or HTTPS. 


# Building
- Move CMD prompt to FirstApi folder
- Build it 
    > dotnetbuild
- Run it
    > dotnet run
- Open the browser and hit [endpoint]/weatherforecast


# Local Docker
- Install DockerDesktop from hub.docker.com and run in Linux container mode.
    > docker build -t [youraliasorhubname]/firstapi .
- Install the Docker VSCode plugin 
- Run the Docker Container
    > docker run -p 8080:80 anddang/firstapi
- Open your browser and go to 
    > http://localhost:8080/weatherforecast

# Docker Hub / Azure Container Instance
- Get yourself a hub.docker.com account.
- Re-open Docker Destop and make sure you are logged into your account
- Push the container to docker hub
    > docker push anddang/firstapi
- Create an Azure container instance that uses your image then open a browser to
    > http://[your_service_name].[your_region].azurecontainer.io/weatherforecast

# Find info about your conainer in Azure
See the log
> az container logs --resource-group [your_rg] --name [your_service]

See info about the service

> az container show --resource-group [your_rg] --name [your_service]

[Azure Container CLI](https://docs.microsoft.com/en-us/cli/azure/container?view=azure-cli-latest) reference.