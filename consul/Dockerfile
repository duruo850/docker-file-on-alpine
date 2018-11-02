FROM duruo850/base:alpine3.8


ADD ./lib/consul_1.3.0_linux_amd64.zip    /lib/consul.zip
ADD ./config/config.json /consul/config.json

RUN cd /bin && unzip /lib/consul.zip && chmod +x /bin/consul && rm -rf /lib/consul.zip

EXPOSE 8300 8301 8301/udp 8302 8302/udp 8400 8500 53 53/udp

VOLUME ["/consul/data", "/consul/config"]

ENTRYPOINT [ "/bin/consul", "-config-file=/consul/config.json", "-config-dir=/consul/config"]

CMD ["agent",  "-ui"]
