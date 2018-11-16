FROM duruo850/emq:2.3.11

MAINTAINER Jay <zhanchenjin.2008@163.com>

COPY ./emq.conf /opt/emqttd/etc/
COPY ./tuning /opt/emqttd/
COPY ./run /opt/emqttd/


CMD [ "run" ]
