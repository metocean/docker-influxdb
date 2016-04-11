#!/bin/sh
set -e

apk update
apk upgrade

# Install influxdb
apk add go git gcc musl-dev
export GOPATH=/tmp/go
go get github.com/influxdata/influxdb
cd /tmp/go/src/github.com/influxdata/influxdb
git checkout v$INFLUXDB_VERSION
export GO_BUILD_OPTIONS="--ldflags '-s -extldflags \"-static\"'"
python build.py
cp ./build/* /usr/bin/
cd /
mkdir /etc/influxdb
cp /install/influxdb.toml /etc/influxdb/influxdb.toml
mkdir /etc/service/influxdb
cp /install/influxdb.sh /etc/service/influxdb/run
apk del go git gcc musl-dev

# Clean up
rm -rf /install
rm -rf /tmp/*
rm -rf /var/cache/apk/*