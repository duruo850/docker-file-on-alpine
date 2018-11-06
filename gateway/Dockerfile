FROM openresty/openresty:1.13.6.2-1-alpine

ADD ./nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
ADD ./nginx.ctpl /usr/local/openresty/nginx/conf/nginx.ctpl
ADD ./supervisord.conf /etc/supervisord.conf
ADD ./lua/auth /usr/local/openresty/lualib/auth
ADD ./lua/http /usr/local/openresty/lualib/resty


ENV CONSUL_URL 192.168.1.136:8500
ENV CONSUL_TEMPLATE_VERSION 0.19.5


RUN cd /usr/bin \
    && wget
    && curl -fSL https://releases.hashicorp.com/consul-template/0.19.5/consul-template_$CONSUL_TEMPLATE_VERSION_linux_amd64.zip -o consul-template.zip \
    && unzip consul-template.zip \
    && chmod +x consul-template
    && rm -rf consul-template.zip


EXPOSE 80 443

ENTRYPOINT [ "supervisord -n"]

CMD [ ]
