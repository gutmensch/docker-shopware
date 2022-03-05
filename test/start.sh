#!/bin/sh
docker ps -a | awk '/shopware/{print $1}' | xargs docker kill; docker ps -a | awk '/shopware/{print $1}' | xargs docker rm; docker-compose build --no-cache; docker-compose up -d
