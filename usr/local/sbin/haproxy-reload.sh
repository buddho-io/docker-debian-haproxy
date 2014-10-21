#!/bin/sh

set -eu

iptables -I INPUT -p tcp --dport 3213 --syn -j DROP
sleep 1
supervisorctl restart haproxy:*
iptables -D INPUT -p tcp --dport 3213 --syn -j DROP
