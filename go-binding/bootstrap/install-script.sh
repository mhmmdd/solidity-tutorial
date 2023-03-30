#!/bin/sh
sudo apt install net-tools # ifconfig
sudo apt-get update -y
sudo apt-get install -y curl
sudo apt-get install -y wget


# Install ethereum
sudo add-apt-repository -y ppa:ethereum/ethereum
sudo apt-get update -y
sudo apt-get install -y ethereum

# Install go
wget  https://go.dev/dl/go1.20.2.linux-amd64.tar.gz
sudo tar -C /usr/local -xzf go1.20.2.linux-amd64.tar.gz
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.bashrc
source ~/.bashrc
sudo rm go1.20.2.linux-amd64.tar.gz
#echo 'export PATH=$PATH:/usr/local/go/bin' >> $HOME/.profile
#source $HOME/.profile
go version
# go version go1.20.2 linux/amd64

# Install solc
wget https://github.com/ethereum/solidity/releases/download/v0.8.19/solc-static-linux
sudo mv solc-static-linux /usr/bin/solc
sudo chmod +x /usr/bin/solc
solc --version
# solc, the solidity compiler commandline interface
# Version: 0.8.19+commit.c4cbbb05.Linux.g++


