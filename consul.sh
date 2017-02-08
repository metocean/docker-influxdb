#!/bin/bash

exec consul agent -data-dir=/tmp/consul-data -config-dir=/consul &

