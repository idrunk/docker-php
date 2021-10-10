本镜像继承自[Swoole官方alpine镜像](https://github.com/swoole/docker-swoole/tree/master/dockerfiles/latest/php8.0/alpine), 仅在该镜像的增装了pdo_mysql, redis等PHP扩展

## [default]()

常规镜像，普通swoole镜像，未集成debug插件，用于生产环境

## [yasd]()

带有yasd调试工具的swoole镜像，方便开发调试

### 用法

1. 在Phpstorm中设置xdebug监听端口并启动监听

2. 指定监听端口到环境变量，启动容器
```
podman run --rm -it -e "DEBUG_HOST=${你的宿主机IP}" -e "DEBUG_PORT=${IDE监听端口}" -v ${项目目录}:/app idrunk/swoole:yasd -e /app/dce websocket start
```

### 常见问题

1. 启动容器时若提示“check listening state”，可能是由于防火墙阻挡，你可以关闭防火墙。

2. 若你想开启防火墙，通过配置入站规则允许调试，可能需先删除Phpstorm自动配置的防火墙规则。