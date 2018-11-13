# Introduction

https://hub.docker.com/r/library/redis/

data is stored in the VOLUME /data

# build

docker build -t duruo850/duruo850/redis:5.0.1-alpine3.8 --no-cache .


# Environment variables

- `REDIS_PASSWORD`: The password for the redis security

# Example usage: 

## Common


```
docker run --name redis -d --restart=always -p 6379:6379 -e REDIS_PASSWORD='rdspwd11131456' duruo850/redis:5.0.1-alpine3.8
```

## Command-line arguments

You can customize the launch command of Redis server by specifying arguments to `redis-server` on the `docker run` command. For example the following command will enable the Append Only File persistence mode:

```
docker run --name redis -d --restart=always -p 6379:6379 \
    -v /srv/redis/config/redis.conf:/usr/local/bin/redis.conf \
    -v /srv/redis/data:/data \
     duruo850/redis:5.0.1-alpine3.8
```

Please refer to http://redis.io/topics/config for further details.

## Authentication

To secure your Redis server with a password, specify the password in the `REDIS_PASSWORD` variable while starting the container.

```
docker run --name redis -d --restart=always -p 6379:6379 \
  -e REDIS_PASSWORD=redispassword \
  --restart=always \
  -v /srv/redis/data:/data \
  duruo850/redis:5.0.1-alpine3.8
```

Clients connecting to the Redis server will now have to authenticate themselves with the password `redispassword`.

 