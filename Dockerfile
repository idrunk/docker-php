FROM phpswoole/swoole:latest-alpine

RUN \
    apk add --no-cache git && \
    apk add --no-cache --virtual .build-deps $PHPIZE_DEPS    && \
    pecl update-channels        && \
    pecl install redis          && \
    docker-php-ext-enable redis && \
    docker-php-ext-install pcntl pdo_mysql && \
    apk del .build-deps
