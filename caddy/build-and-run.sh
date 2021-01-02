#! /bin/bash

PASSWD='javaedu2021'

docker rm -f sublime-caddy sublime-ngrok
docker build -t sublime-caddy .
docker run --detach --restart=always --volume=sublime-data:/data --net=sublime-net --name=sublime-web --env=APP_USERNAME="student" --env=APP_PASSWORD_HASH="$(docker run --rm -it sublime-caddy caddy hash-password -plaintext $PASSWD)" --publish=8080:8080 sublime-caddy
docker run -d -p 4040:4040 --net sublime-net --name sublime-ngrok wernight/ngrok ngrok http sublime-web:8080
curl $(docker port sublime-ngrok 4040)/api/tunnels | grep -Po '"public_url":.*?[^\\]",'
