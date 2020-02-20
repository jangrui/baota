FROM ubuntu AS builder

LABEL org.label-schema.vcs-url="https://github.com/jangrui/baota" \
      org.label-schema.vendor="jangrui <admin@jangrui.com>"

ARG TZ=Asia/Shanghai
ARG DEBIAN_FRONTEND=noninteractive
ENV SSH_PORT=${SSH_PORT:-3322}

RUN sed -i "s,//.*.ubuntu.com,//mirrors.aliyun.com,g" /etc/apt/sources.list \
    && apt-get update && apt-get install -y locales curl vim openssh-server tzdata \
    && localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8 \
    && rm -rf /var/lib/apt/lists/* \
    && ln -sf /usr/share/zoneinfo/${TZ} /etc/localtime \
    && dpkg-reconfigure -f noninteractive tzdata \
    && echo "Port ${SSH_PORT}" >> /etc/ssh/sshd_config

ENV LANG en_US.utf8


FROM builder AS baota

RUN curl -sSo install.sh http://download.bt.cn/install/new_install.sh \
    && echo y | bash install.sh \
    && rm -rf install.sh /var/lib/apt/list/*

ARG BT_PORT=8888
ARG USERNAME=username
ARG PASSWORD=password

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh \
    && /etc/init.d/bt 11 \
    && echo ${BT_PORT} | /etc/init.d/bt 8 \
    && echo ${USERNAME} | /etc/init.d/bt 6 \
    && echo ${PASSWORD} | /etc/init.d/bt 5

CMD /entrypoint.sh
EXPOSE ${BT_PORT} ${SSH_PORT}
HEALTHCHECK --interval=5s --timeout=3s CMD curl -fs http://localhost:${BT_PORT} || exit 1 
