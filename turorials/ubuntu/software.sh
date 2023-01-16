#!/bin/bash

cd ~/software

echo '############ 1.install netease-cloud-music ############'
sudo dpkg -i netease-cloud-music*

echo '############ 2.install chrome ############'
sudo dpkg -i google-chrome*

echo '############ 3.install vscode ############'
sudo dpkg -i code_*

echo '############ 4.install sogou ############'
sudo dpkg -i sogoupinyin*
# TODO: catch exception
sudo apt-get install -f -y
sudo dpkg -i sogoupinyin*
