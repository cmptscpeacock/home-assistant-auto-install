#!/bin/bash

# variables
## credentials

haAdmin='homeassistant'
haUser='user1'

## define console colours

RED='\033[0;31m' # red
WHITE='\033[1;37m' # white

## define formatting

UNDERLINE='\033[4m'
RESETUNDERLINE='\033[24m'

# execute as homeassistant

##(( EUID != 0 )) && exec homeassistant -- "$0" "$@"
##clear

# create local file to prevent prompts when used with apt upgrade

wget -O local https://raw.githubusercontent.com/cmptscpeacock/home-assistant-auto-install/master/rpi4/ubuntu/20.04lts/files/local
sudo mv local /etc/apt/apt.conf.d/local

## perform apt update

sudo -i apt update -y && sudo apt upgrade -y
sudo -i apt update -y && sudo apt upgrade -y

# install docker

printf "\n${RED}${UNDERLINE}Installing Docker${WHITE}${RESETUNDERLINE} \n\n"

sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update
sudo apt-get install -y docker-ce docker-ce-cli containerd.io bash jq curl avahi-daemon dbus

# install home assistant supervisor

printf "\n${RED}${UNDERLINE}Installing Home Assistant Supervisor${WHITE}${RESETUNDERLINE} \n\n"

sudo curl -sL https://raw.githubusercontent.com/cmptscpeacock/home-assistant-auto-install/master/rpi4/ubuntu/20.04lts/installer.sh | bash -s -- -m raspberrypi4-64

## output details

printf "\n${RED}${UNDERLINE}Home Assistant URL:${WHITE}${RESETUNDERLINE}  http://x.x.x.x:8123 \n\n"