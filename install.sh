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
    gpg-agent \
    gnupg \
    software-properties-common \
    stow \
    tmux \
    vim \
    snapd

echo -e "${GREEN}Remove unused components${NC}"
sudo apt-get -y autoremove

echo -e "${GREEN}Install ks to simplify server management${NC}"
git clone https://github.com/maptile/ks.git ~/.ks

if ! grep -q 'PATH="$HOME/.ks:$PATH"' ~/.profile ; then
    sed -i '$ a\
if [ -d "$HOME/.ks/" ] ; then\
    PATH="$HOME/.ks:$PATH"\
fi\
  ' ~/.profile
fi

echo -e "${GREEN}Install dotfiles${NC}"
git clone https://github.com/maptile/dotfiles.git ./.dotfiles

cd .dotfiles

stow .

cd ~

echo -e "${GREEN}Installing docker${NC}"
sudo apt-get remove -y docker docker-engine docker.io containerd runc

sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

sudo apt-get -y install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

sudo groupadd docker
sudo usermod -aG docker $USER

echo -e "${GREEN}Installing snap core and install certbot via snap${NC}"
sudo snap install core
sudo snap refresh core
sudo apt-get remove certbot
sudo snap install --classic certbot
sudo ln -s /snap/bin/certbot /usr/bin/certbot

echo -e "${GREEN}Enabling BBR${NC}"

if [ ! -f /etc/sysctl.d/999-custom-kernel-bbr.conf ]; then
    echo 'net.core.default_qdisc=fq' | sudo tee -a /etc/sysctl.d/999-custom-kernel-bbr.conf
    echo 'net.ipv4.tcp_congestion_control=bbr' | sudo tee -a /etc/sysctl.d/999-custom-kernel-bbr.conf

    sudo sysctl --system
fi

echo -e "${GREEN}Enabling BBR result${NC}"
sysctl net.core.default_qdisc
sysctl net.ipv4.tcp_congestion_control

echo -e "${GREEN}Adding swapfile${NC}"

sudo dd if=/dev/zero of=/swapfile1 bs=1024 count=1048576
sudo chown root:root /swapfile1
sudo chmod 0600 /swapfile1
sudo mkswap /swapfile1
sudo swapon /swapfile1

echo -e "${GREEN}Change Swappiness to 10${NC}"

if [ ! -f /etc/sysctl.d/999-custom-swappiness.conf ]; then
    echo 'vm.swappiness=10' | sudo tee -a /etc/sysctl.d/999-custom-swappiness.conf
fi

echo -e "${GREEN}
DONE.
Please consider more steps:
* change hostname in /etc/hostname
* add other ssh pubkeys to ~/.ssh/authorized_keys
* append '/swapfile1 none swap sw 0 0' to '/etc/fstab'
* logout and login then you can run docker commands without sudo${NC}"
