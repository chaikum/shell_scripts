#! /bin/bash
if [ "$(javac -version)" == "javac 1.8.0_312" ];then
    echo "The java is installed"
  else
    sudo apt-get update -y
    sudo apt install openjdk-8-jdk -y
    javac -version
fi
