#!/bin/bash

##### Script to install useful applications for Fedora 26/27
##### It must be run as root or sudo
##### Add, comment or uncomment lines whether the need to install, or not, the application shown

clear

### Variables
user=$1
down_path="/home/""$user""/Downloads"
install="install -y"

if [[ ! -d "$down_path" ]]; then
	mkdir "$down_path"
	chown "$user":"$user" "$down_path"
fi

#dnf clean all

echo "##### Installing Apps..."
###	Management tools
	dnf $install system-config-bind
	dnf $install system-config-firewall*
	dnf $install system-config-httpd
	dnf $install system-config-kdump
	dnf $install system-config-keyboard*
	dnf $install system-config-language
	dnf $install system-config-printer*
	dnf $install system-config-repo
	dnf $install system-config-rootpassword
	dnf $install system-config-users*
	dnf $install util-linux-user
	dnf $install firewall-config
	dnf $install dconf dconf-editor
	dnf $install net-tools ethtool NetworkManager-tui
	systemctl enable firewalld.service
	systemctl status firewalld
	dnf $install wine

###	File system management tools
	dnf $install gnome-disk-utility
	dnf $install gparted
	dnf $install smartmontools
	dnf $install foremost
	dnf $install fuse fuse-exfat exfat-utils fuse-ntfs-3g
	dnf $install ifuse hfsutils hfsplus-tools
	dnf $install zfs-fuse fuse-sshfs fuse-encfs

###	Tools for sharing different type of filesystems
	dnf $install samba samba-client samba-common samba-winbind samba-winbind-clients

###	Running samba service
	systemctl enable smb.service
	systemctl start smb.service
	systemctl status smb.service
	echo

###	Archiving Tools
	dnf $install unzip p7zip*
	dnf $install unrar
	dnf $install arj lzma lzop bzip2 lrzip xz

	### To install rar
	wget -O "$down_path"/cert-forensics-tools-release-$(rpm -E %fedora).rpm https://forensics.cert.org/cert-forensics-tools-release-$(rpm -E %fedora).rpm

	rpm -Uvh "$down_path"/cert-forensics-tools-release-$(rpm -E %fedora)*rpm

	dnf --enablerepo=forensics $install rar

###	Acrobat reader
	wget -O "$down_path"/AdbeRdr9.5.5-1_i486linux_enu.rpm http://ardownload.adobe.com/pub/adobe/reader/unix/9.x/9.5.5/enu/AdbeRdr9.5.5-1_i486linux_enu.rpm

	dnf $install "$down_path"/AdbeRdr9.5.5-1_i486linux_enu.rpm

###	Basic tools needed by the system
	dnf $install lshw lshw-gui
	dnf $install screenfetch
	dnf $install gucharmap
	dnf $install gedit
	dnf $install geany
	dnf $install brasero
	dnf $install okular
	dnf $install shutter
	dnf $install alien
	dnf $install gnome-calendar
	dnf $install catfish
	dnf $install nautilus nautilus-extensions
	dnf $install gwenview
	dnf $install guake
	dnf $install kate
	dnf $install lshw*
	dnf $install youtube-dl
	dnf $install dconf-editor dconf
	dnf $install filezilla
	dnf $install tigervnc
	dnf $install rednotebook
	dnf $install ktorrent
	dnf $install k3b*

###	Font package and Microsoft package
	dnf $install cabextract
##	dnf $install https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm
	wget -O "$down_path"/msttcore-fonts-installer-2.6-1.noarch.rpm https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm
	dnf $install "$down_path"/msttcore-fonts-installer-2.6-1.noarch.rpm
	dnf $install @fonts
	dnf $install freetype
	dnf $install font-manager
	dnf $install xorg-x11-font-utils fontconfig

###	Image editors and converters
	dnf $install pinta
	dnf $install krita
	dnf $install gimp
	dnf $install shotwell
	dnf $install darktable
	dnf $install converseen
	dnf $install digikam
	dnf $install rawtherapee
	dnf $install fspot			## search

###	Audio players and converters
	dnf $install audacity-nonfree
	dnf $install spotify-client
	dnf $install clementine
	dnf $install soundconverter
	dnf $install ffmulticonverter
	dnf $install xmms
	dnf $install amarok*

