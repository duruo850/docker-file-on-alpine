FROM openresty/openresty:1.13.6.2-1-alpine


ADD nginx /usr/local/bin/nginx/
ADD consul_template /usr/local/bin/consul_template/
ADD letsencrypt /usr/local/bin/letsencrypt/
ADD lua/auth /usr/local/openresty/lualib/auth
ADD lua/http /usr/local/openresty/lualib/resty
ADD supervisor/supervisord.conf /etc/
ADD run /usr/local/bin/


ENV CONSUL_URL 192.168.1.136:8500
ENV CONSUL_TEMPLATE_VERSION 0.19.5
ENV TEMPLATE "/usr/local/bin/consul_template/nginx.ctpl:/tmp/nginx.conf.gen:/usr/local/bin/consul_template/consul_handler"

# alpine' cp、mv is a versiob of busybox，different from ubuntu, so install coreutils
RUN cd /usr/bin \
    && apk add --no-cache \
        coreutils \
        supervisor \
        curl \
        certbot \
    && curl -fSL https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip -o consul-template.zip \
    && unzip consul-template.zip \
    && rm -rf consul-template.zip \
    && chmod +x consul-template \
    && chmod +x /usr/local/bin/run \
    && chmod +x /usr/local/bin/consul_template/consul_handler \
    && chmod a+x /usr/local/bin/letsencrypt/cert_generator \
    && chmod +x /usr/local/bin/nginx/conf_wapper

EXPOSE 80 443

WORKDIR /usr/local/bin

ENTRYPOINT [ "run" ]

CMD [ ]
