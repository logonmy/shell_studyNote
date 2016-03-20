#!/bin/sh
auto_ssh_copy_id () {
    expect -c "set timeout -1;
                spawn ssh-copy-id $2;
                expect {
                    *(yes/no)* {send -- yes\r;exp_continue;}
                    *assword:* {send -- $1\r;exp_continue;}
                    eof        {exit 0;}
                }";
}
ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
while read line 
do
if echo ${line}| grep "#" > /dev/null
then
continue
fi
m_passwd=${line%=*}
m_hostname=${line#*=}
echo ${m_passwd} "" ${m_hostname}
auto_ssh_copy_id ${m_passwd} ${m_hostname}
done < sshnopasswd.cfg

