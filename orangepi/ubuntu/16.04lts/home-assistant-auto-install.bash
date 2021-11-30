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

wget -O local https://raw.githubusercontent.com/cmptscpeacock/home-assistant-auto-install/master/local
sudo mv local /etc/apt/apt.conf.d/local

## perform apt update

sudo -i apt update -y && sudo apt upgrade -y

# install various utilities

sudo -i apt install -y python-pip python3-dev python3-pip python3-venv git ffmpeg nginx nmap cmake build-essential libssl-dev libffi-dev python-dev

# install setuptools and upgrade pip

sudo -i -H pip install setuptools
sudo -i -H pip install --upgrade pip

# change directory

cd /home/homeassistant

# install home assistant

python3 -m venv homeassistant
cd homeassistant
source bin/activate
pip install --upgrade pip
python3 -m pip install homeassistant

# setup home assistant service

wget -O home-assistant@homeassistant https://raw.githubusercontent.com/cmptscpeacock/home-assistant-auto-install/master/home-assistantAThomeassistant.service
sudo mv home-assistant@homeassistant /etc/systemd/system/home-assistant@homeassistant.service
sudo -i systemctl enable home-assistant@homeassistant

## output details

printf "\n${RED}${UNDERLINE}Home Assistant URL:${WHITE}${RESETUNDERLINE}  http://1.1.1.1:8123 \n\n"