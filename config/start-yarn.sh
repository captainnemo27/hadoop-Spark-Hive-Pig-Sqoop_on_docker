#!/usr/bin/env bash

echo "starting yarn daemons"

yarn-daemon.sh --config $HADOOP_CONF_DIR start resourcemanager
yarn-daemon.sh --config $HADOOP_CONF_DIR start nodemanager

# eof
