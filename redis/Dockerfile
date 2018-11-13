FROM redis:5.0.1-alpine3.8
COPY redis.conf /usr/local/bin/redis.conf
ADD run /usr/local/bin/

# alpine' cp、mv is a versiob of busybox，different from ubuntu, so install coreutils
RUN apk update && apk upgrade \
  && apk add --no-cache \
        coreutils \
  && rm -rf /var/cache/apk/* \
  && chmod +x /usr/local/bin/run

WORKDIR /usr/local/bin

EXPOSE 6379/tcp

ENTRYPOINT [ "run" ]

CMD [ "redis-server", "/usr/local/bin/redis.conf" ]