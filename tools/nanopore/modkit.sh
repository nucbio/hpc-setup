#!/bin/bash

echo "Install modkit"
# Variables
export MODKIT_VERSION="0.5.0"
TOOL_NAME="modkit"
# Note: Check the exact filename on GitHub. It usually includes the architecture.
SOURCE_URL="https://github.com/nanoporetech/modkit/releases/download/v0.6.0/modkit_v0.6.0_u16_x86_64.tar.gz"
TARGET_DIR="$INSTALL_DIR/$TOOL_NAME/$TOOL_NAME-$MODKIT_VERSION"
SOURCE_ARCHIVE="$INSTALL_DIR/sources"

# 1. Prepare Environment
mkdir -p "$SOURCE_ARCHIVE"
cd "$SOURCE_ARCHIVE"
echo "FLAG 1"
wget "$SOURCE_URL" -O "${TOOL_NAME}-${MODKIT_VERSION}.tar.gz"
echo "FLAG 2"
# 3. Unpack directly into the TARGET_DIR
mkdir -p "$TARGET_DIR/bin"
# --strip-components=1 removes the top-level folder from the tar if it exists
tar -xzf "${TOOL_NAME}-${MODKIT_VERSION}.tar.gz" -C "$TARGET_DIR/bin" --strip-components=1

# 4. Check for documentation/man
# If the tar includes a 'man' or 'docs' folder, we move it to share
# if [ -d "$TARGET_DIR/bin/man" ]; then
#     mkdir -p "$TARGET_DIR/share"
#     mv "$TARGET_DIR/bin/man" "$TARGET_DIR/share/"
# fi

# 6. Module generation
make_lua_module "modkit" "$MODKIT_VERSION" "$TARGET_DIR/bin"
