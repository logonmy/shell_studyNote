[TOC]
#nginx安装
##检查是否安装nginx
rpm -qa | grep nginx
rpm -e --nodeps nginx*
##下载rpm包
wget http://nginx.org/packages/centos/6/x86_64/RPMS/nginx-1.8.1-1.el6.ngx.x86_64.rpm
##安装
	rpm -ivh nginx-1.8.1-1.el6.ngx.x86_64.rpm
	yum install nginx
	chkconfig nginx on
	service nginx start
##检查nginx是否安装成功

	whereis nginx
	nginx -v

##nginx配置

	vim /etc/nginx/nginx.conf
	vim /etc/nginx/conf.d/default.conf

