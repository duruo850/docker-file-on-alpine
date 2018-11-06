FROM duruo850/base:alpine3.8

MAINTAINER Jay <zhanchenjin.2008@163.com>

ADD ./config.json /consul/config.json

RUN cd /bin \
    && wget https://releases.hashicorp.com/consul/1.3.0/consul_1.3.0_linux_amd64.zip  \
    && unzip consul_1.3.0_linux_amd64.zip \
    && chmod +x /bin/consul \
    && rm -rf consul_1.3.0_linux_amd64.zip

EXPOSE 8300 8301 8301/udp 8302 8302/udp 8400 8500 53 53/udp

VOLUME ["/consul/data", "/consul/config"]

ENTRYPOINT [ "/bin/consul", "agent", "-config-file=/consul/config.json", "-config-dir=/consul/config", "-ui"]

CMD [ ]
