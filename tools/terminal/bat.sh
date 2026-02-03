#!/bin/bash
cd $INSTALL_DIR

wget https://github.com/sharkdp/bat/releases/download/v0.26.1/bat-v0.26.1-x86_64-unknown-linux-gnu.tar.gz
tar -czf *.tar.gz
cd bat*
#add bat to bashrc
#$INSTALL_DIR/bat-v0.26.1-x86_64-unknown-linux-gnu/bat
#echo 'export PATH="$PATH:/home/suvar/tools/bat-v0.26.1-x86_64-unknown-linux-gnu"' >> ~/.bashrc
# Make bat a default man reader
#echo 'export MANPAGER="bat -l man -p"' >> ~/.bashrc
