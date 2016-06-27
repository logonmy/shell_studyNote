[TOC]
#php编译安装

##php下载

	cd /usr/local/src
	wget http://cn2.php.net/distributions/php-7.0.7.tar.gz
	cd php-7.0.7

##准备

	yum -y install libxml2 libxml2-devel libpng libpng-devel
	

##编译
	#编译帮助
	./configure --help
	#编译
	./configure --prefix=/usr/local/php7 --with-apxs2=/usr/local/apache2/bin/apxs --with-gd
	make && make install
##配置

 	cp /usr/local/src/php-7.0.7/php.ini-development  /usr/local/php7/lib/php.ini


##apache+mysql支持
	./configure --prefix=/usr/local/php7 --with-apxs2=/usr/local/apache2/bin/apxs --with-gd --with-mysqli=/usr/local/mysql/bin/mysql_config
	make clean
	make && make install
	#cp /usr/local/src/php-7.0.7/php.ini-development  /usr/local/php7/lib/php.ini

	vim /usr/local/apache2/conf/httpd.conf
    php官网推荐
    告知 Apache 将特定的扩展名解析成 PHP，例如，让 Apache 将扩展名 .php 解析成 PHP。为了避免潜在的危险，例如上传或者创建类似 exploit.php.jpg 的文件并被当做 PHP 执行，我们不再使用 Apache 的 AddType 指令来设置。参考下面的例子，你可以简单的将需要的扩展名解释为 PHP。我们演示为增加.php。
    <FilesMatch "\.phps$">
    SetHandler application/x-httpd-php-source
	</FilesMatch>


###验证

	/usr/local/php7/bin/php -v
	/usr/local/apache2/bin/apachectl start


##错误
###libxml2
yum -y install libxml2 libxml2-devel
###png.h not found
yum -y install libpng libpng-devel
###libtool: link: `ext/date/php_date.lo' is not a valid libtool object


