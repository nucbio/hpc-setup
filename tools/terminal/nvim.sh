#!/bin/bash

echo "Install nvim"

# Variables
TOOL_NAME="nvim"
NVIM_VERSION=$(pkg_version "$TOOL_NAME")
SOURCE_URL=$(pkg_url "$TOOL_NAME")
SOURCE_ARCHIVE="$INSTALL_DIR/sources"
TARGET_DIR="$INSTALL_DIR/$TOOL_NAME/$TOOL_NAME-$NVIM_VERSION"

# Already installed by a previous run? (see functions/stamp.sh)
if skip_if_installed "$TOOL_NAME" "$NVIM_VERSION"; then
  return 0
fi

# 1. Download directly to the sources directory
wget -q "$SOURCE_URL" -O "$SOURCE_ARCHIVE/${TOOL_NAME}-${NVIM_VERSION}.tar.gz"

# 2. Create target directory and unpack in one go
mkdir -p "$TARGET_DIR"
tar -xzf "$SOURCE_ARCHIVE/${TOOL_NAME}-${NVIM_VERSION}.tar.gz" -C "$TARGET_DIR" --strip-components=1

# 3. Module generation
module_templater "nvim"

# Make sure to copy configuration to ~/.config/nvim
# Make sure that fonts are installed
