This image is a base image for Duruo850.io's set of tiny images. Currently, it's just the alpine OS image.

docker pull duruo850/base:alpine3.8

docker build -t duruo850/base:alpine3.8 --no-cache .

docker tag duruo850/base:latest duruo850/base:X.Y.Z

docker push duruo850/base
