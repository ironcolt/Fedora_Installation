#!/usr/bin/#!/usr/bin/env bash

# Installs Apps already downloaded and saved locally

##### Variables
local_rpm="/home/potro/Downloads/For_Fedora31/rpm"
local_gz="/home/potro/Downloads/For_Fedora31/gz"
local_zip="/home/potro/Downloads/For_Fedora31/zip"
temp_dir="/home/potro/Downloads/For_Fedora31/temp_dir"
opt_dir="/opt"

install="install -y"
is_error=0
user="potro"


##### Functions
function Exit() {
  echo
  echo Exiting the program ...
  echo
  exit
}

function Install_rpm() {
  if [[ ! -d "$local_rpm" ]]; then
    echo "Local path does not exit, please check"; echo; echo
    Exit
  fi
  app_name=$(ls $local_rpm | grep -i ^"$1")
  echo "############### Installing ""$app_name"" ###############"
	echo
	sudo dnf $install "$local_rpm"/$app_name; error=$( echo $? )
	if [[ $error -ne 0 ]]; then
    echo
    echo "ERROR found when installing ""\"$app_name\""
    echo; echo; is_error=1
  fi
  echo
}

function Install_gz() {
  if [[ ! -d "$local_gz" ]]; then
    echo "Local path does not exit, please check"; echo; echo
    Exit
  fi
  app_name=$(ls $local_gz | grep -i ^"$1")
  echo "############### Installing ""$app_name"" ###############"; echo
}



##### Begin
clear

if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root or with sudo privileges" 1>&2
  echo "Exiting the Configuration..."
  echo
  exit 1
fi

echo "Recovering repo information..."; echo

echo "Installing some required packages"
sudo dnf $install kernel-devel-$(uname -r); echo; echo

##### Installation of the Apps

echo "##### Installing Apps..."; echo
Install_rpm VirtualBox
if [[ $is_error == 0 ]]; then
  sudo /sbin/vboxconfig
  echo; echo "Adding '$user' to group 'vboxusers'"
  sudo usermod -aG vboxusers $user
  echo; id $user; echo; echo
fi

Install_rpm TeamViewer
Install_rpm AnyDesk
Install_rpm Google-Chrome
Install_rpm LightWorks

Install_gz PyCharm
app_name_short=$(echo $app_name | cut -d"." -f1-3)
tar xzvf "$local_gz"/"$app_name" -C "$opt_dir"/
cur_dir=$(pwd); cd "$opt_dir"/"$app_name_short"/bin
./pycharm.sh
sudo ln -s /opt/pycharm-community-2020.1.2/bin/pycharm.sh /usr/bin/pycharm
echo "PyCharm was succesfully installed and can be executed by typing \"pycharm\""; echo
echo "*************************************************************************"
echo "Do not forget to add an instance on \"Applications\" --> \"Programming\""
echo "Run \"alacarte\", select \"Programming\" --> \"New Item\""
echo "Write the name \"PyCharm\", write the command \"/opt/pycharm-community-2020.1.2/bin/pycharm.sh\" or browse it"
echo "Browse the icon from \"/opt/pycharm-community-2020.1.2/bin/pycharm.png\""
echo "Click \"OK\", and close \"alacarte\""
echo "Ready to go"
echo "*************************************************************************"
echo; cd "$cur_dir"; echo

Install_gz LibreOffice
tar xzvf "$local_gz"/"$app_name" -C "$temp_dir"/
app_name_short=$(ls "$temp_dir"/ | grep -i "LibreOffice_")
cur_dir=$(pwd); cd "$temp_dir"/"$app_name_short"/
./install -U RPMS/ ~/bin/; error=$( echo $? )
sudo ln -s ~/bin/opt/libreoffice6.4/program/soffice /usr/bin/libreoffice6.4
if [[ $error == 0 ]]; then
  echo; echo "Libre Office was succesfully installed under \"/usr/bin/libreoffice6.4\""
  echo
else
  echo "ERROR found when installing ""\"$app_name\""
  echo; echo; is_error=1
fi


cd $cur_dir; echo

### Checks if there were errors during installation
if [[ $is_error != 0 ]]; then
  echo; echo "Warning"; echo
  echo "Some Applications were not installed, please check the log"; echo
  Exit
fi


Exit
