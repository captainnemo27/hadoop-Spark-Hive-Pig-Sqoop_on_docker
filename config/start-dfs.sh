#!/usr/bin/env bash

echo "starting dfs daemons"

hadoop-daemon.sh --config $HADOOP_CONF_DIR start namenode
hadoop-daemon.sh --config $HADOOP_CONF_DIR start secondarynamenode
hadoop-daemon.sh --config $HADOOP_CONF_DIR start datanode

# eof
