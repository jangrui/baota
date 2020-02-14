# docker 部署宝塔面板

[![](https://images.microbadger.com/badges/version/jangrui/baota.svg)](https://microbadger.com/images/jangrui/baota "jangrui/baota:latest")
[![](https://images.microbadger.com/badges/image/jangrui/baota.svg)](https://microbadger.com/images/jangrui/baota "jangrui/baota:latest")

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

`/www` 文件夹保存在 `volume` 卷中, `/www/wwwroot` 映射到宿主机的目录下,方便上传网站代码等文件

面板数据都保存在持久化的卷中, 即使删除容器（不删除volume）后重新运行, 原来的面板和网站数据都能得到保留。启动容器时自动启动所有服务。
