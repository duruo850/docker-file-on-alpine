This image is for nginx base on alpine3.8


docker pull duruo850/nginx:1.14.0_alpine3.8

docker build -t duruo850/nginx:1.14.0_alpine3.8 --no-cache .

docker tag duruo850/nginx:latest duruo850/nginx:X.Y.Z

docker push duruo850/nginx:1.14.0_alpine3.8


$ docker run --name my-nginx -v `pwd`/nginx.conf:/etc/nginx/nginx.conf -p 80:80  -d duruo850/nginx:1.14.0_alpine3.8