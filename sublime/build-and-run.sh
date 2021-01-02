#!/bin/bash

docker rm -f sublime-app sublime-web
docker build -t sublime .
# docker network create sublime-net
# docker volume create sublime-data
docker run -d --restart=always --volume=sublime-data:/data --net=sublime-net --name=sublime-app sublime

