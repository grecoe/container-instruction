FROM python:3.9

RUN mkdir /app
WORKDIR /app
ADD . /app/

RUN apt-get update \
        && apt-get install -y --no-install-recommends dialog \
        && apt-get update

ARG AZACCTARG="STG_ACCOUNT_HERE"
ARG AZACCTKEYARG="STG_ACCOUNT_KEY_HERE"

ENV AZACCT=${AZACCTARG}
ENV AZACCTKEY=${AZACCTKEYARG}

ENTRYPOINT [ "python" ]
CMD [ "app.py" ]