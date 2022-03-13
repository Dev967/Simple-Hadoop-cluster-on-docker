docker build . -t hadoop_base:1
# do not change tag 'hadoop_base'. It is being used as base for other images. 
#If you do be sure to change it in all Dockerfiles where specified FROM hadooop_base. 