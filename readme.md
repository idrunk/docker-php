本镜像为Dce作者封装的用于[Dce框架](https://drunkce.com/)的Swoole镜像，但也兼容普通Swoole或PHP cli程序，欢迎体验。本镜像继承自[Swoole官方PHP8.1的alpine镜像](https://github.com/swoole/docker-swoole/tree/master/dockerfiles/latest/php8.1/alpine), 在该镜像基础上增装了pdo_mysql, redis等PHP扩展。

## [thin](./thin/)

瘦镜像，普通swoole镜像，仅增装了pdo_mysql, redis扩展

## [normal](./normal/)

普通镜像，比瘦镜像增装了gmp, gd, imagick扩展

## [debug](./debug/)

开发环境镜像，比普通镜像增装了[Swoole官方推荐的调试工具包](https://wiki.swoole.com/#/other/tools)，方便开发调试

### yasd

#### 配置

没在下表中的配置不支持以环境变量传递，但你可以映射宿主机文件到容器以覆盖配置，路径为`/usr/local/etc/php/conf.d/docker-php-ext-yasd.ini`，配置相关说明文档请到[yasd官方维基](https://huanghantao.github.io/yasd-wiki/)查看

yasd配置名 | 镜像环境变量 | 默认值
:-: | :-: | :-:
debug_mode | DEBUG_MODE | remote
remote_host | DEBUG_HOST | 127.0.0.1
remote_port | DEBUG_PORT | 44444
log_level | DEBUG_LOG | -1
max_executed_opline_num | DEBUG_OPLINE | 10000

#### remote用法

1. 在Phpstorm中设置xdebug监听端口为44444，并启动监听

2. 在设置“PHP->servers”下添加名为dce的服务器并映射开发与调试脚本路径

3. 指定监听端口到环境变量，启动容器
```
docker run --rm --privileged --name dce -it -e "DEBUG_HOST=${你的宿主机IP}" -v ${项目目录}:/app -p ${服务端口}:20461 idrunk/swoole:debug -e /app/dce websocket start
```

#### remote问题

1. 启动容器时若提示“check listening state”，可能是由于防火墙阻挡，你可以关闭防火墙。

2. 若你想开启防火墙，通过配置入站规则允许调试，可能需先删除Phpstorm自动配置的防火墙规则。

3. 如果你在上述“remote用法第2点”时添加的服务器名不为dce，请在启动容器时指定环境变量“-e PHP_IDE_CONFIG="serverName=${你添加的服务器名}"”


### tcpdump

```
docker exec -it dce tcpdump -i any tcp port 20461
```


### strace

```
docker exec -it dce strace -f -p ${PID}
```


### gdb

```
docker exec -it dce gdb -p ${PID}
```


### zbacktrace

```
docker exec -it dce gdb -p ${PID}

source /usr/src/php/.gdbinit
zbacktrace
```


### lsof

```
docker exec -it dce lsof -p ${PID}
```


### perf

```
docker exec -it dce perf top -p ${PID}
```