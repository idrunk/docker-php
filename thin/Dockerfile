FROM phpswoole/swoole:php8.1-alpine


RUN \
    sed -i 's/dl-cdn.alpinelinux.org/mirrors.tuna.tsinghua.edu.cn/g' /etc/apk/repositories          && \
    apk add --no-cache --virtual .build-deps $PHPIZE_DEPS tzdata                                    && \
    cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime                                             && \
    echo "Asia/Shanghai" > /etc/timezone                                                            && \
    echo -e "date.timezone=PRC" > /usr/local/etc/php/conf.d/docker-php.ini                          && \
    pecl update-channels                                                                            && \
    "" | pecl install redis-5.3.7                                                                   && \
    docker-php-ext-enable redis                                                                     && \
    docker-php-ext-install pcntl pdo_mysql                                                          && \
    apk del .build-deps tzdata