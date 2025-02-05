#!/bin/bash

if [ "$EUID" -ne 0 ]; then
	echo "This script must be run as root"
	exit 1
fi

cp ./ /home/$USER/Customization
cd /home/$USER/Customization

cp ./home /home/$USER

packages=$(cat pacman.txt)
pacman -Syu $packages
packages=$(cat yay.txt)
yay -Syu $packages

unset packages

. /home/$USER/.bashrc
