[TOC]

#centos6.5安装svnserver
##检查是否已存在svnserver
rpm -qa | grep subversion
rpm -e --nodeps subversion*
##安装subversion
yum install -y subversion
##配置subversion
	svn help
	#创建svn版本库目录
	mkdir -p /data/svn
	mkdir -p /data/svn/BigDataPlatform
	mkdir -p /data/svn/Payband

	svnadmin create /data/svn/BigDataPlatform
	svnadmin create /data/svn/Payband

	cp /data/svn/BigDataPlatform/conf/passwd /data/svn/passwd
	cp /data/svn/BigDataPlatform/conf/authz /data/svn/authz


	vim /data/svn/passwd
	[users]
	yuezhiqian = yzq123
	lilong = lilong123
	tangliang = tl123

	vim /data/svn/authz
	[groups]
	admin = yuezhiqian
	bigdata = yuezhiqian,lilong,tangliang
	[/]
	* =
	[BigDataPlatform:/]
	@bigdata = rw
	[Payband:/]
	yuezhiqian = rw

	vi /data/svn/BigDataPlatform/conf/svnserve.conf
	anon-access = none
	auth-access = write 
	password-db = ../../passwd
	authz-db = ../../authz
	realm = BigDataPlatform

	vi /data/svn/Payband/conf/svnserve.conf
	anon-access = none
	auth-access = write 
	password-db = ../../passwd
	authz-db = ../../authz
	realm = Payband

启动版本库

	svnserve -d -r /data/svn

关闭版本库
	
	killall svnserve

##开机启动
vim /etc/rc.d/rc.local
/usr/bin/svnserve -d -r /data/svn
