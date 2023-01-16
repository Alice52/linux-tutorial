#!/bin/bash

echo '############ 0. INSTALL PIP3 ############'
sudo apt-get install python3-pip -y
sudo apt-get install python3-distutils -y
sudo pip3 install --default-timeout=1000 -U pip

echo '############ 1. INSTALL GCC ############'
sudo apt-get install gcc -y

echo '############ 2. INSTALL vim ############'
sudo apt-get purge vim-common -y
sudo apt-get update -y
sudo apt-get install vim -y

echo '############ 3.INSTALL NET-TOOLS ############'
sudo apt-get install net-tools -y

echo '############ 4.INSTALL UNZIP ############'
sudo apt-get install unzip -y

echo '############ 5.INSTALL OPENDIR  ############'
sudo touch /usr/bin/opendir
sudo chmod 777 opendir
sudo echo 'if [ -n "$1" ]; then
    nohup nautilus "$1" > /dev/null 2>&1
else
    nohup nautilus "$(pwd)" > /dev/null 2>&1
fi
' >/usr/bin/opendir

echo '############ 6.INSTALL CURL ############'
sudo apt-get purge libcurl4 -y
sudo apt-get install curl -y

echo '############ 7.INSTALL zsh ############'
sudo apt-get install zsh -y
sudo curl https://gitee.com/alice52_xz/codes/ze89utkr0v3c2n6fb45ym25/raw?blob_name=ohmyzsh.sh >zsh-install.sh
sudo chmod +x ./zsh-install.sh
sudo ./zsh-install.sh

echo '############ 8.INSTALL GIT ############'
sudo apt-get install git -y
git config --global user.name "Alice52"
git config --global user.email "zzhang_xz@163.com"
ssh-keygen -t rsa

echo -e "\033[44;37;5m please fill in ssh in github and gitee.\033[0m"
echo "ssh is : "
cat /home/zack/.ssh/id_rsa.pub

read input1

echo '############ 9.CLONE REPOS ############'
mkdir -p ~/workspace/repos
cd ~/workspace/repos

git clone git@github.com:Alice52/java-ocean.git
git clone git@github.com:Alice52/tutorials-sample.git
git clone git@gitee.com:alice52_xz/personal-details.git
git clone git@github.com:Alice52/Alice52.git
git clone git@github.com:Alice52/project.git
git clone git@github.com:Alice52/go-tutorial.git
git clone git@github.com:Alice52/grpc-tutorials.git
