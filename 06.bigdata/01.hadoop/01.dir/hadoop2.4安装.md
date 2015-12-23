[TOC]

#hadoop 2.4 安装

##centos 6.5安装

安装centos 配置网卡 ping www.baidu.com

##安装jdk
参见[jdk安装](../../../03.linux/01.centos/02.java相关配置/01.jdk安装和环境变量配置.md)

##拷贝 hadoop-2.4.1.tar.gz到~/app
	
	tar -zxf hadoop-2.4.1.tar.gz

解压 

##修改配置文件

	vim /etc/host

配置java 和 hadoop 环境变量

	JAVA_HOME=/opt/java/jdk1.7
	HADOOP_HOME=/home/hadoop180/app/hadoop-2.6.2
	PATH=$PATH:$JAVA_HOME/bin:$HADOOP_HOME/bin
	CLASSPATH=.:$JAVA_HOME/lib/dt.jar:$JAVA_HOME/lib/tools.jar
	export JAVA_HOME PATH CLASSPATH HADOOP_HOME

	vim hadoop-env.sh 1 
	export JAVA_HOME=/usr/java/jdk1.7.0_65

	vim core-site.xml 2
	<property>
			<name>fs.defaultFS</name>
			<value>hdfs://centos:9000</value>
	</property>
	<property>
			<name>hadoop.tmp.dir</name>
			<value>/home/hadoop180/app/hadoop-2.6.2/tmp</value>
    </property>

    vim hdfs-site.xml 3
    <property>
			<name>dfs.replication</name>
			<value>1</value>
    </property>
    

    vim mapred-site.xml 4
    <property>
			<name>mapreduce.framework.name</name>
			<value>yarn</value>
    </property>

    vim yarn-site.xml 5
    <property>
			<name>yarn.resourcemanager.hostname</name>
			<value>centos</value>
    </property>
    <property>
			<name>yarn.nodemanager.aux-services</name>
			<value>mapreduce_shuffle</value>
     </property>

##ssh无密码登陆

	 ssh-keygen -t dsa -P '' -f ~/.ssh/id_dsa
	 cat ~/.ssh/id_dsa.pub >> ~/.ssh/authorized_keys

##格式化HDFS

	hdfs namenode -format

name has been successfully formatted.表示成功

##操作

	sbin/start-yarn.sh
	sbin/stop-yarn.sh

	sbin/start-dfs.sh
	sbin/stop-dfs.sh

##验证
	jps
	netstat -nltp

	hadoop fs -ls hdfs://centos:9000/
	hadoop fs -put ../hadoop-2.6.2.tar.gz /
	hadoop fs -get /hadoop-2.6.2.tar.gz
	hadoop fs -cat /yue/outdata/part_000

##简单程序

	cd $HADOOP_HOME/share/hadoop/mapreduce/
	mapreduce]$ hadoop jar hadoop-mapreduce-examples-2.6.2.jar wordcount /yue/srcdata /yue/outdata
	hadoop fs -ls /yue/outdata/
	hadoop fs -cat /yue/outdata/part-r-00000


##安装错误

1. Unable to load native-hadoop library for your platform hadoop平台编译版本和使用的操作系统版本不一致

	hadoop-2.4.1/lib/native
	file libhadoop.so.1.0.0

2. java.io.IOException: Cannot create directory /home/hadoop/hadoop-2.6.2/tmp/dfs/name/current权限问题  core-site 目录错误


