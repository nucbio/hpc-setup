#!/bin/bash

# Cutadapt Install
mkdir -p $INSTALL_DIR/cutadapt/cutadapt-5.0
python3 -m venv $INSTALL_DIR/cutadapt/cutadapt-5.0
source $INSTALL_DIR/cutadapt/cutadapt-5.0/bin/activate
pip install --upgrade pip
pip install cutadapt
deactivate

# Modulefiles
$REPO_DIR/modules_lua/make_lua_1.sh catadap 5.0 "$INSTALL_DIR/catadapt/cutadapt-5.0/bin"

