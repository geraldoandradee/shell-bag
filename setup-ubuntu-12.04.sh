#/usr/bin/env bash
echo ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
echo "::::::::::::: Setup Script For Ubuntu 12.04 :::::::::::::"
echo ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
echo ""
echo "This script must be executed as root!"
echo "Lets setup all this shit"

apt-get update -y
apt-get install vim -y
apt-get install terminator -y

add-apt-repository ppa:webupd8team/java && apt-get update
apt-get install oracle-jdk7-installer -y

apt-get install git-core -y

add-apt-repository ppa:webupd8team/sublime-text-2 && apt-get update
apt-get --purge remove sublime-text*
apt-get install sublime-text -y

apt-get install gcc g++ build-essential -y

apt-get install python-dev python-pip -y

echo "Installing amarok, an (not so) better music player"
apt-get install amarok -y

echo "Installing google chrome"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i google-chrome-stable_current_amd64.deb
rm -rf google-chrome-stable_current_amd64.deb

echo "Installing CURL"
apt-get install curl -y

echo "Installing LAMP"
apt-get install mysql-server mysql-client apache2 php5 libapache2-mod-php5 -y
/etc/init.d/apache2 restart

apt-get install php5-mysql php5-curl php5-gd php-pear php5-mcrypt php5-sqlite -y
/etc/init.d/apache2 restart

echo "For MP3 Troubles..."
apt-get install gstreamer0.10* -y

wget --output-document=/etc/apt/sources.list.d/medibuntu.list http://www.medibuntu.org/sources.list.d/$(lsb_release -cs).list && sudo apt-get --quiet update && sudo apt-get --yes --quiet --allow-unauthenticated install medibuntu-keyring && sudo apt-get --quiet update
apt-get --yes install app-install-data-medibuntu apport-hooks-medibuntu
apt-get install w64codecs ubuntu-restricted-extras -y

echo "For Pythonists..."
easy_install -U distribute
echo "For some Troubles with MySQL-Python, LXML, mysql-client and some dependencies that not compile"
apt-get install python-mysqldb libmysqlclient-dev libxml2-dev libxslt-dev python-lxml -y