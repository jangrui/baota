FROM jangrui/baota:base AS ln

LABEL org.opencontainers.image.authors="jangrui <admin@jangrui.com>"

ARG NGINX_VERSION=1.21
ARG INSTALL_SHELL=/www/server/panel/install/install_soft.sh

RUN bash ${INSTALL_SHELL} 0 install nginx ${NGINX_VERSION} && \
    yum clean all && \
    echo '["webssh", "nginx"]' > /www/server/panel/config/index.json
