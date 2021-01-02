#! /bin/bash

# source ../.env

# docker rm -f sublime-caddy sublime-ngrok
# docker build -t $CADDY_IMAGE .
docker run -d --restart=always --volume=$APP_DOCKER_VOLUME:/data --net=$APP_DOCKER_NETWORK --name=$APP_WEB --env=APP_USERNAME=$USER_NAME --env=APP_PASSWORD_HASH="$(docker run --rm -it $CADDY_IMAGE caddy hash-password -plaintext $PASSWD)" --env=APP_CONTAINER_NAME=$APP --publish=$APP_PORT:8080 $CADDY_IMAGE
docker run -d -p $NGROK_PORT:4040 --net $APP_DOCKER_NETWORK --name $NGROK wernight/ngrok ngrok http $APP_WEB:8080
# curl $(docker port $NGROK 4040)/api/tunnels | grep -Po '"public_url":.*?[^\\]",'
