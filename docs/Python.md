# Python Flask Docker Container

The Python example uses a simple web Flask api with no authentication or HTTPS. 


## Building and Testing the API
- Open up a command prompt and point it to the ./FirstApiPython folder
- Create a conda environment to run with Flask
    > conda env create -f environment.yml
- Run the conda environment
    > conda activate FlaskApiEnv
- Run the app itself
    > python app.py

You will be presented with a URL that the API is running on, it should be equivalent to *localhost*. If you have issues, you can modify the port being used in app.py because 80 might be problematic locally. 

Since there is only a get with no path info, a simple get on the endpoint wil prsent results.

# Local Docker
To buld and run in your local docker instance review the [Build Conatainers](./BuildContainers.md) page. It will give all of the details on how to build, run and test your Python Container on your local Docker instance. 


# Docker Hub / Azure Container Instance
- Get yourself a hub.docker.com account.
- Re-open Docker Destop and make sure you are logged into your account
- Push the container to docker hub
    > docker push [dockerhubname]/[image_name]
- Create an Azure container instance that uses your image then open a browser to
    > http://[your_service_name].[your_region].azurecontainer.io/
