#!/bin/bash

# FastQC Install
mkdir -p $INSTALL_DIR/fastqc/fastqc-0.12.1
cd $INSTALL_DIR/fastqc/fastqc-0.12.1/
wget https://github.com/s-andrews/FastQC/archive/refs/tags/v0.12.1.zip
unzip fastqc_v0.12.1.zip
