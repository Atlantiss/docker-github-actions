#!/bin/bash

if [[ "$@" == "bash" ]]; then
    exec $@
fi

systemctl start mariadb

exec "$@"