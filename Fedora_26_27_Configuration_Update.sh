#!/bin/bash

##### Fedora_26_27_Configuration_Update

##### Script to install the basic configuration for Fedora 26/27
##### It must be run as root or sudo privileges
##### It must be executed only once, after the manual basic configuration after the fresh installation

##### Variables
install="install -y"
update="update -y"
input=""
vm=0

##### Begin
clear

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   echo "Exiting the Configuration..."
   exit 1
fi

echo -n "Is this script running on a virtual machine [y/n/q]? "
read input
case $input in
    [yY] )  vm=1;;
    [qQ] )  echo "You decided to quit, exiting the installation..."
            echo
            exit 1;;
    * )     vm=0;;
esac

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
	### Installs only if the script is running on Virtual Guests.
if [[ $vm == 1 ]]; then
    dnf $install elfutils-libelf-devel*
    dnf $install elfutils*
fi
echo "##### Done #####"
echo

echo "##### Activating ssh daemon..."
###	Activate ssh
	systemctl enable sshd
	systemctl start sshd
	systemctl status sshd
    echo
echo "##### Done #####"
echo

echo "##### Updating the system..."
###	System update
	dnf $update
echo "##### Done #####"
echo

echo "##### Updating Kernels for virtual machines..."
###	Installs only if the script is running on Virtual Guests.
if [[ $vm == 1 ]]; then
    dnf $install kernel*
fi
echo "##### Done #####"

echo
echo "********** Configuration and Update are done, please reboot the system **********"
echo
exit
