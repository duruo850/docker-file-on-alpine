This image is for openresty base on alpine3.8


docker pull duruo850/openresty:1.13.6.2_alpine3.8

docker build -t duruo850/openresty:1.13.6.2_alpine3.8 --no-cache .

docker tag duruo850/openresty:latest duruo850/nginx:X.Y.Z

docker push duruo850/openresty:1.13.6.2alpine3.8


$ docker run --name my-openresty -v `pwd`/nginx.conf:/usr/local/openresty/nginx/conf/nginx.conf -p 80:80  -d duruo850/openresty:1.13.6.2_alpine3.8