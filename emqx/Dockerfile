FROM duruo850/base:alpine3.8

MAINTAINER Jay <zhanchenjin.2008@163.com>

ADD emqx.conf /tmp
ADD emqx_auth_http.conf /tmp
ADD run /usr/local/bin/
ADD tuning /usr/local/bin/

RUN set -ex \
    && cd /usr/local/bin \
    # add build deps, remove after build
    && apk --no-cache add --virtual .build-deps \
        build-base \
        bsd-compat-headers \
        perl \
        erlang \
        erlang-public-key \
        erlang-syntax-tools \
        erlang-erl-docgen \
        erlang-observer \
        erlang-ssh \
        erlang-cosfiletransfer \
        erlang-runtime-tools \
        erlang-os-mon \
        erlang-tools \
        erlang-cosproperty \
        erlang-common-test \
        erlang-dialyzer \
        erlang-edoc \
        erlang-otp-mibs \
        erlang-crypto \
        erlang-costransaction \
        erlang-odbc \
        erlang-inets \
        erlang-asn1 \
        erlang-snmp \
        erlang-erts \
        erlang-et \
        erlang-cosnotification \
        erlang-xmerl \
        erlang-coseventdomain \
        erlang-stdlib \
        erlang-diameter \
        erlang-hipe \
        erlang-ic \
        erlang-eunit \
        erlang-mnesia \
        erlang-erl-interface \
        erlang-sasl \
        erlang-jinterface \
        erlang-kernel \
        erlang-orber \
        erlang-costime \
        erlang-dev \
        erlang-eldap \
        erlang-reltool \
        erlang-debugger \
        erlang-ssl \
        erlang-megaco \
        erlang-parsetools \
        erlang-cosevent \
        erlang-compiler \
    # add fetch deps, remove after build
    && apk add --no-cache --virtual .fetch-deps \
        git \
        wget \
    # add run deps, never remove
    && apk add --no-cache --virtual .run-deps \
        ncurses-terminfo-base \
        ncurses-terminfo \
        ncurses-libs \
        readline \
    # add latest rebar
    && git clone -b X https://github.com/emqx/emqx-rel.git emqx-rel \
    && cd emqx-rel && make \
    && cd _rel/emqx && ./bin/emqx console \
    # removing fetch deps and build deps
    && apk --purge del .build-deps .fetch-deps \
    && rm -rf /var/cache/apk/* \
    && mv /tmp/emqx.conf  /usr/local/bin/emqx/etc/  \
    && mv /tmp/emqx_auth_http.conf  /usr/local/bin/emqx/etc/plugins/ \
    && chmod +x /usr/local/bin/run \
    && chmod +x /usr/local/bin/tuning

# emqx will occupy these port:
# - 1883 port for MQTT
# - 8883 port for MQTT(SSL)
# - 8083 for WebSocket/HTTP
# - 8084 for WSS/HTTPS
# - 8080 for mgmt API
# - 18083 for dashboard
# - 4369 for port mapping
# - 6000-6999 for distributed node
EXPOSE 1883 8883 8083 8084 8080 18083 4369 6000-6999

WORKDIR /usr/local/bin

VOLUME ["/usr/local/bin/emqx"]

ENTRYPOINT [ "run" ]

CMD [ ]





