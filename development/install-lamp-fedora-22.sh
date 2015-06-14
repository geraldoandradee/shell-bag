#!/usr/bin/bash

if [ $(whoami) != "root" ];
then
	echo "The follow commands demands to be root";
	exit 1;
fi

echo "################################################################################"
echo "######################## Geraldo Andrade's LAMP Installer ######################"
echo "############################# Designed for Fedora 22 ###########################"
echo "####### More information at https://github.com/geraldoandradee/shell-bag #######"
echo "################################################################################"

echo "Installing Apache Http Server"
dnf install httpd -y
systemctl enable httpd
systemctl start httpd
firewall-cmd --permanent --add-service=http
firewall-cmd --permanent --add-service=https
firewall-cmd --reload
echo "Done"

echo "Installing MariaDB Server"
dnf install mariadb mariadb-server -y
systemctl enable mariadb
systemctl start mariadb
mysql_secure_installation
echo "Done"


echo "Installing PHP"
# php-xcache, only for production
dnf install php php-mysql php-mcrypt php-gd php-xml php-imap php-devel php-pdo php-soap php-cli php-magickwand -y
systemctl restart httpd
echo $(php -v)
echo "Done"

echo "Installing Some PHP Improvements"
dnf install php-pear php-pecl-memcache -y
dnf install memcached -y

echo 'PORT="11211"
USER="memcached"
MAXCONN="1024"
CACHESIZE="2048"
OPTIONS=""' > /etc/sysconfig/memcached
systemctl restart memcached
echo "Done"


echo "################################################################################"
echo "#################################### ALL DONE ##################################"
echo "################################################################################"