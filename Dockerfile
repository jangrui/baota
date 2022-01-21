FROM centos:7 AS builder

LABEL org.opencontainers.image.authors="jangrui <admin@jangrui.com>"

ARG TZ=Asia/Shanghai
ARG DEBIAN_FRONTEND=noninteractive

RUN yum update -y \
    && yum install -y openssh-server \
    && ssh-keygen -t rsa -N '' -q -f /etc/ssh/ssh_host_rsa_key \
    && ssh-keygen -t rsa -N '' -q -f /root/.ssh/id_rsa \
    && cat /root/.ssh/id_rsa.pub >> /root/.ssh/authorized_keys \
    && sed -i '/ssh_host_ecdsa_key/ s|.*|# &|' /etc/ssh/sshd_config \
    && sed -i '/ssh_host_ed25519_key/ s|.*|# &|' /etc/ssh/sshd_config \
    && ln -sf /usr/share/zoneinfo/$TZ /etc/localtime \
    && curl -sSo install.sh http://download.bt.cn/install/install_6.0.sh \
    && echo y | bash install.sh \
    && rm -rf install.sh \
    && yum clean all

FROM builder AS base

LABEL org.opencontainers.image.authors="jangrui <admin@jangrui.com>"

ARG BT_PORT=8888
ARG BT_USERNAME=username
ARG BT_PASSWORD=password

COPY entrypoint.sh entrypoint.sh

RUN echo $BT_PORT | /etc/init.d/bt 8 \
    && echo $BT_USERNAME | /etc/init.d/bt 6 \
    && echo $BT_PASSWORD | /etc/init.d/bt 5

EXPOSE $BT_PORT

VOLUME [ "/www/backup", "/www/server", "/www/wwwlogs", "/www/wwwroot" ]

ENTRYPOINT bash /entrypoint.sh

HEALTHCHECK --interval=5s --timeout=3s CMD curl -fs http://localhost:8888/  || exit 1 

