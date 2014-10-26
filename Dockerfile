#
# HAProxy Dockerfile
#
# http://github.com/buddho-io/docker-debian-haproxy

FROM debian:jessie
MAINTAINER lance@buddho.io

ENV DEBIAN_FRONTEND noninteractive

# Install HAProxy
RUN apt-get update && apt-get upgrade -qqy && \
    apt-get install haproxy curl -qqy && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Confd
RUN curl -L https://github.com/kelseyhightower/confd/releases/download/v0.6.3/confd-0.6.3-linux-amd64 -o /usr/local/sbin/confd && \
    chmod 755 /usr/local/sbin/confd

# Add HAProxy default config
ADD etc/haproxy/haproxy.cfg /opt/etc/haproxy/haproxy.cfg

RUN mkdir -p /var/lib/haproxy && \
    chown -R haproxy:haproxy /var/lib/haproxy && \
    chmod 600 /opt/etc/haproxy/haproxy.cfg

EXPOSE 80
EXPOSE 443
EXPOSE 22002

CMD ["/usr/sbin/haproxy", "-f", "/opt/etc/haproxy/haproxy.cfg", "-p", "/var/run/haproxy.pid"]
