#!/bin/bash

#required packages
sudo apt-get update

sudo apt-get install -y docker.io

sudo service docker start

sudo usermod -a -G docker ubuntu

sudo apt-get install -y git

sudo mkdir /home/ubuntu/p360

echo "directory created"

#import packages from github/bitbucket with application

sudo git clone https://github.com/amachira/p360.git /home/ubuntu/p360/


sudo service docker restart

#update docker version to the latest 
curl -fsSL https://get.docker.com/ | sh


#join docker swarm to make worker nodes
docker swarm join --token SWMTKN-1-1zomu55zn790ok2fsr8tmdo06s2vkfqtlrlomf7de3y1dvorck-9s5tto1lckplihch3zklcdq7j 172.31.21.12:2377

