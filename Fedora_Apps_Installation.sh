#!/bin/bash

##### Fedora_Apps_Installation

# Script to install useful applications for Fedora
# It must be run as root or with sudo privileges
# Add, comment or uncomment Applications depending on the need to use them

# Syntax: bash Fedora_26_27_Apps_Installation.sh


##### Variables
down_path=""
install="install -y"
input=""
repo_path=""
user=""


##### Functions
function Install() {
	app_name="$1"; echo "Installing ""$app_name"
	echo
	sudo install "$1"; error=$( echo $? )
	if [[ $error -ne 0 ]]; then echo; echo "ERROR found when installing ""\"$app_name\""; echo; echo; fi
  echo
	echo
}



##### Begin
clear

if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root or with sudo privileges" 1>&2
    echo "Exiting the Configuration..."
    echo
    exit 1
fi

echo "USER = "$USER
user=$(whoami | awk '{print $1}')
echo "user = "$user
down_path="/home/""$user""/Downloads"
echo "Down_Path = "$down

if [[ ! -d "$down_path" ]]; then
	mkdir -p "$down_path"
	chown "$user":"$user" "$down_path"
fi

### Installing additional repos
#if [[ ! -f /etc/yum.repos.d/atom.repo ]]; then
#    repo_path="/etc/yum.repos.d/atom.repo"
#    touch "$repo_path"
#    echo "[helber-atom]" >> "$repo_path"
#    echo "name=Copr repo for atom owned by helber" >> "$repo_path"
#    echo "baseurl=https://copr-be.cloud.fedoraproject.org/results/helber/atom/fedora-$(rpm -E %fedora)"-"$(uname -i)/" >> "$repo_path"
#    echo "type=rpm-md" >> "$repo_path"
#    echo "skip_if_unavailable=True" >> "$repo_path"
#    echo "gpgcheck=0" >> "$repo_path"
#    echo "gpgkey=https://copr-be.cloud.fedoraproject.org/results/helber/atom/pubkey.gpg" >> "$repo_path"
#    echo "repo_gpgcheck=0" >> "$repo_path"
#    echo "enabled=1" >> "$repo_path"
#    echo "enabled_metadata=1" >> "$repo_path"
#    repo_path=""
#fi

echo "##### Installing Apps..."
###	Management tools
Install system-config-bind
exit
Install system-config-firewall*
Install system-config-httpd
Install system-config-kdump
Install system-config-keyboard*
Install system-config-language
Install system-config-printer*
Install system-config-repo
Install system-config-rootpassword
Install system-config-users*
Install util-linux-user
Install firewall-config
Install "dconf dconf-editor"
Install "net-tools ethtool NetworkManager-tui"
Install wine
systemctl enable firewalld.service

###	File system management tools
Install gnome-disk-utility
Install gparted
Install smartmontools
Install foremost
Install "fuse fuse-exfat exfat-utils fuse-ntfs-3g"
Install "ifuse hfsutils hfsplus-tools"
Install "zfs-fuse fuse-sshfs fuse-encfs"
Install cmake

###	Tools for sharing different type of filesystems
Install "samba samba-client samba-common samba-winbind samba-winbind-clients"

###	Running samba service
systemctl enable smb.service
systemctl start smb.service

###	Archiving Tools
Install "unzip p7zip*"
Install unrar
Install "arj lzma lzop bzip2 lrzip xz"

### To install rar
#wget -O "$down_path"/cert-forensics-tools-release-$(rpm -E %fedora).rpm https://forensics.cert.org/cert-forensics-tools-release-$(rpm -E %fedora).rpm

#chown "$user":"$user" "$down_path"/cert-forensics-tools-release-$(rpm -E %fedora).rpm
#rpm -Uvh "$down_path"/cert-forensics-tools-release-$(rpm -E %fedora)*rpm

#dnf --enablerepo=forensics $install rar

###	Acrobat reader
#wget -O "$down_path"/AdbeRdr9.5.5-1_i486linux_enu.rpm http://ardownload.adobe.com/pub/adobe/reader/unix/9.x/9.5.5/enu/AdbeRdr9.5.5-1_i486linux_enu.rpm

#chown "$user":"$user" "$down_path"/AdbeRdr9.5.5-1_i486linux_enu.rpm
#Install "$down_path"/AdbeRdr9.5.5-1_i486linux_enu.rpm

###	Utility tools needed by the system
Install "lshw lshw-gui"
Install screenfetch
Install gucharmap
Install gedit
Install geany
Install brasero*
Install okular
Install shutter
Install alien
Install gnome-calendar
Install catfish
Install "nautilus nautilus-extensions"
Install gwenview
Install guake
Install kate
Install lshw*
Install youtube-dl
Install filezilla
Install tigervnc
Install tigervnc-server
Install rednotebook
Install ktorrent
Install k3b*
Install colordiff
Install diffutils
Install alacarte
Install calibre
Install celestia
Install colord
Install colord-extra-profiles
Install easytag*
Install freecad*
Install vim-enhanced
Install cdw

###	Font package and Microsoft package
Install cabextract

##	Install https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm

#wget -O "$down_path"/msttcore-fonts-installer-2.6-1.noarch.rpm https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm

#chown "$user":"$user"  "$down_path"/msttcore-fonts-installer-2.6-1.noarch.rpm
#Install "$down_path"/msttcore-fonts-installer-2.6-1.noarch.rpm

Install @fonts
Install freetype
Install font-manager
Install "xorg-x11-font-utils fontconfig"
Install fontconfig-devel*
Install abattis-cantarell-fonts
Install mozilla-fira*

###	Image editors and converters
Install pinta
Install krita
Install gimp
Install shotwell
Install darktable
Install converseen
Install digikam
Install rawtherapee

