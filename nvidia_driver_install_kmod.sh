#!/bin/sh

echo 'This script install Nvidia drivers for all distributions based in Debian'

#Add repository stretch-backports
echo 'deb http://httpredir.debian.org/debian stretch-backports main contrib non-free' | sudo tee -a /etc/apt/sources.list.d/nvidia.list
#Update repositories for applicate modifications in /etc/apt/sources.list.d/
sudo apt-get update
#Linux headers install
sudo apt-get install linux-headers-$(uname -r|sed 's/[^-]*-[^-]*-//') -y
#Linux headers install with stretch backports
sudo apt-get install -t stretch-backports linux-headers-$(uname -r|sed 's/[^-]*-[^-]*-//') -y
#Update repositories
sudo apt-get update
#Install nvidia driver with stretch-backports
sudo apt-get install -t stretch-backports nvidia-driver -y
#Add repository non-free for Debian Stretch
echo 'deb http://httpredir.debian.org/debian/ stretch main contrib non-free' | sudo tee -a /etc/apt/sources.list.d/nvidia.list
#Update repositories
sudo apt-get update
#Install linux-headers for non-free packets
sudo apt-get install linux-headers-$(uname -r|sed 's/[^-]*-[^-]*-//') nvidia-driver -y
#Install libraries OpenGL and nvidia-driver
sudo apt-get install libgl1-nvidia-glx -y
#Reboot after install for applicate modifications
sudo reboot
