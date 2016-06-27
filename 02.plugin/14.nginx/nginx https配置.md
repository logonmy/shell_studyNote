[TOC]

#nginx https配置

可以通过以下步骤生成一个简单的证书：
首先，进入你想创建证书和私钥的目录，例如：

$ cd /usr/local/nginx/conf
创建服务器私钥，命令会让你输入一个口令：

$ openssl genrsa -des3 -out server.key 1024
创建签名请求的证书（CSR）：

$ openssl req -new -key server.key -out server.csr
在加载SSL支持的Nginx并使用上述私钥时除去必须的口令：
$ cp server.key server.key.org
$ openssl rsa -in server.key.org -out server.key
最后标记证书使用上述私钥和CSR：
 openssl x509 -req -days 365 -in server.csr -signkey server.key -out server.crt

	server {
		listen       443 ssl;
		server_name  localhost;

		ssl_certificate      server.crt;
		ssl_certificate_key  server.key;

		ssl_session_cache    shared:SSL:1m;
		ssl_session_timeout  5m;

		ssl_ciphers  HIGH:!aNULL:!MD5;
		ssl_prefer_server_ciphers  on;

		location / {
			root   html;
			index  index.html index.htm;
		}
	}