FROM phpswoole/swoole:php8.1-alpine

ENV DEBUG_MODE=remote DEBUG_HOST=127.0.0.1 DEBUG_PORT=44444 DEBUG_LOG=-1 DEBUG_OPLINE=10000 PHP_IDE_CONFIG="serverName=dce"
RUN \
    sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories      && \
    apk add --no-cache boost-dev gmp-dev tcpdump strace gdb perf            && \
    apk add --no-cache --virtual .build-deps $PHPIZE_DEPS tzdata git        && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime                     && \
    echo "Asia/Shanghai" > /etc/timezone                                    && \
    echo -e "date.timezone=PRC" > /usr/local/etc/php/conf.d/docker-php.ini  && \
    pecl update-channels                                                    && \
    "" | pecl install redis                                                 && \
    docker-php-ext-enable redis                                             && \
    docker-php-ext-install gmp pcntl pdo_mysql                              && \
    curl -L https://github.com/swoole/yasd/archive/refs/heads/master.zip --output /tmp/yasd.zip && \
    unzip -xq /tmp/yasd.zip -d /tmp && mv /tmp/yasd-master /tmp/yasd        && \
    cd /tmp/yasd                                                            && \
    phpize --clean && phpize                                                && \
    ./configure                                                             && \
    make clean && make && make install                                      && \
    rm -rf /tmp/*                                                           && \
    echo -e "zend_extension=yasd\nyasd.debug_mode=\${DEBUG_MODE}\nyasd.remote_host=\${DEBUG_HOST}\nyasd.remote_port=\${DEBUG_PORT}\n"      \
    "yasd.log_level=\${DEBUG_LOG}\nyasd.max_executed_opline_num=\${DEBUG_OPLINE}" > /usr/local/etc/php/conf.d/docker-php-ext-yasd.ini   && \
    docker-php-source extract                                               && \
    apk del .build-deps tzdata git