#! /bin/bash
./java.sh
apt-get install wget unzip -y

cd /opt
wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.59/bin/apache-tomcat-9.0.59.zip
unzip apache-tomcat-9.0.59.zip
cd apache-tomcat-9.0.59/bin
chmod u+x *.sh
unlink /usr/bin/startTomcat
unlink /usr/bin/stopTomcat
ln -s /opt/apache-tomcat-9.0.59/bin/startup.sh /usr/bin/startTomcat
ln -s /opt/apache-tomcat-9.0.59/bin/shutdown.sh /usr/bin/stopTomcat
chmod +x startTomcat
startTomcat
