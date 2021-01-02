#!/bin/bash

# source ../.env

# docker rm -f sublime-app sublime-web
# docker build -t $APP_IMAGE .
# docker network create sublime-net
# docker volume create sublime-data
# docker volume create sublime-dataa
docker run -d --restart=always --volume=$APP_DOCKER_VOLUME:/data --net=$APP_DOCKER_NETWORK --name=$APP $APP_IMAGE

