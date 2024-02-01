#!/bin/bash

# you can run this commands before running this script
# sudo apt-get install sudo curl -y

# update software
sudo apt-get update
sudo apt-get upgrade -y

# install software
sudo apt install nano -y
sudo apt-get install git -y
sudo apt-get install build-essential -y
# sudo apt-get install snapd -y

# install nodejs
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg
NODE_MAJOR=20
echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | sudo tee /etc/apt/sources.list.d/nodesource.list
sudo apt-get update
sudo apt-get install -y nodejs

# switch to n package manager
mkdir -p ${HOME}/.n && chmod -R 755 ${HOME}/.n

sudo npm install -g n
echo 'export N_PREFIX=$HOME/.n' >> $HOME/.bashrc
echo 'export PATH=$N_PREFIX/bin:$PATH' >> $HOME/.bashrc

source ~/.bashrc

n lts

echo "Installed node version: $(node -v)"
echo "Installed npm version: $(npm -v)"

# install yarn
npm install -g yarn
echo "Installed yarn version: $(yarn -v)"

# install anaconda with silent install
# https://docs.anaconda.com/anaconda/install/silent-mode/
sudo apt-get install -y libgl1-mesa-glx libegl1-mesa libxrandr2 libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6
curl https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -o $HOME/miniconda.sh
bash $HOME/miniconda.sh -b -p $HOME/miniconda
eval "$($HOME/miniconda/bin/conda shell.bash hook)"

conda init
conda config --set auto_activate_base true
conda update --all -y

source ~/.bashrc

rm $HONE/miniconda.sh
# Install golang
sudo apt update
sudo add-apt-repository -y ppa:longsleep/golang-backports
sudo apt update
sudo apt install -y golang-go

echo 'export GOPATH=$HOME' >> $HOME/.bashrc
echo 'export PATH=$PATH:$HOME/go/bin' >> $HOME/.bashrc
echo 'export PATH=$PATH:$GOPATH/bin' >> $HOME/.bashrc

source ~/.bashrc
echo "Installed go version: $(go version)"

# Install aws and gcp
sudo apt-get install -y apt-transport-https ca-certificates gnupg curl sudo
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
echo "deb [signed-by=/usr/share/keyrings/cloud.google.gpg] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
sudo apt-get update && sudo apt-get install -y google-cloud-cli

echo "Installed gcp-cli"
echo "done!"
