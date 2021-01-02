#!/bin/bash

while read line; do
 if [ "${line:0:5}" == "NGROK" ]; then
   export $line
 fi
done < .env1

curl $(docker port $NGROK 4040)/api/tunnels | grep -Po '"public_url":.*?[^\\]",'

unset $NGROK
while read line; do
 if [ "${line:0:5}" == "NGROK" ]; then
   export $line
 fi
done < .env2

curl $(docker port $NGROK 4040)/api/tunnels | grep -Po '"public_url":.*?[^\\]",'

