#!/bin/bash

# Variables
TOOL_NAME="cutadapt"
TOOL_VERSION="5.0"

# Paths
TARGET_DIR="$INSTALL_DIR/$TOOL_NAME/$TOOL_NAME-$TOOL_VERSION"

# Installation via Venv
mkdir -p "$TARGET_DIR"
python3 -m venv "$TARGET_DIR"

# Source the venv to install
source "$TARGET_DIR/bin/activate"
pip install -q --upgrade pip
pip install -q cutadapt=="$TOOL_VERSION"
deactivate

# Modules lua file
# The binaries (cutadapt) will live in the 'bin' folder of the venv
make_lua_module "$TOOL_NAME" "$TOOL_VERSION" "$TARGET_DIR/bin"
