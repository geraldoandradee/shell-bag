#!/usr/bin/env bash 

sudo apt update
sudo apt upgrade -y

wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'

sudo apt install apt-transport-https
sudo apt update
sudo apt install code # or code-insiders

echo "Installing NODE"
sudo apt install curl software-properties-common
curl -sL https://deb.nodesource.com/setup_12.x | sudo bash -
sudo apt install nodejs -y
sudo npm install wscat yo -g

echo "Installing Docker"
sudo apt remove docker docker-engine docker.io containerd runc -y
sudo apt update
sudo apt install apt-transport-https ca-certificates curl gnupg-agent software-properties-common -y
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian $(lsb_release -cs) stable"
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-compose -y
sudo usermod -aG docker $USER

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