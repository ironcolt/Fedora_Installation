#!/bin/bash

##### Fedora_Configuration_Update

##### Script to install the basic configuration for Fedora
##### It must be run as root or with sudo privileges
##### It must be executed when a manual basic configuration after a fresh installation has been done


##### Variables
install="install -y"
update="update -y"
input=""
vm=0


##### Functions
function Install() {
	app_name="$1"; echo "Installing ""$app_name"
	echo
	sudo dnf $install "$1"; error=$( echo $? )
	if [[ $error -ne 0 ]]; then echo; echo "ERROR found when installing ""\"$app_name\""; echo; echo; fi
  echo
	echo
}



##### Begin
clear

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 1>&2
   echo "Exiting the Configuration..."
   echo
   exit 1
fi

echo -n "Is this script running on a virtual machine [y/n/q]? "
read input
case $input in
    [yY] )	vm=1;;
    [qQ] )	echo "You decided to quit."
    		echo "Exiting the Configuration..."
    		echo
    		exit 1;;
    * )		vm=0;;
esac


echo
echo "##### Cleaning files in dnf cache..."
dnf clean all
echo "##### Done #####"
echo


echo "##### Modifying dnf.config file..."
echo "fastestmirror=true" >> /etc/dnf/dnf.conf
echo "deltarpm=false" >> /etc/dnf/dnf.conf
echo "##### Done #####"
echo


echo "##### Installing repos and basic utilities..."
### RPMFusion repos
rpm -ivh http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm
rpm -ivh https://download1.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

### Repo to install Spotify app
dnf config-manager --add-repo=http://negativo17.org/repos/fedora-spotify.repo

echo "##### Done #####"
echo


echo "##### Installing basic utilities..."
Install wget
Install curl
Install dnf-plugins-core
Install yumex-dnf
Install gnome-tweak-tool
Install https://dl.folkswithhats.org/fedora/$(rpm -E %fedora)/RPMS/fedy-release.rpm
Install fedy
Install chrome-gnome-shell


###	Install compilers
Install make gcc kmod
Install kmod-devel*


###	Install libelf utilities
### Installs only if the script is running on Virtual Guests.
if [[ $vm == 1 ]]; then
    Install elfutils-libelf-devel*
    Install elfutils*
fi

echo "##### Done #####"
echo


echo "##### Activating ssh daemon..."
systemctl enable sshd
systemctl start sshd
echo "##### Done #####"
echo

echo "##### Updating the system..."
dnf $update
echo "##### Done #####"
echo


###	Installs only if the script is running on Virtual Guests.
echo "##### Updating Kernels for virtual machines..."
if [[ $vm == 1 ]]; then
    Install kernel*
    echo "##### Done #####"
fi


### Displaying the status of the services activated
echo
echo -n "Do you want to check services status [y/n]? "
read input
case $input in
    [yY] )	echo
            echo "Displaying services status..."
            echo
            systemctl status sshd.service
            echo;;
    * )     echo;;
esac
echo "##### Done #####"


echo
echo "********** Configuration and Update are done, please reboot the system **********"
echo
exit
