[TOC]
#linux下安装memcached
##下载
cd /usr/local/src
wget http://www.memcached.org/files/memcached-1.4.25.tar.gz
##准备
yum -y install libevent libevent-devel
##解压
rm -rf memcached-1.4.25
tar -xvf memcached-1.4.25.tar.gz
cd memcached-1.4.25
make clean
./configure --prefix=/usr/local/memcached
make && make install


##启动&停止

	/usr/local/memcached/bin/memcached -d -m 1024 -u cloudera -l 0.0.0.0 -p 9999 -c 1024 -P /tmp/memcached.pid
	-d选项是启动一个守护进程，
	-m是分配给Memcache使用的内存数量，单位是MB，我这里是10MB，
	-u是运行Memcache的用户，我这里是root，
	-l是监听的服务器IP地址
	-p是设置Memcache监听的端口，我这里设置了12000，最好是1024以上的端口，
	-c选项是最大运行的并发连接数，默认是1024，我这里设置了256，按照你服务器的负载量来设定，
	-P是设置保存Memcache的pid文件，我这里是保存在 /tmp/memcached.pid

	kill `cat /tmp/memcached.pid`

设置开机启动
vim /etc/rc.local
/usr/local/memcached/bin/memcached -d -m 1024 -u cloudera -l 0.0.0.0 -p 9999 -c 1024 -P /tmp/memcached.pid
	
##命令行交互

	<command name> <key> <flags> <exptime> <bytes>
	<data block>

	set a 0 0 4
	1234

	get a
	delete key
	stats

