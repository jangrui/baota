# docker 部署宝塔面板

[![](https://images.microbadger.com/badges/version/jangrui/baota:latest.svg)](https://microbadger.com/images/jangrui/baota:latest "jangrui/baota:latest")
[![](https://images.microbadger.com/badges/image/jangrui/baota:latest.svg)](https://microbadger.com/images/jangrui/baota:latest "jangrui/baota:latest")

>  基于 Ubuntu 镜像构建宝塔面板。

## 通过 bridge 模式运行宝塔镜像

```
git clone https://github.com/jangrui/baota
cd baota
docker-compose pull
docker-compose up -d
```

> [docker && compose 安装](https://notes.jangrui.com/#/docker/install?id=docker-%e5%ae%89%e8%a3%85%e5%8f%8a%e5%8a%a0%e9%80%9f)

## 通过 host 模式运行宝塔镜像

```
sed -i "s,# network_mode,network_mode," docker-compose.yml
docker-compose up -d
```

> host 网络模式，不需要设置映射端口，自动映射宝塔面板全端口到外网。（macos 和 windows 不支持 host）

## 登录方式

- 登陆地址 `http://{{面板ip地址}}:8888`
- 初始账号 `username`
- 初始密码 `password`

> 已经去除安全入口，且默认账号密码、端口设置成上述账号密码、端口，请登陆后第一时间修改账号密码，及端口！

## 数据持久化

- `/www` 映射到宿主机的 `volume` 卷中（`/var/lib/docker/volumes/$(basename $PWD)/_data/`）。
- `/www/backup` 映射到当前目录下的 `www/backup` 目录。
