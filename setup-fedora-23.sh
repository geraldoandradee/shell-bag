#/usr/bin/env bash
echo ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
echo ":::::::::::::: Setup Script For Fedora 23 :::::::::::::::"
echo ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
echo ""
echo "This script must be executed as root!"
echo "Lets setup all this shit"

dnf update -y
dnf install wget curl -y

dnf group install "Development Tools" -y
dnf install zlib-devel sqlite-devel openssl-devel bzip2-devel readline-devel tk-devel -y

cd ~
wget https://www.python.org/ftp/python/2.7.11/Python-2.7.11.tgz
tar xzf Python-2.7.11.tgz
cd Python-2.7.11
./configure --prefix=/opt/python/2.7.11
make -j 20 && make install && cd ..

wget https://www.python.org/ftp/python/3.5.1/Python-3.5.1.tgz
tar xzf Python-3.5.1.tgz
cd Python-3.5.1
./configure --prefix=/opt/python/3.5.1
make -j 20 && make install && cd ..


echo ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
echo ":::::::::::::::::: Have a happy life! :::::::::::::::::::"
echo ":::::::::::::::::::::::::::::::::::::::::::::::::::::::::"
echo ""