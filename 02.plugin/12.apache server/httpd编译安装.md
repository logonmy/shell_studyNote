[TOC]

#httpd编译安装

##准备工作

	cd /usr/local/src
	#下载apr-1.5.2.tar.gz
	wget http://mirror.bit.edu.cn/apache/apr/apr-1.5.2.tar.gz
	#下载apr-util-1.5.4.tar.gz 
	wget http://mirror.bit.edu.cn/apache/apr/apr-util-1.5.4.tar.gz
	#下载httpd.2.4.20.tar.gz 
	wget http://mirrors.hust.edu.cn/apache/httpd/httpd-2.4.20.tar.gz
	tar -zxvf apr-1.5.2.tar.gz
	tar -zxvf apr-util-1.5.4.tar.gz
	tar -zxvf httpd-2.4.20.tar.gz

##编译
	#编译apr
	cd /usr/local/src/apr-1.5.2/
	./configure --prefix=/usr/local/apr
	make & make install
	cd /usr/local/src/apr-util-1.5.4/
	./configure --prefix=/usr/local/apr-util --with-apr=/usr/local/apr
	make & make install
	cd /usr/local/src/httpd-2.4.20
	make clean
	./configure --prefix=/usr/local/apache2 --with-apr=/usr/local/apr --with-apr-util=/usr/local/apr-util
	make & make install


##配置
	vim /usr/local/apache2/conf/httpd.conf
	#Listen
	#ServerName
	ServerName localhost:9000


##验证
	/usr/local/apache2/bin/apachectl start
	
	打开浏览器，输入http://webserver:9000/
	出现it works 即为安装成功

##问题

###AH00558: httpd: Could not reliably determine the server's fully qualified domain name, using 10.24.161.117. Set the 'ServerName' directive globally to suppress this message
配置servername
