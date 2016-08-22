
#user  nobody;
worker_processes 8;
worker_rlimit_nofile 100000;

#error_log  logs/error.log;
#error_log  logs/error.log  notice;
#error_log  logs/error.log  info;

#pid        logs/nginx.pid;


events {
    worker_connections  10240;
    multi_accept on;
    use epoll;
}


http {
    include       mime.types;
    default_type  application/octet-stream;

    log_format  main  '$remote_addr - $remote_user [$time_local] "$request" '
                      '$status $body_bytes_sent "$http_referer" '
                      '"$http_user_agent" "$http_x_forwarded_for"';

    #access_log  logs/access.log  main;

    sendfile        on;
    #tcp_nopush     on;

    #keepalive_timeout  0;
    keepalive_timeout  65;

    #gzip  on;
    server {
        listen 8888;
        server_name localhost;
        charset utf-8;
        access_log  logs/express.access.log  main;
        location / {
            root   html/express;
            index  index.html index.htm;
        }
    }
    server {
        listen 8893;
        listen 8891 ssl;
        server_name localhost;
        
        ssl_certificate      server.crt;
        ssl_certificate_key  server.key;
        
        charset utf-8;
        access_log  off;
        
        proxy_set_header host                $host;
        proxy_set_header X-forwarded-for $proxy_add_x_forwarded_for;
        proxy_set_header X-real-ip           $remote_addr;
        
        location /payband {
            proxy_pass http://10.24.161.117:8888/payband;
        }
        location /cw {
            proxy_pass http://10.24.161.117:8888/cw;
        }
        location /bdpw {
            proxy_pass http://10.24.161.117:8888/bdpw;
        }
    }
}
