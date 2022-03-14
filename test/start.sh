#!/bin/sh
docker ps -a | awk '/docker-shopware/{print $1}' | xargs docker kill
sleep 2
docker ps -a | awk '/docker-shopware/{print $1}' | xargs docker rm
sleep 2
docker images -a | awk '/docker-shopware/{print $1}' | xargs docker rmi
sleep 2
docker volume ls | awk '/docker-shopware/{print $2}' | xargs docker volume rm
sleep 2
docker-compose build --no-cache
docker-compose up -d
