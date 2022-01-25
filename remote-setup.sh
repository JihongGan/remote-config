#!/bin/bash
#
# remote-setup
#
# setup dev environment for remote machine
#
# Jihong Gan <jhgan99@gmail.com>

# Stop on errors, print commands
# See https://vaneyckt.io/posts/safer_bash_scripts_with_set_euxo_pipefail/
#set -Eeuo pipefail
#set -x

cd ~

sudo apt update
sudo apt upgrade
sudo apt install build-essential libncurses-dev
sudo apt-get install manpages-dev
sudo ln -s /usr/bin/python3 /usr/bin/python

# vim setup
# TODO: no need to manually install vim unless it's ubuntu16.04
sudo apt remove vim
git clone https://github.com/vim/vim.git
cd vim/src
make
sudo make install
cd ~
sudo rm -rf vim
cp ~/remote-config/.vimrc ~
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim -c ":PlugInstall" \
    -c "qa!"
cd ~

# zsh and oh-my-zsh
sudo apt install zsh
# set zsh as default, but installing oh-my-zsh should do the wrok already
#chsh -s $(which zsh)
zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
cp ~/remote-config/.zshrc ~
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/jeffreytse/zsh-vi-mode \
  $ZSH/custom/plugins/zsh-vi-mode
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
# install autojump
cd ~
git clone git://github.com/wting/autojump.git
cd autojump
./install.py
cd ~
rm -rf autojump
source .zshrc

sudo apt autoremove

clear

