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

## Perform apt update

sudo -i apt update -y && sudo apt upgrade -y
sudo -i apt update -y && sudo apt upgrade -y

# install docker

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


sudo su
sudo curl -sL https://raw.githubusercontent.com/cmptscpeacock/home-assistant-auto-install/master/rpi4/ubuntu/20.04lts/installer.sh | bash -s -- -m raspberrypi4-64

# install various utilities

sudo -i apt install -y python3-dev python3-pip python3-venv git ffmpeg nginx nmap cmake build-essential libssl-dev libffi-dev python-dev python3-testresources
sudo -i apt install -y python3-dev python3-pip python3-venv git ffmpeg nginx nmap cmake build-essential libssl-dev libffi-dev python-dev python3-testresources

# install setuptools and upgrade pip

sudo -i -H pip install setuptools
sudo -i -H pip install --upgrade pip

# change directory

cd /home/homeassistant

# install home assistant

sudo python3.8 -m venv homeassistant
cd homeassistant
source bin/activate
#sudo pip install --upgrade pip
sudo python3 -m pip install wheel
sudo pip3 install homeassistant --ignore-installed PyYAML
#sudo python3 -m pip install homeassistant --ignore-installed PyYAML

# setup home assistant service

wget -O home-assistant@homeassistant https://raw.githubusercontent.com/cmptscpeacock/home-assistant-auto-install/master/home-assistantAThomeassistant.service
sudo mv home-assistant@homeassistant /etc/systemd/system/home-assistant@homeassistant.service
sudo -i systemctl enable home-assistant@homeassistant

## output details

printf "\n${RED}${UNDERLINE}Home Assistant URL:${WHITE}${RESETUNDERLINE}  http://1.1.1.1:8123 \n\n"