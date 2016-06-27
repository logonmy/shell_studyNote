[TOC]
#redis编译安装

##准备
yum -y install tcl
##下载解压

	cd /usr/local/src
	wget http://download.redis.io/releases/redis-3.2.1.tar.gz
	tar -zxvf redis-3.2.1.tar.gz
	cd redis-3.2.1

##编译安装
	mkdir /usr/local/redis
	make && make test&& make PREFIX=/usr/local/redis install
	
##配置
	mkdir /usr/local/redis/etc
	cp /usr/local/src/redis-3.2.1/redis.conf /usr/local/redis/etc/redis9980.conf
	vim /usr/local/redis/etc/redis9980.conf

	daemonize yes
	pidfile /var/run/redis_9980.pid
	logfile ""
	bind 0.0.0.0
	port 9980
	loglevel verbose
	dbfilename dump.rdb
	dir ./redisdata
	maxclients 10000
	maxmemory 1g
	appendonly yes
	appendfsync   everysec：表示每秒同步一次（折衷，默认值） 




##启动停止
	/usr/local/redis/bin/redis-server /usr/local/redis/etc/redis9980.conf
	/usr/local/redis/bin/redis-cli -h 127.0.0.1 -p 9980 shutdown
开机启动

	vim /etc/rc.local
	/usr/local/redis/bin/redis-server /usr/local/redis/etc/redis9980.conf
##操作

	/usr/local/redis/bin/redis-cli -h 127.0.0.1 -p 9980
	info
	config get dir
	get key
	del key
	SET KEY_NAME VALUE
	SET KEY VALUE [EX seconds] [PX milliseconds] [NX|XX]
	EX seconds - 设置指定的到期时间，单位为秒。
	PX milliseconds - 设置指定到期时间，单位为毫秒。
	NX - 只有设置键，如果它不存在。
	XX - 只有设置键，如果它已经存在。

##压力测试
	/usr/local/redis/bin/redis-benchmark --help
	Usage: redis-benchmark [-h <host>] [-p <port>] [-c <clients>] [-n <requests]> [-k <boolean>]
	 -h <hostname>      Server hostname (default 127.0.0.1)
	 -p <port>          Server port (default 6379)
	 -s <socket>        Server socket (overrides host and port)
	 -a <password>      Password for Redis Auth
	 -c <clients>       Number of parallel connections (default 50)
	 -n <requests>      Total number of requests (default 100000)
	 -d <size>          Data size of SET/GET value in bytes (default 2)
	 -dbnum <db>        SELECT the specified db number (default 0)
	 -k <boolean>       1=keep alive 0=reconnect (default 1)
	 -r <keyspacelen>   Use random keys for SET/GET/INCR, random values for SADD
	  Using this option the benchmark will expand the string __rand_int__
	  inside an argument with a 12 digits number in the specified range
	  from 0 to keyspacelen-1. The substitution changes every time a command
	  is executed. Default tests use this to hit random keys in the
	  specified range.
	 -P <numreq>        Pipeline <numreq> requests. Default 1 (no pipeline).
	 -q                 Quiet. Just show query/sec values
	 --csv              Output in CSV format
	 -l                 Loop. Run the tests forever
	 -t <tests>         Only run the comma separated list of tests. The test
	                    names are the same as the ones produced as output.
	 -I                 Idle mode. Just open N idle connections and wait.
	 
	Examples:
	 Run the benchmark with the default configuration against 127.0.0.1:6379:
	   $ redis-benchmark

	 Use 20 parallel clients, for a total of 100k requests, against 192.168.1.1:
	   $ redis-benchmark -h 192.168.1.1 -p 6379 -n 100000 -c 20

	 Fill 127.0.0.1:6379 with about 1 million keys only using the SET test:
	   $ redis-benchmark -t set -n 1000000 -r 100000000

	 Benchmark 127.0.0.1:6379 for a few commands producing CSV output:
	   $ redis-benchmark -t ping,set,get -n 100000 --csv

	 Benchmark a specific command line:
	   $ redis-benchmark -r 10000 -n 10000 eval 'return redis.call("ping")' 0

	 Fill a list with 10000 random elements:
	   $ redis-benchmark -r 10000 -n 10000 lpush mylist __rand_int__

	 On user specified command lines __rand_int__ is replaced with a random integer
	 with a range of values selected by the -r option.


##遇到问题
###You need tcl 8.5 or newer in order to run the Redis test
yum -y install tcl
