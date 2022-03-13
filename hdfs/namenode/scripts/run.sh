docker run --net dock_net --hostname namenode-master -p 9870:9870 namenode:latest
# !! IMPORTANT
# do not change dock_net, if you do make sure its same everywhere.
# AND do not change hostname 'namenode-master' if you do MAKE SURE to change it in /hadoop/config-files/core-site.xml
# AND MAKE SURE latest image of 'hadoop_base' is built with this new configuration

# For debugging. run with -it. and you will be logged in to the container.
# move around, check all config files are correct, all envirnment variables are correct etc. 
# and you can access WEB UI from namenode at 0.0.0.0:9870
# docker run -it --net dock_net -p 9870:9870 --hostname namenode-master namenode:latest /bin/bash