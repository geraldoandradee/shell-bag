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


wget http://download.oracle.com/otn-pub/java/jdk/7u79-b15/jdk-7u79-linux-x64.rpm
wget http://download.oracle.com/otn-pub/java/jdk/8u45-b14/jdk-8u45-linux-x64.rpm?AuthParam=1434119869_37ea86bdd062cb92e1a8ba4b82499db4

mkdir -p /home/geraldoandradee/apps
chown -R geraldoandradee:geraldoandradee /home/geraldoandradee

cd /home/geraldoandradee/apps
wget http://download-cf.jetbrains.com/cpp/clion-1.0.3.tar.gz
tar xzf clion-1.0.3.tar.gz && rm -rf clion-1.0.3.tar.gz

wget http://download-cf.jetbrains.com/webstorm/WebStorm-10.0.4.tar.gz
tar xzf WebStorm-10.0.4.tar.gz && rm -rf WebStorm-10.0.4.tar.gz

wget https://d1opms6zj7jotq.cloudfront.net/idea/ideaIU-14.1.3.tar.gz
tar xzf ideaIU-14.1.3.tar.gz && rm -rf ideaIU-14.1.3.tar.gz

wget http://download-cf.jetbrains.com/python/pycharm-professional-4.5.1.tar.gz
tar xzf pycharm-professional-4.5.1.tar.gz && rm -rf pycharm-professional-4.5.1.tar.gz

wget http://download-cf.jetbrains.com/webide/PhpStorm-8.0.3.tar.gz
tar xzf PhpStorm-8.0.3.tar.gz && rm -rf PhpStorm-8.0.3.tar.gz

wget http://download-cf.jetbrains.com/ruby/RubyMine-7.1.2.tar.gz
tar xzf RubyMine-7.1.2.tar.gz && rm -rf RubyMine-7.1.2.tar.gz