###	Video players and editors
	dnf $install vlc
	dnf $install openshot
	dnf $install flowblade
	dnf $install simplescreenrecorder
	dnf $install vokoscreen
	dnf $install cheese
	dnf $install mplayer
	dnf $install avidemux
	dnf $install pitivi
	dnf $install blender
#	dnf $install lightworks		## search

###	Internet
	dnf $install firefox
##	dnf $install https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
	wget -O "$down_path"/google-chrome-stable_current_x86_64.rpm https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
	dnf $install "$down_path"/google-chrome-stable_current_x86_64.rpm
##	dnf $install opera-stable
##	dnf $install chromium
##	dnf $install vivaldi-stable
##	dnf $install torbrowser-launcher
##	dnf $install thunderbird
##	dnf $install qbittorrent
	dnf $install filezilla
	dnf $install ktorrent
	dnf $install transmission
	dnf $install icedtea-web
	dnf $install https://repo.skype.com/latest/skypeforlinux-64.rpm
##	dnf $install http://linuxdownload.adobe.com/linux/x86_64/adobe-release-x86_64-1.0-1.noarch.rpm
	wget -O "$down_path"/adobe-release-x86_64-1.0-1.noarch.rpm http://linuxdownload.adobe.com/linux/x86_64/adobe-release-x86_64-1.0-1.noarch.rpm
	dnf $install "$down_path"/adobe-release-x86_64-1.0-1.noarch.rpm
	rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux
	dnf $install flash-plugin
	dnf $install flash-player-ppapi
	dnf $install freshplayerplugin

###	Office
	dnf $install scribus
	dnf $install keepass
	dnf $install kpcli
	dnf $install simple-scan
	dnf $install cups
	systemctl enable cups.service
	systemctl status cups.service
	echo

###	Development tools
	dnf $install unetbootin
	dnf $install mediawriter
	dnf $install dia
	dnf $install diffuse

###	Remote access
	dnf $install putty
	dnf $install openssh-server openssh-clients
	dnf $install clusterssh
	systemctl enable sshd.service
	systemctl start sshd.service
	systemctl status sshd.service
	echo

###	Security tools
	dnf $install nmap
	dnf $install nmap-frontend.noarch
	dnf $install wireshark
	dnf $install traceroute
	dnf $install httrack
	dnf $install tcpdump

###	Performance and monitoring tools
	dnf $install bleachbit		## Junk cleaner
	dnf $install preload			## Daemon that gathers info from the processes running on the system
	dnf $install irqbalance		## Daemon that evenly distributes IRQ loads across multiple cpu's
	dnf $install tuned			## Tunes dynamically the system
	dnf $install glances			## Gets info from the system
	dnf $install htop
	dnf $install itop
	dnf $install iotop
	dnf $install iftop
	dnf $install hdparm
	dnf $install sysstat
	dnf $install gnome-system-monitor
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
	dnf $install gstreamer1
	dnf $install gstreamer-plugins-base
	dnf $install gstreamer1-plugins-base
	dnf $install gstreamer1-plugins-base-tools
	dnf $install gstreamer-plugins-good-extras
	dnf $install gstreamer1-plugins-good-extras
	dnf $install gstreamer-plugins-ugly
	dnf $install gstreamer1-plugins-ugly
	dnf $install gstreamer1-plugins-base
	dnf $install gstreamer1-plugins-good
	dnf $install gstreamer-plugins-bad
	dnf $install gstreamer-plugins-bad-nonfree
	dnf $install gstreamer1-plugins-bad-free
	dnf $install gstreamer1-plugins-bad-freeworld
	dnf $install gstreamer1-plugins-bad-free-extras
	dnf $install gstreamer-plugins-bad-free-extras
	dnf $install gstreamer1-libav
	dnf $install gstreamer-ffmpeg
	dnf $install ffmpeg
	dnf $install mencoder
	dnf $install mplayer
	dnf $install libdvdread
	dnf $install libdvdnav
	dnf $install lsdvd
	dnf $install xine-lib-extras
	dnf $install xine-lib-extras-freeworld
	dnf $install k3b-extras-freeworld

###	Cleaning
	dnf clean all
	echo

###	Verifying repos installed and hardware characteristics
	dnf repolist
	echo
	echo
	screenfetch

### Finishes script
	echo
	echo
echo "##### Done #####"
echo
echo "********** Installation is done, please reboot the system. **********"
echo
exit
