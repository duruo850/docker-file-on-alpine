FROM duruo850/base:alpine3.8

MAINTAINER Jay <zhanchenjin.2008@163.com>


RUN  apk add --no-cache libssl-dev, zlib1g-dev

RUN cd /bin \
    && wget http://nginx.org/download/nginx-1.14.0.tar.gz  && tar  -zxvf nginx-1.14.0.tar.gz \
    && wget ftp://ftp.csx.cam.ac.uk/pub/software/programming/pcre/pcre-8.42.tar.gz  && tar  -zxvf pcre-8.42.tar.gz


RUN cd /bin/nginx-1.14.0 \
    && ./configure --with-pcre=../pcre-8.42 --with-http_ssl_module
    && make
    && make install

RUN rm -rf /bin/nginx-1.14.0.tar.gz /bin/pcre-8.42.tar.gz

VOLUME [ "/etc/nginx" ]

EXPOSE 80/tcp 443/tcp

ADD nginx.conf /etc/nginx/nginx.conf

ENTRYPOINT ["nginx"]
CMD ["-c", "/etc/nginx/nginx.conf"]
