#!/bin/bash

if [[ "$@" == "bash" ]]; then
    exec $@
fi

sudo systemctl start mariadb

exec "$@"