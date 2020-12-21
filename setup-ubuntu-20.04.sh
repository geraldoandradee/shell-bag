#/usr/bin/env bash

check_root() {
  if [ $(whoami) != "root" ]
  then
    echo ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
    echo "######### This script must be executed as root! #########"
    echo ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
    exit 1
  fi
}

install_goodies() {
  echo "Install some disk utilities"
  apt install exfat-fuse exfat-utils -y
  echo "Goodies is installed"
  apt install vlc -y
}

install_developer_things() {
  apt install vim terminator git-core gimp gcc g++ build-essential \
  gcc g++ build-essential curl software-properties-common \
  apt-transport-https wget htop -y

  echo "Installing VSCode"
  curl https://packages.microsoft.com/keys/microsoft.asc | sudo apt-key add -
  echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" | tee /etc/apt/sources.list.d/vscode.list
  apt install code -y
  echo "VSCode installed"

  echo "Installing NodeJs 15"
  curl -sL https://deb.nodesource.com/setup_15.x | sudo -E bash -
  apt install nodejs -y
  echo "Nodejs installed"

  echo "Lets install Docker"
  apt remove docker docker-engine docker.io -y
  apt install apt-transport-https ca-certificates curl software-properties-common -y
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add -
  apt-key fingerprint 0EBFCD88
  echo "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list
  apt install docker-ce docker-compose -y
  docker run hello-world

  usermod -aG docker $USER
  echo "Now you can use docker with no sudo. But you're need to reboot."
  echo "Docker installed SUCCESSFULLY"

}

setup_nvidia_graphic_card() {
  echo "Let me check if there's a supported graphics card..."
  ubuntu-drivers autoinstall
  echo "NVIDIA Drivers installed SUCCESSFULLY"
}


echo ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
echo "::::::::: Setup Script For $(lsb_release -d -s) :::::::::::"
echo ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
echo ""
echo ""
echo "This setup is meant for developers, so if you're not a "
echo "developer do not use it"
echo ""
echo ""

check_root

apt update
apt upgrade -y
apt autoremove

echo "Some configurations will be applied to $USER"

install_goodies
install_developer_things
setup_nvidia_graphic_card

echo ""
echo ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
echo ":::::::::: Setup for $(lsb_release -d -s) has DONE! :::::::"
echo ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
echo ""
