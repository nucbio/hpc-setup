#!/bin/bash

PKG_NAME="jq"
export JQ_VERSION=1.8.1

JQ_DIR=$INSTALL_DIR/$PKG_NAME/$PKG_NAME-$JQ_VERSION

mkdir -p $JQ_DIR
cd $JQ_DIR
wget -O jq https://github.com/jqlang/jq/releases/download/jq-1.8.1/jq-linux64 && chmod +x jq

# Modules lua file
module_templater "$PKG_NAME"
