本镜像继承自[Swoole官方alpine镜像](https://github.com/swoole/docker-swoole/tree/master/dockerfiles/latest/php8.0/alpine), 仅在该镜像的增装了pdo_mysql, redis等PHP扩展

```Dockerfile
FROM phpswoole/swoole:latest-alpine

RUN \
    apk add --no-cache gmp-dev git && \
    apk add --no-cache --virtual .build-deps $PHPIZE_DEPS    && \
    pecl update-channels        && \
    pecl install redis          && \
    docker-php-ext-enable redis && \
    docker-php-ext-install gmp pcntl pdo_mysql && \
    apk del .build-deps
```