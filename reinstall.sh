#!/bin/bash

# setup /etc/network/interfaces
if grep -q "inet static" /etc/network/interfaces; then
	echo "Network already set"
else
	for iface in $(ifconfig | cut -d ' ' -f1| tr ':' '\n' | awk NF)
	do
		printf "$iface\n"
		if [ $iface == "enp0s31f6" ]; then
			# if the target interface, setup network
			echo "auto $iface" >> /etc/network/interfaces
			echo "iface $iface inet static" >> /etc/network/interfaces
			echo "  address 137.110.160.225" >> /etc/network/interfaces
			echo "  netmask 255.255.255.0" >> /etc/network/interfaces
			echo "  gateway 137.110.160.1" >> /etc/network/interfaces
			echo "  dns-nameservers 132.239.0.252" >> /etc/network/interfaces
		elif [ $iface == 'lo' ]; then
			# do nothign if loopback
			echo "skipping loopback"
		else
			# otherwise, turn it off
			echo "iface $iface inet manual" >> /etc/network/interfaces
		fi
	done
fi
sudo ifdown --all
sudo ifup --all

# Ping until network is up
while : ; do
	ping -q -c 1 www.google.com
	if [ $? == 0 ]; then
		echo "Network is up"
		break
	fi
	sleep 3
done

# setup file system mounting
if grep -q /dev/sda1 /etc/fstab;  then 
	echo "/dev/sda1 already in /etc/fstab"
else
	mkdir -p /mnt/Data && echo "/dev/sda1 /mnt/Data ext4 defaults 0 0" >> /etc/fstab
	echo "Added sda1 mounting to /etc/fstab"
fi
if grep -q /dev/sda2 /etc/fstab;  then 
	echo "/dev/sda1 already in /etc/fstab"
else
	mkdir -p /mnt/Backup && echo "/dev/sda2 /mnt/Backup ext4 defaults 0 0" >> /etc/fstab
	echo "Added sda1 mounting to /etc/fstab"
fi

# apt update
sudo apt update
sudo apt upgrade 

# install basic
LIST="vim git tmux xsel htop flex bison openssl curl openssh openssh-server python3-pip virtualenv sysstat iotop linux-tools-common linux-tools-`uname -r` python3-tk libssl-dev autoconf libtool sysstat iotop libelf-dev"

for l in $LIST; do
	echo $l
	sudo apt --assume-yes install $l
done

# install customizable Setting git
cd ~/Downloads
git clone https://github.com/yunjoon-soh/Settings

# Run the install script
cd ~/Downloads/Settings/Ubuntu1604/
bash install.sh

# Set the vimrc
cd ~/Downloads/Settings/Vim
cp vimrc ~/.vimrc


