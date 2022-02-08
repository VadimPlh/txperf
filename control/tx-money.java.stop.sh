#!/bin/bash

set -e

if [ ! -f /mnt/vectorized/workloads/logs/tx-money.pid ]; then
    exit 0
fi

pid=$(cat /mnt/vectorized/workloads/logs/tx-money.pid)

if [ $pid == "" ]; then
    exit 0
fi

if ps -p $pid; then
    kill -9 $pid
fi

rm /mnt/vectorized/workloads/logs/tx-money.pid