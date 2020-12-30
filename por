#!/bin/bash
apt-get update -y
apt-get upgrade -y 
apt-get install git wget squid3 -y
IP=$(wget -4qO- "http://whatismyip.akamai.com/")
echo 'SQUID UBUNTU'
rm -rf /etc/squid/squid.conf
touch /etc/squid/squid.conf
echo 'acl ip dstdomain '$IP > /etc/squid/squid.conf
echo 'acl payload dstdomain -i "/etc/payloads"
acl local dstdomain localhost
acl iplocal dstdomain 127.0.0.1
acl netflix dstdomain .netflix.
acl redelocal src 192.168.0.1-192.168.0.254
acl vpn src 10.8.0.1-10.8.0.254
acl videoprime dstdomain .videoprime.
acl ip4 dstdomain 127.0.0.2
acl oi dstdomain 200.222.108.241

http_access allow ip
http_access allow payload
http_access allow local
http_access allow iplocal
http_access allow redelocal
http_access allow vpn
http_access allow ip4
http_access allow oi
http_access allow netflix
http_access allow videoprime

http_port 80
http_port 8080
http_port 8799
http_port 3128

# Nome visivel da VPS
visible_hostname $nome|R3V1V3RVPS

###Anonimato do PROXY SQUID
forwarded_for off
request_header_access Allow allow all
request_header_access Authorization allow all
request_header_access WWW-Authenticate allow all
request_header_access Proxy-Authorization allow all
request_header_access Proxy-Authenticate allow all
request_header_access Cache-Control allow all
request_header_access Content-Encoding allow all
request_header_access Content-Length allow all
request_header_access Content-Type allow all
request_header_access Date allow all
request_header_access Expires allow all
request_header_access Host allow all
request_header_access If-Modified-Since allow all
request_header_access Last-Modified allow all
request_header_access Location allow all
request_header_access Pragma allow all
request_header_access Accept allow all
request_header_access Accept-Charset allow all
request_header_access Accept-Encoding allow all
request_header_access Accept-Language allow all
request_header_access Content-Language allow all
request_header_access Mime-Version allow all
request_header_access Retry-After allow all
request_header_access Title allow all
request_header_access Connection allow all
request_header_access Proxy-Connection allow all
request_header_access User-Agent allow all
request_header_access Cookie allow all
request_header_access All deny all

# ACL DE CONEXAO
acl local dstdomain localhost
acl iplocal dstdomain 127.0.0.1
acl accept src $ip
acl ip url_regex -i $ip
acl hosts dstdomain -i '/etc/payloads'
acl SSL_ports port 22
acl SSL_ports port 80
acl SSL_ports port 143
acl SSL_ports port 443
acl Safe_ports port 80          # http
acl Safe_ports port 21          # ftp
acl Safe_ports port 443         # https
acl Safe_ports port 70          # gopher
acl Safe_ports port 210         # wais
acl Safe_ports port 1025-65535  # unregistered ports
acl Safe_ports port 280         # http-mgmt
acl Safe_ports port 488         # gss-http
acl Safe_ports port 591         # filemaker
acl Safe_ports port 777         # multiling http
acl CONNECT method CONNECT

# CACHE DO SQUID
cache_mem 256 MB
maximum_object_size_in_memory 32 KB
maximum_object_size 1024 MB
minimum_object_size 0 KB
cache_swap_low 90
cache_swap_high 95
cache_dir ufs /var/spool/squid3 30 16 256
access_log /var/log/squid3/access.log squid
cache_log /var/log/squid3/cache.log
cache_store_log /var/log/squid3/store.log
pid_filename /var/log/squid3/squid3.pid
mime_table /usr/share/squid3/mime.conf
cache_effective_user proxy
cache_effective_group proxy

# ACESSOS ACL
http_access allow local
http_access allow iplocal
http_access allow accept
http_access allow ip
http_access allow hosts
http_access allow CONNECT !SSL_ports
http_access deny !Safe_ports
http_access deny CONNECT
http_access deny all
cache deny all > /etc/squid*/squid.conf"

echo "
.bookclaro.com.br
.claro.com.ar
.claro.com.br
.claro.com.co
.claro.com.ec
.claro.com.gt
.claro.com.ni
.claro.com.pe
.claro.com.sv
.claro.cr
.clarocurtas.com.br
.claroideas.com
.claroideias.com.br
.claromusica.com
.clarosomdechamada.com.br
.clarovideo.com
.facebook.net
.netclaro.com.br
.oi.com.br
.oimusica.com.br
.speedtest.net
.tim.com.br
.timanamaria.com.br
.vivo.com.br
.ddivulga.com
.clarosomdechamada.com.br
.bradescocelular.com.br
" > /etc/payloads
echo "Reniciando servicos"
service ssh restart 1>/dev/null 2>/dev/null
service squid3 restart 1>/dev/null 2>/dev/null
echo "Sucesso..."
sleep 3
echo "Seu servidor foi configurado com sucesso!"
sleep 3
echo "Saindo..."
sleep 2
fi
