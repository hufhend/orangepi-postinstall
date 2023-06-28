#   *********************************************
#   OrangePi install - Ubuntu Jammy arm64, part 2
#   begin     : Fri 25 Sep 2020.
#   copyright : (c) 2021 Václav Dvorský
#   email     : vaclav.dvorsky@hotmail.com
#   $Id: debian_install.sh, v3.20 15/09/2021
#   *********************************************
#
#   --------------------------------------------------------------------
#   This program is free software; you can redistribute it and/or modify
#   it under the terms of the GNU General Public Licence as published by
#   the Free Software Foundation; either version 2 of the Licence, or
#   (at your option) any later version.
#   --------------------------------------------------------------------

#!/bin/bash
if ! [ $(id -u) = 0 ]; then
    id -nG
    docker run hello-world
    docker ps -a
    systemctl is-enabled docker
    # install Docker Compose v2
    # sudo curl -L "https://github.com/docker/compose/releases/download/v2.10.2/docker-compose-linux-aarch64" -o /usr/local/bin/docker-compose
    # sudo chmod +x /usr/local/bin/docker-compose
    # mkdir -p $HOME/.docker/cli-plugins/
    # ln -s /usr/local/bin/docker-compose $HOME/.docker/cli-plugins/docker-compose
    docker compose version
    # sudo apt-get -f install && sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y && sudo apt-get autoremove -y
    sudo nano /etc/hostname
    # add security
    sudo apt install ufw -y
    sudo ufw allow ssh
    sudo ufw enable
    sudo ufw status
    sudo apt-get install -y fail2ban
    # other useful programs
    sudo apt-get install -y mc sysstat
    sudo systemctl enable sysstat
    sudo sed -i 's/false/true/g' /etc/default/sysstat
    sudo sed -i 's/HISTORY=7/HISTORY=3/g' /etc/sysstat/sysstat
    sudo sed -i 's/COMPRESSAFTER=10/COMPRESSAFTER=1/g' /etc/sysstat/sysstat
    curl -L https://github.com/hufhend/ubuntu-postinstall/raw/main/fonts.tar.gz -o fonts.tar.gz
    sudo tar xvfz fonts.tar.gz -C /usr/local/share
    # when we have Docker, more memory comes in handy
    echo "I'm creating a 3.5G swap, just a minute..."
    sudo touch /swapfile
    sudo fallocate -l 3.5G /swapfile
    sudo chmod 600 /swapfile
    sudo mkswap /swapfile
    sudo swapon /swapfile
    echo "/swapfile swap swap defaults 0 0" | sudo tee -a /etc/fstab
    sudo swapon --show
  exit
fi
    #here go superuser commands
    echo This script cannot run root
