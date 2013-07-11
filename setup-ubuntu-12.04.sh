#/usr/bin/env bash

echo "Lets setup all this shit"

apt-get update -y
apt-get install vim -y
apt-get install terminator -y

add-apt-repository ppa:webupd8team/java && sudo apt-get update
apt-get install oracle-jdk7-installer -y

apt-get install git-core -y
