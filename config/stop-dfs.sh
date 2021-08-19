
#!/usr/bin/env bash

echo "stopping dfs daemons"

hadoop-daemon.sh --config $HADOOP_CONF_DIR stop namenode
hadoop-daemon.sh --config $HADOOP_CONF_DIR stop secondarynamenode
hadoop-daemon.sh --config $HADOOP_CONF_DIR stop datanode

# eof
