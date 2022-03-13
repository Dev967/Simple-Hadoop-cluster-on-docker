#!/bin/bash

#Automatical stats one namenode and 3 datanodes in a docker network

#namenode
docker run -d --net dock_net --hostname namenode-master -p 9870:9870 -p 50030:50030 -p 8020:8020 --name namenode namenode:latest

#datanode 1
docker run -d --net dock_net --name datanode1 datanode:latest

#datanode 2
docker run -d --net dock_net --name datanade2 datanode:latest

#datanode 3
docker run -d --net dock_net --name datanode3 datanode:latest

#datanode for operating hadoop cluster(attached to current terminal)
docker run -it --net dock_net --name datanode_for_use datanode:latest /bin/bash

