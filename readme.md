# Swoole PHP

SwoolePHP是一个打包了最新稳定版的Swoole和PHP的镜像, 体积小/功能全, 镜像包仅96M, 支持wiki.swoole.com上所有示例脚本. 欢迎大家拉取体验.

#### 构成
```
Swoole v4.2.12
PHP v7.3.1
Alpine v3.8
```

#### 使用
```
# 默认进入shell界面
docker run --name swoole_sh -it -v {swoole项目目录}:/app -p 12246:12246 -w /app idrunk/swoole-php /bin/sh
# 执行PHP脚本
docker run --name swoole -it -v {swoole项目目录}:/app -p 9501:9501 -w /app idrunk/swoole-php php test.php
    
# PS: {swoole项目目录}指宿主机swoole项目或其他外部数据目录, 执行docker容器后, 会将该目录挂载到容器里的/app目录下
# PPS: 运行容器后可按快捷键Ctrl + P + Q返回宿主环境而不退出容器
```