###	Media players and converters
Install "audacity audacity-manual"
Install "audacious audacious-devel audacious-libs audacious-plugins"
Install spotify-client
Install clementine
Install soundconverter
Install ffmulticonverter
Install xmms
Install amarok*
Install vlc
Install openshot
Install flowblade
Install simplescreenrecorder
Install vokoscreen
Install cheese
Install mplayer
Install avidemux
Install pitivi
Install blender
Install dragon
Install dvd95
Install DVDAuthorWizard
Install dvdauthor
Install dvdbackup
Install dvdisaster
Install dvdrip
Install DVDRipOMatic

###	Internet
Install firefox

##	Install https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm

#wget -O "$down_path"/google-chrome-stable_current_x86_64.rpm https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm

#chown "$user":"$user"  "$down_path"/google-chrome-stable_current_x86_64.rpm
#Install "$down_path"/google-chrome-stable_current_x86_64.rpm

##	Install opera-stable
##	Install chromium
##	Install vivaldi-stable
##	Install torbrowser-launcher
##	Install thunderbird
##	Install qbittorrent
Install filezilla
Install ktorrent
Install transmission
Install icedtea-web
#Install https://repo.skype.com/latest/skypeforlinux-64.rpm

##	Install http://linuxdownload.adobe.com/linux/x86_64/adobe-release-x86_64-1.0-1.noarch.rpm

#wget -O "$down_path"/adobe-release-x86_64-1.0-1.noarch.rpm http://linuxdownload.adobe.com/linux/x86_64/adobe-release-x86_64-1.0-1.noarch.rpm

#chown "$user":"$user"  "$down_path"/adobe-release-x86_64-1.0-1.noarch.rpm
#Install "$down_path"/adobe-release-x86_64-1.0-1.noarch.rpm
#rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux

Install flash-plugin
Install flash-player-ppapi
Install freshplayerplugin

#wget -O "$down_path"/teamviewer.x86_64.rpm  https://download.teamviewer.com/download/linux/teamviewer.x86_64.rpm

#chown "$user":"$user"  "$down_path"/teamviewer.x86_64.rpm
#Install "$down_path"/teamviewer.x86_64.rpm

###	Office
Install scribus
Install keepass
Install kpcli
Install simple-scan
Install cups
systemctl enable cups.service

###	Development tools
Install unetbootin
Install mediawriter
Install liveusb-creator
Install dia
Install diffuse
Install atom

###	Remote access
Install putty
Install openssh-server openssh-clients
Install clusterssh

###	Security tools
Install nmap
Install nmap-frontend
Install wireshark
Install traceroute
Install httrack
Install tcpdump

###	Performance and monitoring tools
Install bleachbit	    ## Junk cleaner
Install preload		## Daemon that gathers info from the processes running on the system
Install irqbalance     ## Daemon that evenly distributes IRQ loads across multiple cpu's
Install tuned			## Tunes dynamically the system
Install glances		## Gets info from the system
Install htop
Install itop
Install iotop
Install iftop
Install hdparm
Install sysstat
Install gnome-system-monitor
Install dstat
##	systemctl enable preload.service
##	systemctl enable irqbalance.service
#	systemctl disable fstrim.timer
#	systemctl disable livesys
#	systemctl disable livesys-late
#	systemctl disable avahi-daemon
#	systemctl disable atd
##	systemctl disable bluetooth
#	systemctl disable ModemManager
#	systemctl disable crond chronyd iscsi multipathd

###	Multimedia Codecs
Install gstreamer1
Install gstreamer-plugins-base
Install gstreamer1-plugins-base
Install gstreamer1-plugins-base-tools
Install gstreamer-plugins-good-extras
Install gstreamer1-plugins-good-extras
Install gstreamer-plugins-ugly
Install gstreamer1-plugins-ugly
Install gstreamer1-plugins-base
Install gstreamer1-plugins-good
Install gstreamer-plugins-bad
Install gstreamer-plugins-bad-nonfree
Install gstreamer1-plugins-bad-free
Install gstreamer1-plugins-bad-freeworld
Install gstreamer1-plugins-bad-free-extras
Install gstreamer-plugins-bad-free-extras
Install gstreamer1-libav
Install gstreamer-ffmpeg
Install ffmpeg
Install mencoder
Install mplayer
Install libdvdread
Install libdvdnav
Install lsdvd
Install xine-lib-extras
Install xine-lib-extras-freeworld
Install k3b-extras-freeworld

###	Stuff
###	Add the lines for the Apps you want to install here using the Syntax
###	"Install app_name"
echo
echo
echo "##### Done #####"
echo
echo
echo

###	Cleaning
dnf clean all
echo "##### Done cleaning dnf cache #####"
echo

###	Verifying repos installed and hardware characteristics
dnf repolist
echo "##### Done repolist #####"
echo
echo
echo "Complete system summary"
echo
echo
sudo -u $USER "screenfetch"
echo

### Displaying the status of the services activated
echo
echo -n "Do you want to check services status [y/n]? "
read input
case $input in
	[yY] )	echo
			echo "Displaying services status..."
			echo "Press \"q\" to continue..."
			echo
			sudo -u $USER systemctl status firewalld
			echo
			sudo -u $USER systemctl status smb
			echo
			sudo -u $USER systemctl status cups
			echo;;
	* )		echo;;
esac

### Finishes script
echo
echo
echo
echo "##### Done The Installation of Apps #####"
echo
echo
echo
echo "*************************************************************"
echo "Run this script again every time you need to install new Apps"
echo "Just add the lines to install the Apps in the correct section"
echo "Or use the section \"Stuff\" created for that purpose."
echo "*************************************************************"
echo
echo
echo "********** Installation is done, please reboot the system. **********"
echo
echo
exit
