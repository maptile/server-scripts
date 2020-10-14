#!/usr/bin/env bash

# Color
GREEN='\033[0;32m'
NC='\033[0m'

# Change current dir to user home
echo -e "${GREEN}Changing to home directory${NC}"
cd ~

echo -e "${GREEN}Upgrading base system${NC}"
sudo apt-get -y update
sudo apt-get -y upgrade

echo -e "${GREEN}Installing common dependencies${NC}"
sudo apt-get install -y \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common \
    stow \
    tmux \
    vim

echo -e "${GREEN}Remove unused components${NC}"
sudo apt-get -y autoremove

echo -e "${GREEN}Install dotfiles${NC}"
git clone https://github.com/maptile/dotfiles.git ./.dotfiles

cd .dotfiles

stow .

cd ~

echo -e "${GREEN}Installing docker${NC}"
sudo apt-get remove -y docker docker-engine docker.io containerd runc

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88

sudo add-apt-repository \
   "deb [arch=amd64] https://download.docker.com/linux/ubuntu \
   $(lsb_release -cs) \
   stable"

sudo apt-get update

sudo apt-get -y install docker-ce docker-ce-cli containerd.io

echo -e "${GREEN}Installing docker-compose${NC}"
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

sudo groupadd docker
sudo usermod -aG docker $USER

echo -e "${GREEN}Installing snap core and install certbot via snap${NC}"
sudo snap install core
sudo snap refresh core
sudo apt-get remove certbot
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot

echo -e "${GREEN}DONE. Please logout and login then you can run docker commands without sudo${NC}"