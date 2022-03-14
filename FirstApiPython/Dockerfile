FROM python:3.9

RUN mkdir /app
WORKDIR /app
ADD requirements.txt /app/
RUN pip install -r requirements.txt
ADD . /app/

RUN apt-get update \
        && apt-get install -y --no-install-recommends dialog \
        && apt-get update

#RUN apt-get update -y && \
#    apt-get install -y python-pip python-dev && \
#    pip install --upgrade pip

# We copy just the requirements.txt first to leverage Docker cache
#COPY ./requirements.txt /app/requirements.txt
#WORKDIR /app
#RUN pip install -r requirements.txt
#COPY . /app

ENTRYPOINT [ "python" ]
CMD [ "app.py" ]