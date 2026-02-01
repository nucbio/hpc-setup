#!/bin/bash

# Java 17.0.12
mkdir -p $INSTALL_DIR/java/java-17.0.12
cd $INSTALL_DIR/java/java-17.0.12
wget https://download.oracle.com/java/17/archive/jdk-17.0.12_linux-x64_bin.tar.gz
tar -xzvf jdk-17.0.12_linux-x64_bin.tar.gz

# Java 25.0.1
mkdir -p $INSTALL_DIR/java/java-25.0.1
cd $INSTALL_DIR/java/java-25.0.1
wget https://download.oracle.com/java/25/archive/jdk-25.0.1_linux-x64_bin.tar.gz
tar -xzvf jdk-25.0.1_linux-x64_bin.tar.gz --strip-components=1
rm jdk-25.0.1_linux-x64_bin.tar.gz
