FROM jangrui/baota:lnm AS lnmp

LABEL org.opencontainers.image.authors="jangrui <admin@jangrui.com>"

ARG PHP_VERSION=5.5
ARG FTP_VERSION=1.0
ARG INSTALL_SHELL=/www/server/panel/install/install_soft.sh

RUN bash ${INSTALL_SHELL} 0 install php ${PHP_VERSION}
RUN bash ${INSTALL_SHELL} 0 install pureftpd ${FTP_VERSION}

RUN yum clean all && \
    rm -rf /var/cache/yum/* && \
    echo '["webssh", "nginx", "mysql", "php-5.5", "pureftpd"]' > /www/server/panel/config/index.json

COPY entrypoint.sh entrypoint.sh

ENTRYPOINT bash /entrypoint.sh
