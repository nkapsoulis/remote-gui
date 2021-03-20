#!/bin/bash

# source ../.env

# docker volume create $APP_DOCKER_VOLUME # if $APP_DOCKER_VOLUME not present then create per student
# docker network create $APP_DOCKER_NETWORK

# docker build -t $APP_IMAGE package/.
docker run -d --restart=always --volume=$APP_DOCKER_VOLUME:/data --net=$APP_DOCKER_NETWORK --name=$APP $APP_IMAGE

