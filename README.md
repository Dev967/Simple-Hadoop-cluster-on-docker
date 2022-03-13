![](https://external-content.duckduckgo.com/iu/?u=https%3A%2F%2Ftse2.mm.bing.net%2Fth%3Fid%3DOIP.0PlozBoD9DCXtvwadQ28ZQHaEA%26pid%3DApi&f=1)

## I also have a descriptive article on Medium  '[How To setup a simple Hadoop cluster on Docker](https://medium.com/@devparmar967/how-to-setup-simple-hadoop-cluster-on-docker-5d8f56013f29)'

# Simple Hadoop Cluster on Docker

This is a very simple setup for Hadoop cluster using docker. Explanation for every command or step is written as comment in all files. 

## Structure:
There are three major parts of this setup, 
- **Hadoop Base image** : This image contains configurations and setup of Hadoop and Java.
- **Name Node** : This is located under /hdfs/namenode and extends to Hadoop Base Image. All configurations and assets required for this are located under same folder.
- **Data Node**: Located under /hdfs/datanode. Mostly is same is same as Namenode just needs to start a different process thus it extends to Namenode instead of directly extending to Hadoop Base Image.

# Hadoop Base Image:
This image lays the base for other images to be built on. First thing we need to do is install Hadoop and Java. I have provided Java 8 and Hadoop 3.3.1 but you can change it and rebuilt the image. All configurations related to YARN should be done here.
All instructions can be found in **/Dockerfile**.

## Configurations:
- **core-site.xml**: under /config-files are located common configurations. **core-site.xml**. Any configuration specific for NameNode or DataNode can also be done here or in there specific configuration file i.e. **hdfs-site.xml**

- **hadoop-env**: This script file contains env variables necessary for Hadoop to run. For now we just need one variable that is **JAVA_HOME**.

## Scripts:
- **start-hdfs**: starts a hadoop cluster with 1 Namenode and 3 Datanode. it also attaches the last Datanode to the current terminal for operating in cluster.
> NOTE: it is necessary that all containers starting should be under same network. By default they run under *dock_net*

**scripts** foder contains some handy scripts that could be used when experimenting with the cluster.

- **cleanup**: this script will remove all running and dangling containers

- **build**: this script could be used to build the base image for hadoop. Scripts for building NameNode and DataNode can be found in their individual folder.

# HDFS:
This folder contains images for NameNode and DataNode that together forms HDFS or Hadoop Distributed File System.

## **NameNode:**

## Configurations:
This Folder contains configurations for NameNode. It basically contains directory for storing data(**/opt/hdfs/namenode**) and block size.
> NOTE: the directory for storing data should already be created or it will throw error. The command for making the directory is located in Dockerfile

## Scripts:
contains scripts for building and running NameNode. Though it is for testing if you want to run NameNode in cluster mode please use *start_hdfs.sh*

## **DataNode**

## Configurations:
The configuration is same as for NameNode. No additional configuration is needed.

## DockerFile:
everything remains same as NameNode. You just neet to start **datanode** process while we started process **namenode** when building Namenode's docker images