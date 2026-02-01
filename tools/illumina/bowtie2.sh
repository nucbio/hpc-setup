#!/bin/bash

mkdir -p $INSTALL_DIR/bowtie2/bowtie2-2.5.4
cd $INSTALL_DIR/bowtie2/bowtie2-2.5.4
wget https://github.com/BenLangmead/bowtie2/releases/download/v2.5.4/bowtie2-2.5.4-linux-x86_64.zip
unzip bowtie2-2.5.4-linux-x86_64.zip

# Modulefile
$REPO_DIR/modules_lua/make_lua_1.sh bowtie2 2.5.4 "$INSTALL_DIR/bowtie2/bowtie2-2.5.4/bowtie2-2.5.4-linux-x86_64"

