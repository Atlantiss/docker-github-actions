#!/bin/bash

if [[ "$@" == "bash" ]]; then
    exec $@
fi

service mysql start

exec "$@"