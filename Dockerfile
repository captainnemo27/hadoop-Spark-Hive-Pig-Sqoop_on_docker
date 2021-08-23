FROM ubuntu
MAINTAINER thangdao2701captain@gmail.com
RUN apt update && apt install -y openssh-server openssh-client vim openjdk-8-jdk
RUN apt update && apt install -y scala git

# SSH
RUN ssh-keygen -t rsa -P '' -f ~/.ssh/id_rsa
RUN cat ~/.ssh/id_rsa.pub >> ~/.ssh/authorized_keys
RUN sed -ri 's/#   StrictHostKeyChecking ask/    StrictHostKeyChecking accept-new/g' /etc/ssh/ssh_config
RUN chmod 0600 ~/.ssh/authorized_keys

RUN echo "root:123" | chpasswd
RUN echo "root   ALL=(ALL)       ALL" >> /etc/sudoers

ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64
ENV PATH $JAVA_HOME/bin:$PATH

# HADOOP
RUN wget https://archive.apache.org/dist/hadoop/common/hadoop-2.7.7/hadoop-2.7.7.tar.gz
RUN tar -xzf hadoop-2.7.7.tar.gz
RUN mv hadoop-2.7.7 usr/local/hadoop
ENV HADOOP_HOME /usr/local/hadoop
ENV HADOOP_CONF_DIR $HADOOP_HOME/etc/hadoop
ENV PATH $HADOOP_HOME/sbin:$PATH


RUN mkdir /home/hadoop
RUN mkdir /home/hadoop/tmp /home/hadoop/hdfs_name /home/hadoop/hdfs_data

ADD config/core-site.xml $HADOOP_HOME/etc/hadoop/core-site.xml
ADD config/hdfs-site.xml $HADOOP_HOME/etc/hadoop/hdfs-site.xml
ADD config/mapred-site.xml $HADOOP_HOME/etc/hadoop/mapred-site.xml
ADD config/yarn-site.xml $HADOOP_HOME/etc/hadoop/yarn-site.xml
ADD config/slaves $HADOOP_HOME/etc/hadoop/slaves
ADD config/start-dfs.sh $HADOOP_HOME/sbin
ADD config/stop-dfs.sh $HADOOP_HOME/sbin
ADD config/start-yarn.sh $HADOOP_HOME/sbin
ADD config/stop-yarn.sh $HADOOP_HOME/sbin

RUN echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> $HADOOP_HOME/etc/hadoop/hadoop-env.sh

ENV PATH $HADOOP_HOME/bin:$PATH
#RUN /bin/bash -c "source ~/.bashrc"


# HIVE
RUN wget https://mirror.downloadvn.com/apache/hive/hive-2.3.9/apache-hive-2.3.9-bin.tar.gz
RUN tar -xzf apache-hive-2.3.9-bin.tar.gz
RUN mv apache-hive-2.3.9-bin /usr/local/hive
ENV HIVE_HOME /usr/local/hive
ENV PATH $HIVE_HOME/bin:$PATH
#RUN /bin/bash -c "source ~/.bashrc"
RUN echo "HADOOP_HOME=/usr/local/hadoop" >> $HIVE_HOME/bin/hive-config.sh

# PIG
RUN wget https://downloads.apache.org/pig/pig-0.17.0/pig-0.17.0.tar.gz
RUN tar -xzf pig-0.17.0.tar.gz 
RUN mv pig-0.17.0 /usr/local/pig
ENV PIG_HOME /usr/local/pig
ENV PATH $PIG_HOME/bin:$PATH
ENV PIG_CLASSPATH $HADOOP_CONF_DIR
#RUN /bin/bash -c "source ~/.bashrc"

# SQOOP
RUN wget http://archive.apache.org/dist/sqoop/1.4.7/sqoop-1.4.7.bin__hadoop-2.6.0.tar.gz
RUN tar -xvf sqoop-1.4.7.bin__hadoop-2.6.0.tar.gz
RUN mv sqoop-1.4.7.bin__hadoop-2.6.0 usr/local/sqoop
ENV SQOOP_HOME /usr/local/sqoop
ENV PATH $SQOOP_HOME/bin:$PATH
ENV CLASSPATH $SQOOP_HOME/lib:$CLASSPATH
ADD config/sqoop-conf.sh $SQOOP_HOME/conf/
#mysql driver
RUN wget http://ftp.ntu.edu.tw/MySQL/Downloads/Connector-J/mysql-connector-java-8.0.26.tar.gz
RUN tar -xvf mysql-connector-java-8.0.26.tar.gz
RUN mkdir -p /usr/local/sqoop/
RUN cp mysql-connector-java-8.0.26/mysql-connector-java-8.0.26.jar /usr/local/sqoop/lib/


#SPARK

RUN wget https://downloads.apache.org/spark/spark-3.0.3/spark-3.0.3-bin-hadoop2.7.tgz
RUN tar xvf spark-3.0.3-bin-hadoop2.7.tgz
RUN mv spark-3.0.3-bin-hadoop2.7 /usr/local/spark
ENV SPARK_HOME /usr/local/spark
ENV PATH $SPARK_HOME/sbin:$PATH
ENV PATH $SPARK_HOME/bin:$PATH


ADD config/slaves $SPARK_HOME/conf/slaves
RUN echo "export SPARK_MASTER_HOST='172.12.0.2'" >> $SPARK_HOME/conf/spark-env.sh
RUN echo "export JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64" >> $SPARK_HOME/conf/spark-env.sh

ARG FORMAT_NAMENODE_COMMAND
RUN $FORMAT_NAMENODE_COMMAND
EXPOSE 22
