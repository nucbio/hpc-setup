#!/bin/bash

# Ninja
#FIXME take defined version for the release
NINJA_VERSION="1.13.2"

# 2. Create the versioned directory
TARGET_DIR="${INSTALL_DIR}/ninja/ninja-${NINJA_VERSION}"
mkdir -p "$TARGET_DIR"

# 3. Download the Linux zip using wget
cd /tmp
URL="https://github.com/ninja-build/ninja/releases/download/v${NINJA_VERSION}/ninja-linux.zip"

echo "Downloading Ninja v${NINJA_VERSION} via wget..."
wget -O ninja-linux.zip "$URL"

# 4. Unpack and clean up
# -o overwrites without prompting
unzip -o ninja-linux.zip -d "$TARGET_DIR"
chmod +x "$TARGET_DIR/ninja"
rm ninja-linux.zip

make_lua_module ninja "$NINJA_VERSION" "$INSTALL_DIR/ninja/ninja-$NINJA_VERSION"
