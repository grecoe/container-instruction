# .Net Docker Container

The DotNet example uses a simple web api with no authentication or HTTPS. 

> To ensure you don't have auth problems when you deploy, ensure you go to the Startup.cs file and comment out the lines in Configure() for UseHttpRedirection and UseAuthorization. 

## Building and Testing the API
- Open a CMD prompt and navigate to the ./FirstApi folder
- Build it with dotnet 
    > dotnetbuild
- Run it with dotnet
    > dotnet run
- Open the browser and hit [endpoint]/weatherforecast where *endpoint* is defined in the debug output but *localhost* should work. 


# Local Docker
To buld and run in your local docker instance review the [Build Conatainers](./BuildContainers.md) page. It will give all of the details on how to build, run and test your .NET Container on your local Docker instance. 


# Docker Hub / Azure Container Instance
- Get yourself a hub.docker.com account.
- Re-open Docker Destop and make sure you are logged into your account
- Push the container to docker hub
    > docker push [dockerhubname]/[image_name]
- Create an Azure container instance that uses your image then open a browser to
    > http://[your_service_name].[your_region].azurecontainer.io/weatherforecast
