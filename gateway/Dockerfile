FROM openresty/openresty:1.13.6.2-1-alpine

ADD nginx.ctpl /tmp/nginx.ctpl
ADD nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
ADD supervisord.conf /etc/supervisord.conf
ADD lua/auth /usr/local/openresty/lualib/auth
ADD lua/http /usr/local/openresty/lualib/resty
ADD consul_handler /usr/local/bin/
ADD run /usr/local/bin/


ENV CONSUL_URL 192.168.1.136:8500
ENV CONSUL_TEMPLATE_VERSION 0.19.5
ENV TEMPLATE "/tmp/nginx.ctpl:/tmp/nginx.conf:/usr/local/bin/consul_handler"

# alpine自带的cp, mv是busybox的版本，和ubuntu有些区别，所以安装coreutils
RUN cd /usr/bin \
    && apk add --no-cache \
        coreutils \
        supervisor \
        curl \
    && curl -fSL https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip -o consul-template.zip \
    && unzip consul-template.zip \
    && chmod +x consul-template \
    && rm -rf consul-template.zip \
    && chmod +x /usr/local/bin/run \
    && chmod +x /usr/local/bin/consul_handler

EXPOSE 80 443

ENTRYPOINT [ "/usr/local/bin/run" ]

CMD [ ]
