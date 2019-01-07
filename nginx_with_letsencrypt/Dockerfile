FROM openresty/openresty:1.13.6.2-1-alpine


ADD nginx /usr/local/bin/nginx/
ADD letsencrypt /usr/local/bin/letsencrypt/
ADD supervisor/supervisord.conf /etc/
ADD run /usr/local/bin/

# alpine' cp、mv is a versiob of busybox，different from ubuntu, so install coreutils
RUN cd /usr/bin \
    && apk add --no-cache \
        coreutils \
        supervisor \
        curl \
        certbot \
    && chmod +x /usr/local/bin/run \
    && chmod a+x /usr/local/bin/letsencrypt/cert_generator \
    && chmod +x /usr/local/bin/nginx/conf_wapper

EXPOSE 80 443

WORKDIR /usr/local/openresty/

ENTRYPOINT [ "/usr/local/bin/run" ]

CMD [ ]
