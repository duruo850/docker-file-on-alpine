This image is a base image for Duruo850.io's set of tiny images. Currently, it's just the alpine OS image.


docker pull duruo850/cosule:1.3.0_alpine3.8

docker build -t duruo850/cosule:1.3.0_alpine3.8 --no-cache .

docker tag duruo850/cosule:latest duruo850/cosule:X.Y.Z

docker push duruo850/cosule:1.3.0_alpine3.8



sudo docker run -h node1 --name consul -d -v /data:/data   --restart=always    -p   8300:8300     -p   8301:8301/udp     -p   8302:8302     -p   8302:8302/udp     -p   8400:8400     -p   8500:8500 duruo850/cosule:1.3.0_alpine3.8 -server -bootstrap-expect 3 -advertise 192.168.1.136

sudo docker run -h node1 --name consul -d -v /data:/data   --restart=always    -p   8300:8300     -p   8301:8301/udp     -p   8302:8302     -p   8302:8302/udp     -p   8400:8400     -p   8500:8500 duruo850/cosule:1.3.0_alpine3.8 -server -advertise 192.168.1.165 -join  192.168.1.136
