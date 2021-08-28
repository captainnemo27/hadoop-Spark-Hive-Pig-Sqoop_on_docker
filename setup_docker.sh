#After install project, create hadoop-network with command:
docker network create --driver bridge hadoop-network --subnet=172.12.0.0/16
# If you want to use a client connect accross docker , you can use network overlay:
# docker network create -d overlay my-overlay
# docker network create -d overlay --attachable my-attachable-overlay
#Setup docker volume:
docker volume create --name=myhadoop

#Then, you go into the project and run command to build the hadoop cluster:
docker-compose build
#Final, you run:
#docker-compose up -d

#Congratulation, you have completed build and run a hadoop cluster 3 node with docker.
# You can attach into any node by attach or exec docker command, ex:
# docker exec -it master /bin/bash
