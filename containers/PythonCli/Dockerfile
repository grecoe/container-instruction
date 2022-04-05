# Python seems to be included in this image, but having two FROM lines
# side by side seemed to be an issue. 

FROM mcr.microsoft.com/azure-cli:latest

RUN mkdir /app
WORKDIR /app
ADD requirements.txt /app/
RUN pip install -r requirements.txt
ADD . /app/

# Environment variables to set when launching either using docker -e or with az container
# https://docs.microsoft.com/en-us/azure/container-instances/container-instances-environment-variables
ENV AZURE_SUBSCRIPTION="your_sub_id"
ENV EXPERIENCE_LABRG="experiencelab-yourname"

CMD ["bash", "dockerscript.sh"]