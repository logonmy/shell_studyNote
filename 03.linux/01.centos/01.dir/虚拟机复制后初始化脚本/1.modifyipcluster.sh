#!/bin/sh
while read line
do
m_hostname=${line%=*}
m_ip=${line#*=}
echo $m_hostname "" $m_ip

echo "check ${m_ip} is exists"
if grep -Fq "${m_ip}" /etc/hosts
then
echo "${m_ip} has exists do nothing"
else
echo "${m_ip} has not exits ,append to /etc/hosts"
echo ${m_ip} "" ${m_hostname}>> /etc/hosts
fi

done < ipcluster.cfg
