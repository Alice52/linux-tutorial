#!/bin/bash
sudo rm -rf /opt/java
sudo mkdir -p /opt/java/jdk

sudo mkdir -p /opt/java/maven
sudo mkdir -p /opt/java/gradle
sudo mkdir -p /opt/java/maven-repository

echo '############ 1.install maven ############'
sudo cp ~/software/apache-mave* /opt/java/maven
cd /opt/java/maven
sudo tar -zxvf apache-mave*
sudo rm apache-maven-3.6.1-bin*
cd apache-maven*
cd conf
sudo mv settings.xml settings.xml.bak
sudo wget 'https://gitee.com/alice52_xz/codes/gkp1ytqi9xjz4h5c03vm726/raw?blob_name=settings.xml' -O settings.xml

echo '############ 2.install jdk ############'
sudo cp ~/software/jdk* /opt/java/jdk
cd /opt/java/jdk
sudo tar -zxvf jdk*
sudo rm jdk-8u221-linux*

echo '############ 3.install gradle ############'
sudo cp ~/software/gradle* /opt/java/gradle
cd /opt/java/gradle
sudo unzip gradle*
sudo rm gradle*.zip

echo '############ 4.install idea ############'
sudo cp ~/software/idea* /opt/java
cd /opt/java
sudo tar -zxvf idea*
sudo rm idea*.gz
sudo mv idea* idea
