This image is a base image for Duruo850.io's set of tiny images. Currently, it's just the alpine OS image.

Building this image

First, be sure to get the latest alpine:

docker pull alpine:3.8
Then build it:

docker build -t duruo850/base:3.8 --no-cache .
Tag it with Alpine version, run docker run --rm iron/base cat /etc/os-release to check version.

docker tag duruo850/base:latest duruo850/base:X.Y.Z
Push:

docker push iron/base
