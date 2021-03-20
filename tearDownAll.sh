#!/bin/bash


# while read line; do
#    export $line
# done < .env1
unset APP
unset APP_WEB
unset NGROK
source .env1
docker rm -f $APP $APP_WEB $NGROK


# while read line; do
   # export $line
# done < .env2
unset APP
unset APP_WEB
unset NGROK
source .env2
docker rm -f $APP $APP_WEB $NGROK
