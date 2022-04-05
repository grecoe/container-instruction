FROM python:3.9

RUN mkdir /app
WORKDIR /app
ADD requirements.txt /app/
RUN pip install -r requirements.txt
ADD . /app/

RUN apt-get update \
        && apt-get install -y --no-install-recommends dialog \
        && apt-get update

ENTRYPOINT [ "python" ]
CMD [ "app.py" ]