#   ******************************************
#   OrangePi install - Debian 10 arm64, part 1
#   begin     : Fri 25 Sep 2020.
#   copyright : (c) 2021 Václav Dvorský
#   email     : vaclav.dvorsky@hotmail.com
#   $Id: debian_install.sh, v3.02 28/09/2021
#   ******************************************
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
    sudo apt-get -f install && sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y && sudo apt-get autoremove -y
    curl -fsSL https://get.docker.com -o get-docker.sh
    sudo sh get-docker.sh
    sudo systemctl status docker
    sudo usermod -aG docker ${USER}
    docker version
    echo Switch to another user, continue with script debian_install_2.sh
    su - ${USER}
  exit
fi
    #here go superuser commands
    echo This script cannot run root
