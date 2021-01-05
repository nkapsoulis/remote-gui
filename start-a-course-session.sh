#!/bin/bash

# Fancy Output Vars

RESET='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
BOLD=$(tput bold)
NORMAL=$(tput sgr0)

# A student's connection

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

unset APP
unset APP_WEB
unset NGROK
unset APP_PORT
unset NGROK_PORT

# Another student's connection

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
