#!/usr/bin/env bash 

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


info ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
info "::::::::: Setup Script For Linux/Chrome OS 85 :::::::::::"
info "::::::::::::: Debian GNU/Linux 10 (buster) ::::::::::::::" 
info ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
info ""
info ""
info "This setup is meant for developers, so if you're not a "
info "developer do not use it"
info ""
info ""

check_root

info "Type the name of your user (not root), followed by [ENTER]:"
read COMMON_USERNAME
info "Github/Docker configurations will be applied to $COMMON_USERNAME"

info "Type your name (i.e. hi@geraldoandrade.com), followed by [ENTER]:"
read COMMON_USER_EMAIL
info "Github configurations will be applied to $COMMON_USER_EMAIL"

info "Type your email (i.e. Geraldo Andrade), followed by [ENTER]:"
read COMMON_USER_NAME
info "Github configurations will be applied to $COMMON_USER_NAME"

apt update
apt upgrade -y

wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
bash -c 'echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

apt install apt-transport-https -y
apt update
apt install code -y # or code-insiders

echo "Installing NODE"
apt install curl software-properties-common -y
curl -sL https://deb.nodesource.com/setup_12.x | sudo bash -
sudo apt install nodejs -y
sudo npm install wscat yo -g

echo "Installing Docker"
apt remove docker docker-engine docker.io containerd runc -y
apt update
apt install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
apt update
apt install docker-ce docker-ce-cli containerd.io docker-compose -y
usermod -aG docker $COMMON_USERNAME

echo "Installing Google Cloud SDK"
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] http://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key --keyring /usr/share/keyrings/cloud.google.gpg add -
sudo apt update && sudo apt install google-cloud-sdk kubectl -y

echo "Installing K9s"
wget https://github.com/derailed/k9s/releases/download/v0.22.1/k9s_Linux_x86_64.tar.gz
sudo tar xzf k9s_Linux_x86_64.tar.gz -C /usr/local/bin/
rm k9s_Linux_x86_64.tar.gz


echo "Installing Slack"
wget https://downloads.slack-edge.com/linux_releases/slack-desktop-4.9.1-amd64.deb
sudo dpkg -i slack-desktop-4.9.1-amd64.deb
rm slack-desktop-4.9.1-amd64.deb

echo "Installing Postman"
sudo apt install flatpak -y
flatpak --user remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
flatpak install flathub com.getpostman.Postman -y 

echo Install Homebrew
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
echo 'eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)' >> /home/geraldoandrade/.profile
eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
brew install gcc 

echo Installing GoLang
brew install go


echo Setting up github
git config --global user.email "$COMMON_USER_EMAIL"
git config --global user.name "$COMMON_USER_NAME"


info ""
info ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
success ":::::::::: Setup for $(lsb_release -d -s) has DONE! :::::::"
info ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
info ""
