# EMQ Docker

*EMQ* (Erlang MQTT Broker) is a distributed, massively scalable, highly extensible MQTT message broker written in Erlang/OTP.


### Build emq

You can build this docker image by yourself.

```bash
docker build -t duruo850/emq_tuning:2.3.11 --no-cache .
```

### Environment variables

- `EMQ_ADMIN_PASSWORD`: emq admin password 

- `EMQ_LOADED_PLUGINS`: default plugins emq loaded , default is "emq_auth_http,emq_auth_username"

- `EMQ_AUTH_HTTP_URL`: http auth url, example http://127.0.0.1:8080/mqtt/auth

### Run emq

Execute some command under this docker image

```
docker run -d --privileged --name emq \
        -p 1883:1883  -p 8080:8080 -p 8083-8084:8083-8084 -p 8883:8883 -p 18083:18083  -p 4369:4369 -p 6000-6100:6000-6100 \
        -e EMQ_ADMIN_PASSWORD="123456" \
        -e EMQ_LOADED_PLUGINS="emq_auth_http,emq_auth_username"\
        -e EMQ_AUTH__HTTP__AUTH-REQ="http://127.0.0.1:8080/mqtt/auth"
        -v `pwd`/emq.conf:/etc/emq.conf \
        duruo850/emq_tuning:2.3.11
```



> REMEMBER: DO NOT RUN EMQ DOCKER PRIVILEGED OR MOUNT SYSTEM PROC IN CONTAINER TO TUNE LINUX KERNEL, IT IS UNSAFE.
