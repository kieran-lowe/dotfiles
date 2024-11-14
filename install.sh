#!/bin/bash

TEMP_DIR=$(mktemp -d)

cd $TEMP_DIR

# Install tenv/OpenTofu
LATEST_VERSION=$(curl --silent https://api.github.com/repos/tofuutils/tenv/releases/latest | jq -r .tag_name)
curl -O -L "https://github.com/tofuutils/tenv/releases/latest/download/tenv_${LATEST_VERSION}_amd64.deb"
sudo dpkg -i "tenv_${LATEST_VERSION}_amd64.deb"

tenv completion bash > ~/.tenv.completion.bash
echo "source \$HOME/.tenv.completion.bash" >> ~/.bashrc

echo "export TENV_AUTO_INSTALL=true" >> ~/.bashrc
source ~/.bashrc
tenv tofu install latest

# Install AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
echo "alias tfmt=\"tofu fmt --recursive\"" >> ~/.bashrc
echo "complete -C '/usr/local/bin/aws_completer' aws" >> ~/.bashrc

sudo rm -rf $TEMP_DIR
source ~/.bashrc