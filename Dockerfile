#
# HAProxy Dockerfile
#
# http://github.com/buddho-io/docker-debian-haproxy

FROM buddho/debian-supervisord
MAINTAINER lance@buddho.io

# Install HAProxy
RUN apt-get update && apt-get install haproxy -y && apt-get clean && rm -rf /var/lib/apt/lists/*

# Add Confd config
ADD etc/confd/conf.d /etc/confd/conf.d

# Add supervisord config
ADD etc/supervisor/conf.d /etc/supervisor/conf.d

# Add HAProxy default config
ADD etc/haproxy/haproxy.cfg /opt/etc/haproxy/haproxy.cfg

RUN mkdir -p /var/lib/haproxy && chown -R haproxy:haproxy /var/lib/haproxy && \
    mkdir /var/log/haproxy && chown -R haproxy:haproxy /var/log/haproxy

EXPOSE 80
EXPOSE 443
EXPOSE 22002


