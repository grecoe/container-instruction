# Getting Started

You need a few things before you get started.

## Docker Hub Account

Go to [Docker Hub](https://hub.docker.com/) and 

1. Create a free account
    - You need to provide a name. This name is prepended to all of the repositories you will make, i.e. containers in the form [name]/[container]
2. Download Docker Desktop and install it
    - Once started log in to your Docker Hub account and ensure you set containers to Linux

You can then figure out what registry you are in by running:
> docker system info 

And you *should* have an entry for Registry that looks something like this: 

> https://index.docker.io/v1/

## Logging in
You can change your registry using the standard [__docker login__](https://docs.docker.com/engine/reference/commandline/login/) command

## VS Code Plugin
You can do all of your work within VS Code or Visual Studio. I've chosen VS Code because it's much more lightweight than Visual Studio....but doesn't come with all of the templates. 

In VS Code install the Docker Plugin which will allow you to see your containers and have the ability to start/stop them. 