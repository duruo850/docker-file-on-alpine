FROM alpine:3.8

MAINTAINER Jay <zhanchenjin.2008@163.com>

# alpine' cp、mv is a versiob of busybox，different from ubuntu, so install coreutils
RUN apk update && apk upgrade \
  && apk add --no-cache \
        coreutils \
        ca-certificates \
  && rm -rf /var/cache/apk/*
