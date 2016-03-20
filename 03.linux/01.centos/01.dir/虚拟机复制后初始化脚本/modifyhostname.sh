#!/bin/sh
##eval `cat ./init.cfg`
source ./init.cfg
if grep -Fq "${m_ip}" /etc/hosts
then
echo "${m_ip}has exists,do nothing"
else
echo "${m_ip} not exists,append to /etc/hosts"
echo ${m_ip} "" ${m_hostname}>> /etc/hosts
fi
hostname ${m_hostname}
sed -i "s#^HOSTNAME=.*#HOSTNAME=${m_hostname}#g" /etc/sysconfig/network
