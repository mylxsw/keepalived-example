# Keepalived & LVS 实现高可用负载均衡

本仓库为 [Keepalived & LVS 实现高可用负载均衡]() 一文的示例。

执行下面命令即可一键创建四个虚拟机，并且配置好主备关系的Keepalived服务和web服务的负载均衡。

    make create

销毁示例使用下面命令

    make destroy
