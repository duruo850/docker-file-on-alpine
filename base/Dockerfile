FROM alpine:3.8

MAINTAINER Jay <zhanchenjin.2008@163.com>

RUN apk update && apk upgrade \
  && apk add --no-cache \
        coreutils \
        ca-certificates \
  && rm -rf /var/cache/apk/*
