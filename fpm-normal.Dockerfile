# dsdas
FROM php:8.1-fpm-alpine

RUN \
    sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories          && \
    apk add --no-cache boost-dev gmp-dev libwebp-dev libpng-dev imagemagick-dev                     && \
    apk add --no-cache --virtual .build-deps $PHPIZE_DEPS tzdata                                    && \
    apk add --no-cache --virtual .imagick-runtime-deps imagemagick libgomp freetype-dev             && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime                                             && \
    echo "Asia/Shanghai" > /etc/timezone                                                            && \
    echo -e "date.timezone=PRC" > /usr/local/etc/php/conf.d/docker-php.ini                          && \
    pecl update-channels                                                                            && \
    "" | pecl install redis-5.3.7                                                                   && \
    pecl install imagick-3.7.0                                                                      && \
    docker-php-ext-enable redis imagick                                                             && \
    docker-php-ext-configure gd --with-freetype --with-webp                                         && \
    docker-php-ext-install gd gmp pcntl pdo pdo_mysql                                               && \
    apk del .build-deps freetype-dev tzdata