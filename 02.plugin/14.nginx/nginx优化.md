[TOC]

#nginx优化

##linux内核配置
	vim /etc/sysctl.conf
	#原有字段  
	net.ipv4.tcp_syncookies = 1
	#新增字段
	#这个参数表示进程（比如一个worker进程）可以同时打开的最大句柄数，这个参数直线限制最大并发连接数，需根据实际情况配置
	fs.file-max = 999999
	#这个参数设置为1，表示允许将TIME-WAIT状态的socket重新用于新的TCP连接，这对于服务器来说很有意义，因为服务器上总会有大量TIME-WAIT状态的连接
	net.ipv4.tcp_tw_reuse = 1
	#这个参数表示当keepalive启用时，TCP发送keepalive消息的频度。默认是2小时，若将其设置的小一些，可以更快地清理无效的连接。
	net.ipv4.tcp_keepalive_time = 600
	#这个参数表示当服务器主动关闭连接时，socket保持在FIN-WAIT-2状态的最大时间
	net.ipv4.tcp_fin_timeout = 30
	#这个参数定义了在UDP和TCP连接中本地（不包括连接的远端）端口的取值范围
	net.ipv4.ip_local_port_range = 1024 61000
	#这个参数定义了TCP接受缓存（用于TCP接受滑动窗口）的最小值、默认值、最大值
	net.ipv4.tcp_rmem = 10240 87380 12582912
	#这个参数定义了TCP发送缓存（用于TCP发送滑动窗口）的最小值、默认值、最大值
	net.ipv4.tcp_wmem = 10240 87380 12582912
	#当网卡接受数据包的速度大于内核处理的速度时，会有一个队列保存这些数据包。这个参数表示该队列的最大值。
	net.core.netdev_max_backlog = 8096
	#这个参数表示内核套接字接受缓存区默认的大小
	net.core.rmem_default = 6291456
	#这个参数表示内核套接字发送缓存区默认的大小
	net.core.wmem_default = 6291456
	#这个参数表示内核套接字接受缓存区的最大大小
	net.core.rmem_max = 12582912
	#这个参数表示内核套接字发送缓存区的最大大小
	net.core.wmem_max = 12582912
	#该参数与性能无关，用于解决TCP的SYN攻击
	net.ipv4.tcp_syncookies = 1
	sysctl -p#激活内核参数

##nginx配置文件

参见配置文件
