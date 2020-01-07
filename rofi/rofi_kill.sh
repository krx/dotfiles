#!/usr/bin/env bash

if [ "$@" ]
then
    PID=$(echo "$1" | awk '{print $1}')
    kill "$PID"
else
    ps a -u "$(whoami)" --no-headers -o pid,cmd | awk '{print $1,$2}'
fi
