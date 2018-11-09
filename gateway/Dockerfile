FROM openresty/openresty:1.13.6.2-1-alpine

ADD nginx/nginx.conf /usr/local/openresty/nginx/conf/
ADD lua/auth /usr/local/openresty/lualib/auth
ADD lua/http /usr/local/openresty/lualib/resty
ADD consul_template/nginx.ctpl /tmp/consul_template/
ADD consul_template/nginx_https.ctpl /tmp/consul_template/
ADD consul_template/consul_handler /usr/local/bin/
ADD letsencrypt/cert_generator /usr/local/bin/
ADD supervisor/supervisord.conf /etc/
ADD run /usr/local/bin/


ENV CONSUL_URL 192.168.1.136:8500
ENV CONSUL_TEMPLATE_VERSION 0.19.5
ENV TEMPLATE "/tmp/consul_template/nginx.ctpl:/tmp/consul_template/nginx.conf:/usr/local/bin/consul_handler"
ENV HTTPS 1
ENV DOMAIN "my.domain"
ENV EMAIL "my.email@my.domain"

# alpine' cp、mv is a versiob of busybox，different from ubuntu, so install coreutils
RUN cd /usr/bin \
    && apk add --no-cache \
        coreutils \
        supervisor \
        curl \
        certbot \
    && curl -fSL https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip -o consul-template.zip \
    && unzip consul-template.zip \
    && chmod +x consul-template \
    && rm -rf consul-template.zip \
    && chmod +x /usr/local/bin/run \
    && chmod +x /usr/local/bin/consul_handler \
    && chmod +x /usr/local/bin/cert_generator

EXPOSE 80 443

VOLUME [ "/usr/local/openresty/nginx/conf" , "/usr/local/openresty/lualib/auth/", "/etc/letsencrypt"]

ENTRYPOINT [ "/usr/local/bin/run" ]

CMD [ ]
