#!/usr/bin/env bash

echo "stopping yarn daemons"

yarn-daemon.sh --config $HADOOP_CONF_DIR stop resourcemanager
yarn-daemon.sh --config $HADOOP_CONF_DIR stop nodemanager

# eof
