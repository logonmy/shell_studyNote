#!/bin/sh
source ./init.cfg
#删除MAC配置，拷贝的虚拟机原来的网卡会在该文件记录
rm -f /etc/udev/rules.d/70-persistent-net.rules
#替换内网IP
sed -i "s#^IPADDR=.*#IPADDR=${m_ip}#g" /etc/sysconfig/network-scripts/ifcfg-eth0
#替换外网IP
sed -i "s#^IPADDR=.*#IPADDR=${m_ext_ip}#g" /etc/sysconfig/network-scripts/ifcfg-eth1
