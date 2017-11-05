#/usr/bin/env bash
echo ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
echo "::::::::::::: Setup Script For $(lsb_release -d -s) :::::::"
echo ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
echo ""

# Constants
RED='\033[0;31m'
NC='\033[0m' # No Color
GREEN='\033[0;32m'

# Inputs
SETUP_FOR_USER=$1

if [ $(whoami) != "root" ]
then
  echo "This script must be executed as root!"
  exit 1
fi


echo "Lets setup $(cat /etc/hostname)!"

echo "Adding some repos..."
add-apt-repository ppa:webupd8team/java -y
add-apt-repository ppa:webupd8team/sublime-text-2 -y
wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
sh -c 'echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list'
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
wget -q -O - https://deb.nodesource.com/gpgkey/nodesource.gpg.key | apt-key add -
echo "deb https://deb.nodesource.com/node_8.x $(lsb_release -c -s) main" > /etc/apt/sources.list.d/nodesource.list
add-apt-repository ppa:graphics-drivers/ppa -y
echo -e "${GREEN}DONE${NC}"

echo "Updating repository local cache"
apt-get update -y
echo -e "${GREEN}DONE${NC}"

echo "Installing softwares"
apt-get install vim terminator git-core gimp inotify-tools -y
apt-get install oracle-java8-installer oracle-java8-set-default -y
apt-get install sublime-text -y
apt-get install gcc g++ build-essential -y
apt-get install google-chrome-stable -y
apt-get install curl -y

echo "Installing docker..."
apt-get install docker.io -y
usermod -aG docker $USER
gpasswd -a $USER docker
newgrp docker
sed -i -e 's/dns=dnsmasq/#dns=dnsmasq/g' /etc/NetworkManager/NetworkManager.conf
systemctl restart NetworkManager.service
systemctl start docker
systemctl enable docker
docker run hello-world
echo -e "${GREEN}DONE! You can run docker as non super user!${NC}"

echo "Installing nvidia support"
apt-get purge nvidia-* -y
apt-get install nvidia-384 -y
echo -e "${GREEN}DONE!${NC}"

echo "Setup mouse natural scrolling"
echo "pointer = 1 2 3 5 4 6 7 8 9 10 11 12" > /home/$SETUP_FOR_USER/.Xmodmap
chown $SETUP_FOR_USER:$SETUP_FOR_USER /home/$SETUP_FOR_USER/.Xmodmap
echo -e " ${GREEN}DONE!${NC}"

echo "Setup steam"
echo "" > /etc/ld.so.conf.d/steam.conf
echo "/usr/lib32" >> /etc/ld.so.conf.d/steam.conf
echo "/usr/lib/i386-linux-gnu/mesa" >> /etc/ld.so.conf.d/steam.conf
apt-get install --reinstall libgl1-mesa-glx:i386 steam -y
echo -e " ${GREEN}DONE!${NC}"  

echo ""
echo ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
echo ":::::::::: Setup for $(lsb_release -d -s) was DONE! :::::::"
echo ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
echo ""

