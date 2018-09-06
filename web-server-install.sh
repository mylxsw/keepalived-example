#!/usr/bin/env bash

yum install -y yum-utils
yum-config-manager --add-repo https://openresty.org/package/centos/openresty.repo
yum install -y openresty

ip addr show eth1 | grep '192.168.88.' | awk '{print $2}' > /usr/local/openresty/nginx/html/index.html

systemctl enable openresty
systemctl start openresty

echo 'DEVICE=lo:0
IPADDR=192.168.88.100
NETMASK=255.255.255.255
ONBOOT=yes
NAME=loopback' > /etc/sysconfig/network-scripts/ifcfg-lo\:0

systemctl restart network
