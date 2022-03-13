docker rm $(docker ps -a -q) #remove all dangling containers
docker rmi $(docker images -f "dangling=true" -q)

# A handy script to remove all unused/dangling images and containers.