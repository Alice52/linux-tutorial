#!/bin/bash

echo '############ 2.config ssh ############'
ssh-keygen -t rsa
echo -e "\033[44;37;5m please fill in ssh in github and gitee.\033[0m"
echo "ssh is : "
cat ~/.ssh/id_rsa.pub
read input1

echo '############ 3.CLONE REPOS ############'
mkdir -p ~/workspace/repos
cd ~/workspace/repos

git clone git@github.com:Alice52/java-ocean.git
git clone git@github.com:Alice52/tutorials-sample.git
git clone git@gitee.com:alice52_xz/personal-details.git
git clone git@github.com:Alice52/Alice52.git
git clone git@github.com:Alice52/project.git
git clone git@github.com:Alice52/go-tutorial.git
git clone git@github.com:Alice52/grpc-tutorials.git
