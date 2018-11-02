FROM duruo850/base:alpine3.8


ADD ./lib    /lib/
ADD ./config /consul/config/
ONBUILD ADD ./config /consul/config/

RUN cd /bin && unzip /lib/consul_1.3.0_linux_amd64.zip && chmod +x /bin/consul

EXPOSE 8300 8301 8301/udp 8302 8302/udp 8400 8500 8600 8600/udp


VOLUME ["/consul/data", "/consul/config"]

ENTRYPOINT [ "/bin/consul", "agent", "-config-file=/consul/config.json", "-config-dir=/consul/config"]

CMD [  ]
