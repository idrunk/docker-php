FROM phpswoole/swoole:latest-alpine

RUN \
    sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories && \
    apk add --no-cache boost-dev gmp-dev git tzdata && \
    apk add --no-cache --virtual .build-deps $PHPIZE_DEPS  && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime    && \
    echo "Asia/Shanghai" > /etc/timezone  && \
    pecl update-channels        && \
    "" | pecl install redis          && \
    cd /tmp && \
    curl -L https://github.com/swoole/yasd/archive/refs/tags/v0.3.9.tar.gz --output yasd.tar.gz && \
    mkdir yasd && tar xzf yasd.tar.gz -C yasd --strip-components 1 && \
    cd yasd && \
    phpize --clean && phpize && \
    ./configure && \
    make clean && make && make install && \
    rm -rf /tmp/* && \
    docker-php-ext-enable redis yasd && \
    docker-php-ext-install gmp pcntl pdo_mysql && \
    echo -e "zend_extension=yasd\nyasd.debug_mode=remote\nyasd.remote_host=\${DEBUG_HOST}\nyasd.remote_port=\${DEBUG_PORT}" > /usr/local/etc/php/conf.d/docker-php-ext-yasd.ini && \
    apk del .build-deps tzdata
