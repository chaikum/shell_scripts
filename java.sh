#! /bin/bash
sudo su -
apt update
if [ javac -version -eq "javac 1.8.0_312"]
then
    echo "The java is installed"
else
 
    apt install openjdk-8-jdk -y
fi
javac -version
