#!/bin/bash

if [ -f /usr/sbin/sshd ];then
    echo "Starting sshd ..."
    /usr/sbin/sshd
fi

if [ -f /usr/sbin/crond ];then
    echo "Starting crond ..."
    /usr/sbin/crond
fi

if [ -f /www/server/nginx/sbin/nginx ];then
    echo "Starting nginx ..."
    /www/server/nginx/sbin/nginx
fi

if [[ -n $BT_PASSWORD ]];then
    echo "Starting to modify panel password ..."
    echo "$BT_PASSWORD" | /etc/init.d/bt 5
fi

if [[ -n $BT_USERNAME ]];then
    echo "Starting to modify panel username ..."
    echo "$BT_USERNAME" | /etc/init.d/bt 6
fi

if [[ -n $BT_PORT ]];then
    echo "Starting to modify panel port ..."
    echo "$BT_PORT" | /etc/init.d/bt 8
fi

echo "Starting to clear login restrictions ..."
/etc/init.d/bt 10

echo "Starting to remove entry restrictions ..."
/etc/init.d/bt 11

echo "Starting to remove entry restrictions ..."
/etc/init.d/bt 12

echo "Starting to remove entry restrictions ..."
/etc/init.d/bt 13

echo "Starting to turn off BasicAuth authentication ..."
/etc/init.d/bt 23

echo "Starting to turn off Google authentication ..."
/etc/init.d/bt 24

echo "Starting to clear panel cache ..."
/etc/init.d/bt 9

if [ -f /etc/init.d/mysqld ];then
    echo "Starting MySQL ..."
    /etc/init.d/mysqld start
fi

if [ -f /etc/init.d/pure-ftpd ];then
    echo "Starting pure-ftpd ..."
    /etc/init.d/pure-ftpd start
fi

if [ -f /etc/init.d/php-fpm-55 ];then
    echo "Starting php-fpm-55 ..."
    /etc/init.d/php-fpm-55 start
fi

tail -f /www/server/panel/logs/*.log
