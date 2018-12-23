#/usr/bin/env bash

# Constants
RED='\033[0;31m'
NC='\033[0m' # No Color
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[0;93m'

info() {
 echo "${BLUE}$1${NC}" 
}

error() {
  echo "${RED}$1${NC}" 
}

warn() {
  echo "${YELLOW}$1${NC}" 
}

success() {
  echo "${GREEN}$1${NC}" 
}

check_root() {
  if [ $(whoami) != "root" ]
  then
    info ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
    error "######### This script must be executed as root! #########"
    info ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
    exit 1
  fi
}

install_goodies() {
  info "Lets install Google Chrome"
  wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | sudo apt-key add - 
  echo "deb http://dl.google.com/linux/chrome/deb/ stable main" > /etc/apt/sources.list.d/google.list
  apt update
  apt install google-chrome-stable -y

  info "Install some disk utilities"
  apt install exfat-fuse exfat-utils -y
  success "Goodies is installed"

  apt install vlc -y
}

install_developer_things() {
  apt install vim terminator git-core gimp gcc g++ build-essential \
  gcc g++ build-essential curl software-properties-common \
  apt-transport-https wget -y
  
  info "Installing VSCode"
  wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
  add-apt-repository -u -s "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
  apt install code -y
  success "VSCode installed"

  info "Installing JAVA 8"
  add-apt-repository -u -s -y ppa:webupd8team/java
  apt install oracle-java8-installer -y
  apt install oracle-java8-set-default -y
  success "Java 8 installed"

  info "Installing NodeJs 11"
  curl -sL https://deb.nodesource.com/setup_11.x | sudo -E bash -
  apt install nodejs -y
  success "Nodejs installed"

  info "Lets install Docker"
  apt remove docker docker-engine docker.io -y
  apt install apt-transport-https ca-certificates curl software-properties-common -y
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
  apt-key fingerprint 0EBFCD88
  add-apt-repository -y -u -s "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
  apt install docker-ce -y
  docker run hello-world
  curl -L https://github.com/docker/compose/releases/download/1.23.2/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
  chmod +x /usr/local/bin/docker-compose
  
  if [ -z "$COMMON_USER" ]
  then
      warn "Docker will only work on sudo user."
  else
      usermod -aG docker $COMMON_USER
      warn "Now you can use docker with no sudo. But you're need to reboot."
  fi
  success "Docker installed SUCCESSFULLY"
}

setup_nvidia_graphic_card() {
  info "Let me check if there's a supported graphics card..."
  GRAPHIC_CARD=$(lspci | grep -i vga | grep GeForce | egrep -o 'GeForce\s\w+\s[0-9]+')
  if [ -z "$GRAPHIC_CARD" ]
  then
      info "Graphic Card ($GRAPHIC_CARD) not supported"
  else
      add-apt-repository -u -s -y ppa:graphics-drivers/ppa
      ubuntu-drivers devices
      apt install $(ubuntu-drivers devices | grep -i recommended | egrep -o 'nvidia-driver-[0-9]+') -y
      success "NVIDIA Drivers installed SUCCESSFULLY"
  fi
}

miscellaneous() {
  info "Solving the BCM943602CS problem... Wifi works on Ubuntu 18.04 but bluetooth not..."
  BCM_DEVICE=$(lsusb | egrep -o '05ac:8290')
  if [ -z "$BCM_DEVICE" ]
  then
      info "BCM943602CS was not detected. OK, keep going."
  else
      cp ./firmware/bluetooth/BCM-0a5c-6410.hcd /lib/firmware/brcm
      warn "You need to reboot in order to make bluetooth work again."
      success "BCM943602CS firmware installed SUCCESSFULLY"
  fi
}

info ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
info "::::::::: Setup Script For $(lsb_release -d -s) :::::::::::"
info ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
info ""
info ""
info "This setup is meant for developers, so if you're not a "
info "developer do not use it"
info ""
info ""

check_root

apt update
apt upgrade -y
apt autoremove

info "Type the name of your user (not root), followed by [ENTER]:"
read COMMON_USER
info "Some configurations will be applied to $COMMON_USER"

install_goodies
install_developer_things
setup_nvidia_graphic_card
miscellaneous

info ""
info ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
success ":::::::::: Setup for $(lsb_release -d -s) has DONE! :::::::"
info ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
info ""
