#!/bin/bash

# Install OpenTofu
LATEST_VERSION=$(curl --silent https://api.github.com/repos/tofuutils/tenv/releases/latest | jq -r .tag_name)
curl -O -L "https://github.com/tofuutils/tenv/releases/latest/download/tenv_${LATEST_VERSION}_amd64.deb"
sudo dpkg -i "tenv_${LATEST_VERSION}_amd64.deb"

tenv completion bash > ~/.tenv.completion.bash
echo "source \$HOME/.tenv.completion.bash" >> ~/.bashrc

export TENV_AUTO_INSTALL=true >> ~/.bashrc
source ~/.bashrc

tenv tofu install latest
