#!/bin/bash

# variables
## credentials
haAdmin='homeassistant'
haUser='user1'

## define console colours
RED='\033[0;31m'    # red
WHITE='\033[1;37m'  # white

## define formatting
UNDERLINE='\033[4m'
RESETUNDERLINE='\033[24m'

# Update and upgrade apt packages
printf "\n${RED}${UNDERLINE}Updating and upgrading packages...${WHITE}${RESETUNDERLINE}\n\n"
sudo apt-get update -y
sudo apt-get upgrade -y

# Install Docker
printf "\n${RED}${UNDERLINE}Installing Docker...${WHITE}${RESETUNDERLINE}\n\n"

# Install dependencies for adding Docker's repository
sudo apt-get install -y ca-certificates curl gnupg

# Add Docker's official GPG key
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the Docker repository to Apt sources
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Update the apt package index with the new repository
sudo apt-get update -y

# Install Docker and other required packages
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin bash jq curl avahi-daemon dbus

# Install Home Assistant Supervised
printf "\n${RED}${UNDERLINE}Installing Home Assistant - Supervisor${WHITE}${RESETUNDERLINE} \n\n"
# This installer script is designed for specific Raspberry Pi models.
# The `raspberrypi4-64` model is the closest match for the RPi5 64-bit architecture.
sudo curl -sL https://raw.githubusercontent.com/cmptscpeacock/home-assistant-auto-install/master/rpi5/debian/installer.sh | bash -s -- -m raspberrypi4-64

# Output details
ip4=$(/sbin/ip -o -4 addr list eth0 | awk '{print $4}' | cut -d/ -f1)
printf "\n${RED}${UNDERLINE}Home Assistant URL:${WHITE}${RESETUNDERLINE}  http://${ip4}:8123 \n\n"