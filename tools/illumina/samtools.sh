#!/bin/bash

mkdir -p $INSTALL_DIR/samtools/samtools-1.23
cd $INSTALL_DIR/samtools/samtools-1.23

mkdir build
wget https://github.com/samtools/samtools/releases/download/1.23/samtools-1.23.tar.bz2 
tar -xjf samtools-1.23.tar.bz2
cd samtools-1.23/
./configure --disable-bz2 --prefix=$INSTALL_DIR/samtools/samtools-1.23/build
# --disable-bz2 is because libbzip2 package dependency is missing
make && make install
