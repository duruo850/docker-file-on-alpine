# nginx with letsencrypt
    
    给予letsencryt的nginx镜像。

# 相关路径
    
    letsencrypt：
    
        证书路径： /etc/letsencrypt
        
        日志路径： /var/log/letsencrypt/letsencrypt.log
 
# 构建   
    
    docker build -t duruo850/nginx_with_letsencrypt:1.0.0 --no-cache .
    
# 环境变量

    DOMAIN "my.domain" , https证书的域名，如果有此变量，会自动采用https的方式，并且自动生成证书
    
    EMAIL "my.email@my.domain"， https证书生成必须参数
    
# 启动
    docker run -d -p 80:80 -p 443:443 \
        -e CONSUL_URL="192.168.1.136:8500" \
        -e DOMAIN=my.domain \
        -e EMAIL=my.email@my.domain \
        -v `pwd`/nginx.conf:/usr/local/openresty/nginx/conf/nginx.conf \
        -v `pwd`/lua/auth/auth.lua:/usr/local/openresty/lualib/auth/auth.lua \
        duruo850/gateway:1.0.0
        
    -v /etc/letsencrypt:/etc/letsencrypt
 
# 实现
#### 技术
    OpenResty（nginx+lua）：一个基于 Nginx 与 Lua 的高性能 Web 平台，其内部集成了大量精良的 Lua 库、第三方模块以及大多数的依赖项。用于方便地搭建能够处理超高并发、扩展性极高的动态 Web 应用、Web 服务和动态网关。  
    OpenResty 通过汇聚各种设计精良的 Nginx 模块（主要由 OpenResty 团队自主开发），从而将 Nginx 有效地变成一个强大的通用 Web 应用平台。这样，Web 开发人员和系统工程师可以使用 Lua 脚本语言调动 Nginx 支持的各种 C 以及 Lua 模块，快速构造出足以胜任 10K 乃至 1000K 以上单机并发连接的高性能 Web 应用系统。  
    
#### 实现细节
1、基于nginx对外提供http、websocket服务；  
