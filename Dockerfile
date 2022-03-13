FROM ubuntu:latest

#environment variables for changing JDK, HADOOP versions and directoris
ENV JDK_VER=16.0.1
ENV HADOOP_VER=3.3.1
ENV JDK_TAR_NAME=jdk.tar.gz
ENV HADOOP_TAR_NAME=hadoop.tar.gz


#NOTE -- in case you want to install different JDK or HADOP version, 
#download and put the file in ./assets folder and rename it to jdk.tar.gz and hadoop.tar.gz
# OR change JDK_TAR_NAME and HADOOP_TAR_NAME above
#YOU ALSO NEED TO CHANGE NAME IN 'JAVA_HOME' ENVIRONMENT VARIABLE BELOW SAME GOES FOR HADOOP

#install basic utils and python
RUN apt update
RUN apt install -y arp-scan python3

#***setup JDK***#
WORKDIR /opt
ADD ./assets/${JDK_TAR_NAME} .
#ADD automatically untars

#add path variables for JDK
ENV JAVA_HOME=/opt/java-se-8u41-ri

ENV PATH=$PATH:$JAVA_HOME:$JAVA_HOME/bin
#TESTIGN
#RUN java --version

#***setup hadoop***#
ADD ./assets/${HADOOP_TAR_NAME} .

#adding path variables and environment variables for HADOOP
ENV HADOOP_HOME=/opt/hadoop-${HADOOP_VER}
ENV HADOOP_STREAMING_JAR=$HADOOP_HOME/share/hadoop/tools/lib/hadoop-streaming-3.3.1.jar
ENV PATH=$PATH:$HADOOP_HOME
ENV PATH=$PATH:$HADOOP_HOME/bin
#after this all binaries are availabes ash shell comand, which means you can directly use 
#$hdfs or $hadoop instad of /opt/hadoop-3.3.1/bin/hdfs or /opt/hadoop-3.3.1/bin/hadoop

#***CONFIGURATION***#
#adding hadoop configuration files
ADD ./config-files/hadoop-env.sh $HADOOP_HOME/etc/hadoop/
ADD ./config-files/core-site.xml $HADOOP_HOME/etc/hadoop/

#!!! IMPORTANT
# datanodes connect to namenode and for that they should know namenode's hostname and port. \
# this is specified in core-site.xml
# by default i am using hostname 'namenode-master' and port '8020'. if you change this in core-site.xml then all
# datanodes would be trying to connect to your changed hostname and port. 
# So be sure to change your namenode's to hostname to whatever you specified in core-site.xml
# by default docker assigns random hostnames to containers. hdfs/namenode/scripts/run.sh shows how to run a container with custom hostname.

#TESTING
# RUN $HADOOP_HOME/bin/hadoop

#this image is supposed to work as base for other images. still if you want to move explore around you can start the cntainer in integrated terminal.
#$docker run -it hadoop_base

CMD /bin/bash