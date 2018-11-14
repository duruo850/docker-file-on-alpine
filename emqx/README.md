# EMQ Docker

*EMQ* (Erlang MQTT Broker) is a distributed, massively scalable, highly extensible MQTT message broker written in Erlang/OTP.


### Build emqx

You can build this docker image by yourself.

```bash
docker build -t duruo850/emqx:3.0_alpine3.8 --no-cache .
```

### Environment variables

- `EMQ_ADMIN_PASSWORD`: emq admin password 

- `EMQ_LOADED_PLUGINS`: default plugins emq loaded , default is "emqx_auth_http,emqx_auth_username"

- `EMQ_AUTH_HTTP_URL`: http auth url, example http://127.0.0.1:8080/mqtt/auth

### Run emqx

Execute some command under this docker image

```
docker run -d  --name emqx \
        -p 1883:1883  -p 8080:8080 -p 8083-8084:8083-8084 -p 8883:8883 -p 18083:18083  -p 4369:4369 -p 6000-6100:6000-6100 \
        -e EMQ_ADMIN_PASSWORD="123456" \
        -e EMQ_LOADED_PLUGINS="emqx_auth_http,emqx_auth_username"\
        -e EMQ_AUTH_HTTP_URL="http://127.0.0.1:8080/mqtt/auth"
        -v `pwd`/emqx.conf:/etc/emqx.conf \
        -v `pwd`/emqx_auth_http.conf: /etc/plugins/emqx_auth_http.conf \
        duruo850/emqx:3.0_alpine3.8
```

The emqtt erlang broker runs as linux user `emqx` in the docker container.



> REMEMBER: DO NOT RUN EMQ DOCKER PRIVILEGED OR MOUNT SYSTEM PROC IN CONTAINER TO TUNE LINUX KERNEL, IT IS UNSAFE.
