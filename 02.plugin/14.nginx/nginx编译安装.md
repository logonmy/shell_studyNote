[TOC]

#nginx编译安装
##下载源码
http://nginx.org/download/nginx-1.10.1.tar.gz
##检查
rpm -qa | grep nginx
rpm -e --nodeps nginx*
##准备

	yum -y install gcc gcc-c++ autoconf automake
	yum -y install zlib zlib-devel openssl openssl-devel pcre-devel
	建立nginx 组
	groupadd -r nginx
	useradd -s /sbin/nologin -g nginx -r nginx
	id nginx

zlib:nginx提供gzip模块，需要zlib库支持  
openssl:nginx提供ssl功能  
pcre:支持地址重写rewrite功能  

##编译

	./configure \
	--prefix=/usr/local/nginx \
	--sbin-path=/usr/sbin/nginx \
	--conf-path=/etc/nginx/nginx.conf \
	--error-log-path=/var/log/nginx/error.log \
	--pid-path=/var/run/nginx/nginx.pid \
	--user=nginx \
	--group=nginx \
	--with-http_ssl_module \
	--with-http_flv_module \
	--with-http_gzip_static_module \
	--http-log-path=/var/log/nginx/access.log \
	--http-client-body-temp-path=/var/tmp/nginx/client \
	--http-proxy-temp-path=/var/tmp/nginx/proxy \
	--http-fastcgi-temp-path=/var/tmp/nginx/fcgi \
	--with-http_stub_status_module


	./configure \
	--prefix=/data/nginx \
	--sbin-path=/usr/sbin/nginx \
	--conf-path=/etc/nginx/nginx.conf \
	--with-http_ssl_module \
	--user=nginx \
	--group=nginx \

	make && make install

##配置

	server {
		listen 8888;
		server_name localhost;
		charset utf-8;
		access_log  logs/express.access.log  main;
		location / {
			root   html/express;
			index  index.html index.htm;
		}
	}
##开机启动
/usr/sbin/nginx
su cloudera -lc "/data/tomcat/startorshutdown/startup-8888.sh"
##问题
###没有make
yum -y install gcc automake autoconf libtool make
###"/var/tmp/nginx/client" failed (2: No such file or directory)
 mk -p /var/tmp/nginx/client

###端口被占用
netstat -tln | grep 80 
lsof -i :80


##定时移动日志？？
ngninx不能实现吗？

	#!/bin/bash
	#/data/nginx/logs
	#express
	base_path=$1 
	logname=$2
	month=$(date -d '+0 day' +"%Y%m")
	hour=$(date -d '-1 hour' +"%Y%m%d%H")
	mvdir=$base_path/$logname/$month
	mkdir -p ${mvdir}
	mv $base_path/${logname}.access.log ${mvdir}/${logname}.access.log.${hour}
	#kill -USR1 `cat ${base_path}/nginx.pid`
	/usr/sbin/nginx -s reopen

	定时任务
	Crontab 编辑定时任务
	00 * * * * /data/nginx/logs/autolog.sh /data/nginx/logs express 每天0时1分(建议在02-04点之间,系统负载小)