#!/bin/bash
## From: https://github.com/pch18-docker/baota/blob/clear/entrypoint.sh

if [ ! -f "/etc/ssh/ssh_host_rsa_key" ];then
    ssh-keygen -t rsa -N '' -q -f /etc/ssh/ssh_host_rsa_key
fi

if [ ! -f "/root/.ssh/id_rsa_${SSH_PORT}" ];then
    ssh-keygen -t rsa -N '' -q -f /root/.ssh/id_rsa_${SSH_PORT}
    cat /root/.ssh/id_rsa_${SSH_PORT}.pub >> /root/.ssh/authorized_keys
    _f1='{"username": "root", "pkey": "'
    _f2=$(sed s/$/'\\n'/ /root/.ssh/id_rsa_${SSH_PORT} | tr -d '\r\n')
    _f3='", "is_save": "1", "c_type": "True", "host": "127.0.0.1", "password": "", "port": "'"${SSH_PORT}"'"}'
    echo "${_f1}${_f2}${_f3}" | base64 | tr -d '\r\n '| od -An -tx1 | tr -d '\r\n ' > "/www/server/panel/config/t_info.json"
fi

if [ `grep "Port ${SSH_PORT}" /etc/ssh/sshd_config|wc -l` -eq 0 ];then
    echo "Port ${SSH_PORT}" >> /etc/ssh/sshd_config
fi

ls /etc/init.d |xargs -I {} sh -c "/etc/init.d/{} restart"

tail -f /dev/null
