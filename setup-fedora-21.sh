#!/usr/bin/bash

su -
yum update
yum install wget curl -y

yum group install "Development Tools" -y
yum install zlib-devel sqlite-devel openssl-devel bzip2-devel readline-devel tk-devel -y

cd ~
wget https://www.python.org/ftp/python/2.7.9/Python-2.7.9.tgz
tar xzf Python-2.7.9.tgz
cd Python-2.7.9
./configure --prefix=/opt/python/2.7.9
make -j 20 && make install && cd ..

wget https://www.python.org/ftp/python/3.4.2/Python-3.4.2.tgz
tar xzf Python-3.4.2.tgz
cd Python-3.4.2
./configure --prefix=/opt/python/3.4.2
make -j 20 && make install && cd ..

wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
rpm -i google-chrome-stable_current_x86_64.rpm


wget http://download-cf.jetbrains.com/webide/PhpStorm-8.0.3.tar.gz
wget http://download-cf.jetbrains.com/webstorm/WebStorm-9.0.3.tar.gz
wget http://download-cf.jetbrains.com/python/pycharm-professional-4.0.5.tar.gz
wget http://download-cf.jetbrains.com/idea/ideaIU-14.0.3.tar.gz

