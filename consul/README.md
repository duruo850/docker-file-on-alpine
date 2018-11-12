This image is a base image for Duruo850.io's set of tiny images. Currently, it's just the alpine OS image.


docker pull duruo850/consul:1.3.0_alpine3.8

docker build -t duruo850/consul:1.3.0_alpine3.8 --no-cache .

docker tag duruo850/consul:latest duruo850/consul:X.Y.Z

docker push duruo850/consul:1.3.0_alpine3.8


cluster--192.168.1.136(cluster), 192.168.1.165, 192.168.1.128:

    cluster: 

        sudo docker run -h node1 --name consul_server1 -d -v /consul/data:/consul/data   --restart=always    \
            -p 8300-8302:8300-8302 -p 8301-8302:8301-8302/udp  \
            duruo850/consul:1.3.0_alpine3.8 -server -bootstrap-expect 3 -advertise 192.168.1.136
        
        sudo docker run -h node2 --name consul_server2 -d -v /consul/data:/consul/data   --restart=always    -p   8300:8300  \
            -p 8300-8302:8300-8302 -p 8301-8302:8301-8302/udp  \
            duruo850/consul:1.3.0_alpine3.8 -server -advertise 192.168.1.165 -join  192.168.1.136
            
        sudo docker run -h node3 --name consul_server3 -d -v /consul/data:/consul/data  --restart=always  \
            -p 8300-8302:8300-8302 -p 8301-8302:8301-8302/udp \
            duruo850/consul:1.3.0_alpine3.8 -server -advertise 192.168.1.128 -join  192.168.1.136
            
        sudo docker run -h node4 --name consul_web -d -v /consul/data:/consul/data   --restart=always  \
            -p 8400:8400 -p 8500:8500 -p 8600:53 -p 8600:53/udp \
            duruo850/consul:1.3.0_alpine3.8 -advertise 192.168.1.168 -join  192.168.1.136
    
    web:
    
        http://192.168.1.168:8500
        
    register nginx servicewith multi different id :
    
        curl -X PUT -d '{"id": "nginx1","name": "nginx","address": "192.168.1.136","port": 80,"checks": [{"http": "http://192.168.1.136/","interval": "5s"}]}' http://127.0.0.1:8500/v1/agent/service/register
                
        curl -X PUT -d '{"id": "nginx2","name": "nginx","address": "192.168.1.165","port": 1080,"checks": [{"http": "http://192.168.1.165:1080","interval": "5s"}]}' http://127.0.0.1:8500/v1/agent/service/register
        
        curl -X PUT -d '{"id": "nginx3","name": "nginx","address": "192.168.1.128","port": 80,"checks": [{"http": "http://192.168.1.128/","interval": "5s"}]}' http://127.0.0.1:8500/v1/agent/service/register
        
    deregister  :
    
        curl -X PUT http://192.168.1.136:8500/v1/agent/service/deregister/{id}  
        
    get nginx service:
    
        http://192.168.1.136:8500/v1/catalog/service/nginx