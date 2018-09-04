FROM php:7.2.9-cli-alpine3.8
Maintainer Drunk (https://github.com/drunker, http://idrunk.net)
RUN cp /etc/apk/repositories /etc/apk/repositories.bak \
    && echo "http://mirrors.aliyun.com/alpine/v3.8/main" > /etc/apk/repositories \
	&& echo "http://mirrors.aliyun.com/alpine/v3.8/community" >> /etc/apk/repositories \
	&& docker-php-ext-install sockets \
	&& apk add tzdata \
	    autoconf \
	    build-base \
	    linux-headers \
        libaio-dev \
        libxml2-dev \
        libressl-dev \
	    nghttp2-dev \
	    hiredis-dev \
	&& cp /usr/share/zoneinfo/PRC /etc/localtime \
	&& echo "PRC" >  /etc/timezone \
	&& cd / && mkdir download && cd download \
	&& wget https://github.com/swoole/swoole-src/archive/v4.1.0.tar.gz -O swoole-src-4.1.0.tar.gz \
	&& tar -xzvf swoole-src-4.1.0.tar.gz \
	&& cd swoole-src-4.1.0 \
	&& phpize \
	&& ./configure \
        --enable-openssl  \
        --enable-http2  \
        --enable-async-redis \
        --enable-sockets \
        --enable-mysqlnd \
	&& make && make install \
	&& docker-php-ext-enable swoole \
	&& apk del tzdata \
	    autoconf \
	    build-base \
	    linux-headers \
        libaio-dev \
        libxml2-dev \
        libressl-dev \
	    nghttp2-dev \
	&& apk add libstdc++ \
	&& cd / \
	&& rm -rf /download/ \
	&& rm -rf /var/cache/apk/ \
    && rm -rf /tmp/ \
    && rm -rf /usr/include/ \
    && rm -rf /usr/local/include/ \
    && rm -rf /usr/src/
VOLUME /app
WORKDIR /app
EXPOSE 9501