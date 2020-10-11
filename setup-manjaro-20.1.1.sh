#!/usr/bin/env bash 

check_root() {
  if [ $(whoami) != "root" ]
  then
    echo ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
    echo "######### This script must be executed as root! #########"
    echo ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
    exit 1
  fi
}


echo ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
echo "::::::::::::: Setup Script For Manjaro 20 :::::::::::::::"
echo "::::::::::::: Debian GNU/Linux 10 (buster) ::::::::::::::" 
echo ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
echo ""
echo ""
echo "This setup is meant for developers, so if you're not a "
echo "developer do not use it"
echo ""
echo ""

check_root

echo "Type the name of your user (not root), followed by [ENTER]:"
read COMMON_USERNAME
echo "Github/Docker configurations will be applied to $COMMON_USERNAME"

echo "Type your name (i.e. hi@someemail.com), followed by [ENTER]:"
read COMMON_USER_EMAIL
echo "Github configurations will be applied to $COMMON_USER_EMAIL"

echo "Type your email (i.e. Your Name), followed by [ENTER]:"
read COMMON_USER_NAME
echo "Github configurations will be applied to $COMMON_USER_NAME"

pacman -Syu

echo "Installing Developer Basics"
pacman -S base-devel --noconfirm

echo "Installing Visual Studio Code"
pacman -S code --noconfirm

echo "Installing Golang"
pacman -S go --noconfirm

echo "Installing Chromium"
pacman -S chromium --noconfirm

echo Setting up github
git config --global user.email "$COMMON_USER_EMAIL"
git config --global user.name "$COMMON_USER_NAME"


echo "Installing Docker"
pacman -S docker docker-compose --noconfirm
systemctl start docker.service
systemctl enable docker.service
groupadd docker
gpasswd -a user docker $COMMON_USERNAME

echo "Installing Kubernetes Management Tools"
pacman -S kubectl helm --noconfirm

echo "Installing Pypy"
pacman -S pypy3 pypy --noconfirm

echo "Installing Google Clould SDK"
git clone https://aur.archlinux.org/google-cloud-sdk.git
cd google-cloud-sdk/
su $COMMON_USERNAME 
makepkg -si
cd ..
rm -rf google-cloud-sdk/
exit

echo ""
echo ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
echo "::::::::::: Setup for $(lsb_release -d -s) has DONE! :::::::::"
echo ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
echo ""
