[TOC]

#hadoop2.6.2centos 配置文件说明

hadoop2.0的配置文件全部在$HADOOP_HOME/etc/hadoop下
cd $HADOOP_HOME/etc/hadoop


##1修改hadoo-env.sh  
export JAVA_HOME=/home/hadoop/app/jdk1.7.0_51(可以不修改，只要配置${JAVA_HOME}即可)  

#2修改core-site.xml

	<configuration>
		<!-- 指定hdfs的nameservice为ns1 -->
		<property>
			<name>fs.defaultFS</name>
			<value>hdfs://ns1</value>
		</property>
		<!-- 指定hadoop临时目录 -->
		<property>
			<name>hadoop.tmp.dir</name>
			<value>/home/hadoop/app/hadoop-2.6.2/tmp</value>
		</property>
		<!-- 指定zookeeper地址 -->
		<property>
			<name>ha.zookeeper.quorum</name>
			<value>hadoop5:2181,hadoop6:2181,hadoop7:2181</value>
		</property>
	</configuration>

#3修改hdfs-site.xml  

	<configuration>
		<!--指定hdfs的nameservice为ns1，需要和core-site.xml中的保持一致 -->
		<property>
			<name>dfs.nameservices</name>
			<value>ns1</value>
		</property>
		<!-- ns1下面有两个NameNode，分别是nn1，nn2 -->
		<property>
			<name>dfs.ha.namenodes.ns1</name>
			<value>nn1,nn2</value>
		</property>
		<!-- nn1的RPC通信地址 -->
		<property>
			<name>dfs.namenode.rpc-address.ns1.nn1</name>
			<value>hadoop1:9000</value>
		</property>
		<!-- nn1的http通信地址 -->
		<property>
			<name>dfs.namenode.http-address.ns1.nn1</name>
			<value>hadoop1:50070</value>
		</property>
		<!-- nn2的RPC通信地址 -->
		<property>
			<name>dfs.namenode.rpc-address.ns1.nn2</name>
			<value>hadoop2:9000</value>
		</property>
		<!-- nn2的http通信地址 -->
		<property>
			<name>dfs.namenode.http-address.ns1.nn2</name>
			<value>hadoop2:50070</value>
		</property>
		<!-- 指定NameNode的元数据在JournalNode上的存放位置 -->
		<property>
			<name>dfs.namenode.shared.edits.dir</name>
			<value>qjournal://hadoop5:8485;hadoop6:8485;hadoop7:8485/ns1</value>
		</property>
		<!-- 指定JournalNode在本地磁盘存放数据的位置 -->
		<property>
			<name>dfs.journalnode.edits.dir</name>
			<value>/home/hadoop/app/hadoop-2.6.2/journaldata</value>
		</property>
		<!-- 开启NameNode失败自动切换 -->
		<property>
			<name>dfs.ha.automatic-failover.enabled</name>
			<value>true</value>
		</property>
		<!-- 配置失败自动切换实现方式 -->
		<property>
			<name>dfs.client.failover.proxy.provider.ns1</name>
			<value>org.apache.hadoop.hdfs.server.namenode.ha.ConfiguredFailoverProxyProvider</value>
		</property>
		<!-- 配置隔离机制方法，多个机制用换行分割，即每个机制暂用一行-->
		<property>
			<name>dfs.ha.fencing.methods</name>
			<value>
				sshfence
				shell(/bin/true)
			</value>
		</property>
		<!-- 使用sshfence隔离机制时需要ssh免登陆 -->
		<property>
			<name>dfs.ha.fencing.ssh.private-key-files</name>
			<value>/home/hadoop/.ssh/id_rsa</value>
		</property>
		<!-- 配置sshfence隔离机制超时时间 -->
		<property>
			<name>dfs.ha.fencing.ssh.connect-timeout</name>
			<value>30000</value>
		</property>
	</configuration>

#4修改mapred-site.xml

	<configuration>
		<!-- 指定mr框架为yarn方式 -->
		<property>
			<name>mapreduce.framework.name</name>
			<value>yarn</value>
		</property>
	</configuration>	

#5修改yarn-site.xml  

	<configuration>
			<!-- 开启RM高可用 -->
			<property>
			   <name>yarn.resourcemanager.ha.enabled</name>
			   <value>true</value>
			</property>
			<!-- 指定RM的cluster id -->
			<property>
			   <name>yarn.resourcemanager.cluster-id</name>
			   <value>yrc</value>
			</property>
			<!-- 指定RM的名字 -->
			<property>
			   <name>yarn.resourcemanager.ha.rm-ids</name>
			   <value>rm1,rm2</value>
			</property>
			<!-- 分别指定RM的地址 -->
			<property>
			   <name>yarn.resourcemanager.hostname.rm1</name>
			   <value>hadoop3</value>
			</property>
			<property>
			   <name>yarn.resourcemanager.hostname.rm2</name>
			   <value>hadoop4</value>
			</property>
			<!-- 指定zk集群地址 -->
			<property>
			   <name>yarn.resourcemanager.zk-address</name>
			   <value>hadoop5:2181,hadoop6:2181,hadoop7:2181</value>
			</property>
			<property>
			   <name>yarn.nodemanager.aux-services</name>
			   <value>mapreduce_shuffle</value>
			</property>
	</configuration>
			

			
#6修改slaves(slaves是指定子节点的位置，因为要在hadoop1上启动HDFS、在hadoop3启动yarn，所以hadoop1上的slaves文件指定的是datanode的位置，hadoop3上的slaves文件指定的是nodemanager的位置)
	hadoop5
	hadoop6
	hadoop7

#7配置免密码登陆

首先要配置hadoop1到hadoop2、hadoop3、hadoop4、hadoop5、hadoop6、hadoop7的免密码登陆  
在hadoop1上生产一对钥匙  
	ssh-keygen -t rsa
将公钥拷贝到其他节点，包括自己  
	ssh-coyp-id hadoop1
	ssh-coyp-id hadoop2
	ssh-coyp-id hadoop3
	ssh-coyp-id hadoop4
	ssh-coyp-id hadoop5
	ssh-coyp-id hadoop6
	ssh-coyp-id hadoop7
配置hadoop3到hadoop4、hadoop5、hadoop6、hadoop7的免密码登陆  
在hadoop3上生产一对钥匙  
	ssh-keygen -t rsa
将公钥拷贝到其他节点 
	ssh-coyp-id hadoop4
	ssh-coyp-id hadoop5
	ssh-coyp-id hadoop6
	ssh-coyp-id hadoop7
注意：两个namenode之间要配置ssh免密码登陆，别忘了配置hadoop2到hadoop1的免登陆  
在hadoop2上生产一对钥匙  
	ssh-keygen -t rsa
	ssh-coyp-id -i hadoop1	