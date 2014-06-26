#/usr/bin/env bash
echo ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
echo "::::::::::::: Setup Script For Ubuntu 13.04 :::::::::::::"
echo ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
echo ""
echo "This script must be executed as root!"
echo "Lets setup all this shit"

apt-get update -y
apt-get install vim terminator git-core gimp inotify-tools -y

add-apt-repository ppa:webupd8team/java -y && apt-get update -y
apt-get install oracle-jdk7-installer -y

add-apt-repository ppa:webupd8team/sublime-text-2 -y && apt-get update -y
apt-get install sublime-text -y

apt-get install gcc g++ build-essential -y

echo "Installing google chrome"
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
dpkg -i google-chrome-stable_current_amd64.deb
rm -rf google-chrome-stable_current_amd64.deb

echo "Installing CURL"
apt-get install curl -y

echo "Installing LAMP"
apt-get install mysql-server mysql-client apache2 php5 libapache2-mod-php5 apache2-mpm-itk php5-mysql php5-curl php5-gd php-pear php5-mcrypt php5-sqlite -y
a2enmod rewrite # activate a great mod
/etc/init.d/apache2 restart

echo "For Pythonists..."
echo "For some Troubles with MySQL-Python, LXML, mysql-client and some dependencies that not compile"
apt-get install python-dev python-pip python-mysqldb libmysqlclient-dev libxml2-dev libxslt-dev python-lxml python-sphinx -y
easy_install -U distribute

echo "Lets install MongoDB"
apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/ubuntu-upstart dist 10gen' | sudo tee /etc/apt/sources.list.d/mongodb.list 
apt-get update && apt-get install mongodb-org