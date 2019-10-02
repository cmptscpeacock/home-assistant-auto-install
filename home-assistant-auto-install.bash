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

(( EUID != 0 )) && exec homeassistant -- "$0" "$@"
clear

## Perform apt update

sudo apt update -y --force-yes && apt upgrade -y --force-yes

# install various utilities

sudo apt install -y --force-yes python-pip python3-dev python3-pip python3-venv git ffmpeg nginx nmap cmake build-essential libssl-dev libffi-dev python-dev

# install setuptools and upgrade pip

sudo -H pip install setuptools
sudo -H pip install --upgrade pip

# install home assistant

python3 -m venv homeassistant
cd homeassistant
source bin/activate
pip install --upgrade pip
python3 -m pip install homeassistant

# setup home assistant service

wget -O home-assistant@homeassistant https://raw.githubusercontent.com/cmptscpeacock/home-assistant-auto-install/master/home-assistantAThomeassistant.service
mv home-assistant@homeassistant /etc/systemd/system/home-assistant@homeassistant.service
sudo systemctl enable home-assistant@homeassistant

## output details

printf "\n${RED}${UNDERLINE}Home Assistant URL:${WHITE}${RESETUNDERLINE}  http://1.1.1.1:8123 \n\n"