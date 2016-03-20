#!/bin/sh
source ./init.cfg
if id -u ${m_user} > /dev/null
then
    echo "${m_user} has exists"
else
    echo "${m_user} has not exists,add user and group"
groupadd ${m_user}
useradd -g ${m_user} -m ${m_user}
echo ${m_password} | passwd --stdin ${m_user}
fi
