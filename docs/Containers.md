# Docker Containers

Once you have followed the Getting Started directions by getting a Docker Hub account and installing Docker Desktop it's time to start building a container. 

Regardless of *which* container you are going to build in this repository, these instructions will work.

# Build Local Container
- Open the command prompt/bash shell and navigate to either /FirstApi (.NET API) or /FirstApiPython (Flask API) depending on what you want to play with.

- Build your container  
    - *dockerhubname* is the name of your dockerhub user which you *shoud* use to tag all your images.
    - *image_name* the name of the thing you are building, it can be what you like but *should* be relevant to what you are building. 
    > docker build -t [dockerhubname]/[image_name] .
- Run the following command to ensure that you have created a repository with the build command, or updated a repository. 
    > docker images
- You can also delete an image with the following command. You can get the images on your instance with the command *docker images* to get the id.
    > docker rmi [image_id]

# Run the Docker Container Locally
The [docker run](https://docs.docker.com/engine/reference/commandline/run/) command has a few options, but for this example we will keep it simple. 

The architecture of the command is
> docker run -p [local_port]:[exposed_port] [dockerhubname]/[image_name]

|Field|Purpose|
|----|----|
|local_port|This is the port on your local machine you want to connect to the container with.|
|exposed_port|This is the port exposed by your container. For .NET this port is defined in the Dockerfile. For the Python Flask example, it is exposed in the app.run(...) call.|
|dockerhubname|This is the alias you used when creating the image.|
|image_name|This is the name you gave the image.|

## Testing
For either of the containers created, you can test that they are running by navigating in your local web browser to:

### DotNet
http://localhost:[local_port]/weatherforecast

### Python
http://localhost:[local_port]

## Push container to DockerHub
Once you've built the container locally it's time to push it to DockerHub so it can be consumed. 

From the command line run the following command:
> docker push [dockerhubname]/[image_name]

Go to [DockerHub](https://hub.docker.com) and you should see a repository with the container you pushed. 

## Container Query with Docker

List all containers regardless of state
> docker container ls -a

See running containers with either command
> docker ps
> docker container ls

Stop your container
> docker stop [container_id_from_above_command]

[Delete](https://docs.docker.com/engine/reference/commandline/container_prune/) containers with one of the following.
> docker container prune
or 
> docker container rm [container_id_from_above_command]


