#!/bin/bash

# Ninja

NINJA_VERSION=$(get_latest_github_release "ninja-build/ninja")

# Fallback if the API parsing fails
# FIXME: This can be replaced with a single line to set default if empty variable
if [ -z "$NINJA_VERSION" ]; then
    NINJA_VERSION="1.12.1" # Manually set a fallback version
    echo "Could not detect latest version, falling back to $NINJA_VERSION"
fi

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
