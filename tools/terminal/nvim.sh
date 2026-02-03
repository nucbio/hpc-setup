#!/bin/bash

cd $INSTALL_DIR
mkdir tools && cd tools
mkdir nvim && cd nvim
wget https://github.com/neovim/neovim/releases/download/v0.11.5/nvim-linux-x86_64.tar.gz
tar xzf nvim-linux-x86_64.tar.gz
export PATH=/projects/p_bp/tools/nvim/nvim-linux-x86_64/bin:$PATH
source ~/.bashrc
nvim --version # to check if installed

## Move configurations to HPC
mkdir -p $HOME/.config/nvim
mkdir -p ~/.local/share/fonts

## Configure Font (Copy them first from Desktop - see bellow)
fc-cache -fv ~/.local/share/fonts
