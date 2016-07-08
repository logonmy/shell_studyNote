[TOC]

#apache server安装
## 检查是否存在httpd
rpm -qa | grep httpd
rpm -e --nodeps httpd*
##安装httpd
yum install -y httpd
chkconfig httpd on
service httpd start
##配置httpd
vim /etc/httpd/conf/httpd.conf

修改端口
修改网址目录
Listen 9011
DocumentRoot "/data/www/html"
<Directory "/data/www/html">
