#!/bin/bash

#Check root execution verification
if [[ "$EUID" -ne 0 ]]; then
	echo -e "Run this script as root"
	exit 1
fi

echo 'This script install Nvidia drivers for all distributions based in Debian'

#Add repository stretch-backports
echo 'deb http://httpredir.debian.org/debian stretch-backports main contrib non-free' | tee -a /etc/apt/sources.list.d/nvidia.list
#Update repositories for applicate modifications in /etc/apt/sources.list.d/
apt-get update
#Linux headers install
apt-get install linux-headers-$(uname -r|sed 's/[^-]*-[^-]*-//') -y
#Linux headers install with stretch backports
apt-get install -t stretch-backports linux-headers-$(uname -r|sed 's/[^-]*-[^-]*-//') -y
#Update repositories
apt-get update
#Install nvidia driver with stretch-backports
apt-get install -t stretch-backports nvidia-driver -y
#Add repository non-free for Debian Stretch
echo 'deb http://httpredir.debian.org/debian/ stretch main contrib non-free' | tee -a /etc/apt/sources.list.d/nvidia.list
#Update repositories
apt-get update
#Install linux-headers for non-free packets
apt-get install linux-headers-$(uname -r|sed 's/[^-]*-[^-]*-//') nvidia-driver -y
#Install libraries OpenGL and nvidia-driver
apt-get install libgl1-nvidia-glx -y
#Reboot after install for applicate modifications
reboot
