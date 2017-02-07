#!/bin/bash

if [ -z "$CONSULDATA" ]; then export CONSULDATA="/tmp/consul-data";fi
if [ -z "$CONSULDIR" ]; then export CONSULDIR="/consul";fi
if [ "$(ls -A $CONSULDIR)" ]; then
    exec consul agent -data-dir=$CONSULDATA -config-dir=$CONSULDIR &
fi
PID=$!
wait $PID
trap - TERM INT
wait $PID
