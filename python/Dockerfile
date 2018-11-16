FROM python:3.7.1-alpine3.8
COPY requirements.txt /usr/local/bin/requirements.txt


# alpine' cp、mv is a versiob of busybox，different from ubuntu, so install coreutils
RUN apk update && apk upgrade \
  && apk add --no-cache \
        coreutils \
        libmysqld-dev \
        libssl-dev \
        mysql-client \
        libfreetype6-dev \
        libjpeg-dev \
        libxml2-dev libxslt-dev \
        python-yaml \
        python-lxml \
        libyaml-cpp-dev \
        libffi-dev libssl-dev
  && rm -rf /var/cache/apk/*  \
  && pip install -r /usr/local/bin/requirements.txt