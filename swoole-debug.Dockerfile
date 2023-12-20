FROM phpswoole/swoole:php8.1-alpine

ENV DEBUG_MODE=remote DEBUG_HOST=127.0.0.1 DEBUG_PORT=44444 DEBUG_LOG=-1 DEBUG_OPLINE=10000 PHP_IDE_CONFIG="serverName=dce"
RUN \
    sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories                              && \
    apk add --no-cache boost-dev gmp-dev libwebp-dev libpng-dev imagemagick-dev tcpdump strace gdb perf                 && \
    apk add --no-cache --virtual .build-deps $PHPIZE_DEPS tzdata git                                                    && \
    apk add --no-cache --virtual .imagick-runtime-deps imagemagick libgomp freetype-dev                                 && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime                                                                 && \
    echo "Asia/Shanghai" > /etc/timezone                                                                                && \
    echo -e "date.timezone=PRC" > /usr/local/etc/php/conf.d/docker-php.ini                                              && \
    pecl update-channels                                                                                                && \
    "" | pecl install redis-5.3.7                                                                                       && \
    pecl install imagick-3.7.0                                                                                          && \
    docker-php-ext-enable redis imagick                                                                                 && \
    docker-php-ext-configure gd --with-freetype --with-webp                                                             && \
    docker-php-ext-install gd gmp pcntl pdo_mysql                                                                       && \
    curl -L https://github.com/swoole/yasd/archive/refs/heads/master.zip -o /tmp/yasd.zip                               && \
    unzip -xq /tmp/yasd.zip -d /tmp && mv /tmp/yasd-master /tmp/yasd                                                    && \
    cd /tmp/yasd                                                                                                        && \
    phpize --clean && phpize                                                                                            && \
    ./configure                                                                                                         && \
    make clean && make && make install                                                                                  && \
    rm -rf /tmp/*                                                                                                       && \
    cat << EOF > /usr/local/etc/php/conf.d/docker-php-ext-yasd.ini\
zend_extension=yasd\
yasd.debug_mode=${DEBUG_MODE}\
yasd.remote_host=${DEBUG_HOST}\
yasd.remote_port=${DEBUG_PORT}\
yasd.log_level=${DEBUG_LOG}\
yasd.max_executed_opline_num=${DEBUG_OPLINE}\
EOF                                                                                                                     && \
    docker-php-source extract                                                                                           && \
    apk del .build-deps freetype-dev tzdata git