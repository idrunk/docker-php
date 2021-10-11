FROM phpswoole/swoole:latest-alpine

ENV DEBUG_MODE=remote DEBUG_HOST=127.0.0.1 DEBUG_PORT=44444 DEBUG_LOG=-1 DEBUG_OPLINE=10000 PHP_IDE_CONFIG="serverName=dce"
RUN \
    sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories && \
    apk add --no-cache boost-dev tcpdump strace gdb perf gmp-dev git tzdata && \
    apk add --no-cache --virtual .build-deps $PHPIZE_DEPS  && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime    && \
    echo "Asia/Shanghai" > /etc/timezone  && \
    pecl update-channels        && \
    "" | pecl install redis          && \
    curl -L https://github.com/swoole/yasd/archive/refs/tags/v0.3.9.tar.gz --output /tmp/yasd.tar.gz && \
    mkdir /tmp/yasd && tar xzf /tmp/yasd.tar.gz -C /tmp/yasd --strip-components 1 && \
    cd /tmp/yasd && \
    phpize --clean && phpize && \
    ./configure && \
    make clean && make && make install && \
    rm -rf /tmp/* && \
    docker-php-ext-enable redis yasd && \
    docker-php-ext-install gmp pcntl pdo_mysql && \
    echo -e "zend_extension=yasd\nyasd.debug_mode=\${DEBUG_MODE}\nyasd.remote_host=\${DEBUG_HOST}\nyasd.remote_port=\${DEBUG_PORT}\n"\
    "yasd.log_level=\${DEBUG_LOG}\nyasd.max_executed_opline_num=\${DEBUG_OPLINE}" > /usr/local/etc/php/conf.d/docker-php-ext-yasd.ini && \
    mkdir /usr/src/php && tar xf /usr/src/php.tar.xz -C /usr/src/php --strip-components 1 && \
    apk del .build-deps tzdata
