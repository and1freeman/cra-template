#!/bin/bash

# https://spin.atomicobject.com/2017/08/24/start-stop-bash-background-process/
trap "exit" INT TERM ERR
trap "kill 0" EXIT

./scripts/watch.sh /components &
./scripts/watch.sh /hooks &

yarn start
