#!/bin/bash

## CHANGE PASSWD EVERY YEAR ON FILES .env1, .env2

# Formatted output
RESET='\033[0m'
GREEN='\033[0;32m'
BOLD=$(tput bold)
NORMAL=$(tput sgr0)

# A student's connection
unset APP
unset APP_WEB
unset NGROK
unset APP_PORT
unset NGROK_PORT
set -a
source .env1
set +a
source package/build-and-run.sh
source caddy/build-and-run.sh

URL="http://$(docker port $NGROK 4040)/api/tunnels"
sleep 1
URLS=$(curl $URL | grep -Po '"public_url":.*?[^\\]",')
printf "${GREEN}""${URLS}""${RESET}" | grep https
printf "${RESET}"

# Another student's connection
unset APP
unset APP_WEB
unset NGROK
unset APP_PORT
unset NGROK_PORT
set -a
source .env2
set +a
source package/build-and-run.sh
source caddy/build-and-run.sh

URL="http://$(docker port $NGROK 4040)/api/tunnels"
sleep 1
URLS=$(curl $URL | grep -Po '"public_url":.*?[^\\]",')
printf "${GREEN}""${URLS}""${RESET}" | grep https
printf "${RESET}"
