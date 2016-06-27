[TOC]

#windows下memcached安装

##解压安装
## 安装
memcached.exe -d install （之后屏幕无任何提示）
启动
memcached.exe -d start

（之后屏幕无任何提示，但是在“任务管理器”中勾选“显示所有用户进程”，此时可以看到memcached.exe进程正在运行）
　　默认端口11211，外部访问需要开放该端口，否则无法成功连接。
参数设置
memcached基本参数设置：
    -p 监听的端口
    -l 连接的IP地址, 默认是本机
    -d start 启动memcached服务
    -d restart 重起memcached服务
    -d stop|shutdown 关闭正在运行的memcached服务
    -d install 安装memcached服务
    -d uninstall 卸载memcached服务
    -u 以的身份运行 (仅在以root运行的时候有效)
    -m 最大内存使用，单位MB。默认64MB
    -M 内存耗尽时返回错误，而不是删除项
    -c 最大同时连接数，默认是1024
    -f 块大小增长因子，默认是1.25
    -n 最小分配空间，key+value+flags默认是48
    -h 显示帮助
　　设置参数时需要先停止memcached，然后用命令行设置，比如：c:\memcached> memcached.exe -m 1 -d start

停止memcached
memcached.exe -d stop
卸载memcached
memcached.exe -d uninstall
##验证
telnet 127.0.0.1 11211
入后先按ctrl+]启动回示功能，否则无法看到输入信息。回示功能启动成功后如下图：



##java示例
	 <dependency>
    <groupId>net.spy</groupId>
    <artifactId>spymemcached</artifactId>
    <version>2.12.1</version>
	</dependency>

	import java.io.IOException;
	import java.io.Serializable;
	import java.net.InetSocketAddress;

	import net.spy.memcached.MemcachedClient;

	//spymemcached也自带了几个例子，大家可以看看
	//http://code.google.com/p/spymemcached/wiki/Examples
	class User implements Serializable { // 必须将对象序列化才能保存
		public String userName;
		public String password;
	}

	public class Test {
		public static void main(String[] args) throws IOException {
			MemcachedClient c = new MemcachedClient(new InetSocketAddress("127.0.01", 11211));
			// 存取一个简单的Integer
			// Store a value (async) for one hour
			c.set("someKey", 3600, new Integer(4));
			// Retrieve a value (synchronously).
			Object myObject = c.get("someKey");
			Integer result = (Integer) myObject;
			System.out.println(result);
			// 存取一个序列化的对象
			System.out.println("存之前的时间：" + System.currentTimeMillis());
			User user1 = new User();
			user1.userName = "ZhangSan";
			user1.password = "alongpasswordhere";
			c.set("user1", 3600, user1);
			System.out.println("取之前的时间：" + System.currentTimeMillis());
			User myUser1 = (User) (c.get("user1"));
			System.out.println(myUser1.userName + " " + myUser1.password);
			System.out.println("取之后的时间：" + System.currentTimeMillis());
			c.shutdown();
		}
	}