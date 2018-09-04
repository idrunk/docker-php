# 创建容器
docker run --name alpine -it alpine:3.8

# 进入容器
docker exec -it alpine sh


### 开始配置环境

# 设置中国镜像
mv /etc/apk/repositories /etc/apk/repositories.bak
echo "http://mirrors.aliyun.com/alpine/v3.8/main/" > /etc/apk/repositories

# 添加配置时依赖
apk add tzdata autoconf build-base linux-headers libaio-dev libxml2-dev libressl-dev nghttp2-dev hiredis-dev

# 设置时区
cp /usr/share/zoneinfo/PRC /etc/localtime
echo "PRC" >  /etc/timezone

# 下载资源
cd / && mkdir download
cd download

wget https://github.com/swoole/swoole-src/archive/v4.1.0.tar.gz -O swoole-src-4.1.0.tar.gz

tar -xzvf swoole-src-4.1.0.tar.gz

# 安装swoole
cd swoole-src-4.1.0
phpize
./configure \
    --enable-openssl  \
    --enable-http2  \
    --enable-async-redis \
    --enable-sockets \
    --enable-mysqlnd
make && make install
cd ../





















### 开始配置环境

# 设置中国镜像
mv /etc/apk/repositories /etc/apk/repositories.bak
echo "http://mirrors.aliyun.com/alpine/v3.8/main/" > /etc/apk/repositories

# 添加配置时依赖
apk add tzdata autoconf build-base linux-headers libaio-dev libxml2-dev libressl-dev curl-dev

# 设置时区
cp /usr/share/zoneinfo/PRC /etc/localtime
echo "PRC" >  /etc/timezone

# 下载资源
cd / && mkdir drunk
cd drunk && mkdir download
cd download

wget http://mirror.hust.edu.cn/gnu/libiconv/libiconv-1.15.tar.gz
wget http://cn2.php.net/distributions/php-7.2.9.tar.gz
wget https://github.com/swoole/swoole-src/archive/v4.1.0.tar.gz -O swoole-src-4.1.0.tar.gz

tar -xzvf libiconv-1.15.tar.gz
tar -xzvf php-7.2.9.tar.gz
tar -xzvf swoole-src-4.1.0.tar.gz

# 安装php依赖
cd libiconv-1.15
./configure --prefix=/usr/local
make && make install
cd ../

# 安装php
cd php-7.2.9
./configure --prefix=/usr/php7 --with-config-file-path=/usr/php7/etc \
--with-iconv-dir --with-zlib \
--enable-xml --disable-rpath --enable-bcmath --enable-shmop --enable-sysvsem --enable-inline-optimization \
--with-curl --enable-mbregex --enable-fpm --enable-mbstring \
--with-openssl --with-mhash --enable-sockets --with-xmlrpc --enable-zip --enable-soap \
--enable-opcache=yes
make ZEND_EXTRA_LIBS='-liconv'
make install
cd ../
ln -s /usr/php7/bin/php /usr/bin/php
ln -s /usr/php7/bin/php-config /usr/bin/php-config
ln -s /usr/php7/bin/phpize /usr/bin/phpize

# 安装swoole
cd swoole-src-4.1.0
phpize
./configure \
    --enable-openssl  \
    --enable-http2  \
    --enable-async-redis \
    --enable-sockets \
    --enable-mysqlnd
make && make install
cd ../