#   *********************************************
#   OrangePi install - Ubuntu Jammy arm64, part 1
#   begin     : Fri 25 Sep 2020.
#   copyright : (c) 2021 Václav Dvorský
#   email     : vaclav.dvorsky@hotmail.com
#   $Id: debian_install.sh, v3.10 15/09/2022
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
    # complete update
    sudo apt -f install -y && sudo apt update && sudo apt upgrade -y && sudo apt dist-upgrade -y && sudo apt autoremove -y
    sudo apt install -y ca-certificates curl gnupg lsb-release
    sudo mkdir -p /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
      $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo apt-get install docker-ce docker-ce-cli containerd.io docker-compose-plugin
    # curl -fsSL https://get.docker.com -o get-docker.sh
    # sudo sh get-docker.sh
    sudo systemctl status docker
    sudo usermod -aG docker ${USER}
    docker version
    echo Switch to another user, continue with script debian_install_2.sh
    su - ${USER}
  exit
fi
    #here go superuser commands
    echo This script cannot run root
