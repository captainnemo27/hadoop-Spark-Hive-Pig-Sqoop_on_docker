# ***HADOOP WITH DOCKER***

## ***INTRODUCTION***

* The hadoop cluster in project include 3 node: 1 master and 2 slave (slave1 and slave2)
* Version <table>

    <tr>
        <td>Hadoop</td>
        <td>2.2.7</td>
    </tr>
    <tr>
        <td>Java</td>
        <td>1.8</td>
    </tr>
    <tr>
        <td>Docker</td>
        <td>20.10.5</td>
    </tr>
   </table>


## ***INSTALLATION***

* You can install this project in [Hadoop with Docker]()

## ***BUILD***

* After install project, create *hadoop-network* with command: *docker network create --driver bridge hadoop-network --subnet=172.16.0.0/16* 
* Then, you go into the project and run command to build the hadoop cluster: docker-compose build
* Final, you run: *docker-compose up -d*
* Congratulation, you have completed build and run a hadoop cluster 3 node with docker. You can attach into any node by attach or exec docker command, ex: *docker exec -it master /bin/bash*

