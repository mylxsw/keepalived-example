#!/usr/bin/env bash

PRIORITY=$1

# install keepalived & ipvsadm
yum install -y keepalived ipvsadm

# create keepalived configuration
echo "global_defs {
    router_id LVS_8808
}

vrrp_instance HA_WebServer {
    state MASTER
    ! 监听的网卡，keepalived会将VIP绑定到该网卡上
    interface eth1
    ! 虚拟路由器ID，同一个实例保持一致，多个实例不能相同
    virtual_router_id 18
    garp_master_refresh 10
    garp_master_refresh_repeat 2
    ! VRRP 优先顺序的设定值。在选择主节点的时候，该值大的备用 节点会优先漂移为主节点
    priority $PRIORITY
    ! 发送VRRP通告的间隔。单位是秒
    advert_int 1

    ! 集群授权密码
    authentication {
        auth_type PASS
        auth_pass 123456
    }

    ! 这里是我们配置的VIP，可以配置多个，每个IP一行
    virtual_ipaddress {
         192.168.88.100/24
    }
}

virtual_server 192.168.88.100 80 {
    ! 健康检查的时间间隔
    delay_loop 6
    ! 负载均衡算法
    lb_algo wlc
    ! LVS模式，支持NAT/DR/TUN模式
    lb_kind DR
    protocol TCP
    nat_mask 255.255.255.0

    ! 真实Web服务器IP，端口
    real_server 192.168.88.10 80 {
        weight 3
        ! Web服务健康检查
        HTTP_GET {
            url {
                path /
                status_code 200
            }
           connect_timeout 1
        }
    }

    ! 真实Web服务器IP，端口
    real_server 192.168.88.11 80 {
        weight 3
        ! Web服务健康检查
        HTTP_GET {
            url {
                path /
                status_code 200
            }
           connect_timeout 1
        }
    }
}" > /etc/keepalived/keepalived.conf

systemctl enable keepalived
systemctl start keepalived

