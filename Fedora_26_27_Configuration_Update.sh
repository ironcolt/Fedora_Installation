#!/bin/bash

##### Fedora_26_27_Configuration_Update

##### Script to install the basic configuration for Fedora 26/27
##### It must be run as root or sudo privileges
##### It must be executed only once, after the manual basic configuration after the fresh installation

##### Variables
install="install -y"
update="update -y"

##### Begin
clear

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   echo "Exiting the Configuration..."
   exit 1
fi

echo
echo "##### Cleaning files in dnf cache..."
	dnf clean all
echo "##### Done #####"
echo

echo "##### Modifying dnf.config file..."
###	Modify dnf config file
	echo "fastestmirror=true" >> /etc/dnf/dnf.conf
	echo "deltarpm=false" >> /etc/dnf/dnf.conf
echo "##### Done #####"
echo

echo "##### Installing repos..."
###	Package managers and repos
	dnf $install wget
	dnf $install curl
	dnf $install dnf-plugins-core
	dnf $install yumex-dnf
	rpm -ivh http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
	rpm -ivh https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
	dnf config-manager --add-repo=http://negativo17.org/repos/fedora-spotify.repo
echo "##### Done #####"
echo

echo "##### Installing utilities..."
###	Utilities for installation
	dnf $install gnome-tweak-tool
	dnf $install https://dl.folkswithhats.org/fedora/$(rpm -E %fedora)/RPMS/folkswithhats-release.noarch.rpm
	dnf $install fedy
	dnf $install chrome-gnome-shell

###	Install compilers and utilities
	dnf $install make gcc

###	Install libelf utilities
	### Uncomment following lines if the script is running on Virtual Guests.
	#dnf $install elfutils-libelf-devel*
	#dnf $install elfutils*
echo "##### Done #####"
echo

echo "##### Activating ssh daemon..."
###	Activate ssh
	systemctl enable sshd
	systemctl start sshd
	systemctl status sshd
echo "##### Done #####"
echo

echo "##### Updating the system..."
###	System update
	dnf $update
echo "##### Done #####"
echo

echo "##### Updating Kernels for virtual machines..."
###	Install all left kernels
	### Uncomment following line if the script is running on Virtual Guests.
	#dnf $install kernel*
echo "##### Done #####"
echo
echo "********** Update is done, please reboot the system. **********"
echo
exit
