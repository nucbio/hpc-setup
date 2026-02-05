#!/bin/bash

# Variables
export NVIM_VERSION="v0.10.4" # Note: check GitHub for latest; 0.11.0+ are often nightly
TOOL_NAME="nvim"
SOURCE_URL="https://github.com/neovim/neovim/releases/download/${NVIM_VERSION}/nvim-linux-x86_64.tar.gz"
SOURCE_ARCHIVE="$INSTALL_DIR/sources"
TARGET_DIR="$INSTALL_DIR/$TOOL_NAME/$TOOL_NAME-$NVIM_VERSION"

# 1. Download directly to the sources directory
wget -q "$SOURCE_URL" -O "$SOURCE_ARCHIVE/${TOOL_NAME}-${NVIM_VERSION}.tar.gz"

# 2. Create target directory and unpack in one go
mkdir -p "$TARGET_DIR"
tar -xzf "$SOURCE_ARCHIVE/${TOOL_NAME}-${NVIM_VERSION}.tar.gz" -C "$TARGET_DIR" --strip-components=1

# 3. Module generation
make_lua_module "nvim" "$NVIM_VERSION"

# Make sure to copy configuration to ~/.config/nvim
# Make sure that fonts are installed
