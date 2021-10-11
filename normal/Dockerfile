FROM phpswoole/swoole:latest-alpine

RUN \
    sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories && \
    apk add --no-cache boost-dev gmp-dev git tzdata && \
    apk add --no-cache --virtual .build-deps $PHPIZE_DEPS  && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime    && \
    echo "Asia/Shanghai" > /etc/timezone  && \
    pecl update-channels        && \
    "" | pecl install redis          && \
    docker-php-ext-enable redis && \
    docker-php-ext-install gmp pcntl pdo_mysql && \
    apk del .build-deps tzdata
