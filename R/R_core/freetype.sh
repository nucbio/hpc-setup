#!/bin/bash

echo "Install FreeType"

# Variables
TOOL_NAME="freetype"
export FREETYPE_VERSION="2.14.1"
SOURCE_URL="https://download.savannah.gnu.org/releases/freetype/freetype-${FREETYPE_VERSION}.tar.gz"
TARGET_DIR="$INSTALL_DIR/$TOOL_NAME/$TOOL_NAME-$FREETYPE_VERSION"
SOURCE_ARCHIVE="$INSTALL_DIR/sources"

# 1. Prepare Environment
mkdir -p "$SOURCE_ARCHIVE"
rm -rf /tmp/$TOOL_NAME-build
mkdir -p /tmp/$TOOL_NAME-build
cd /tmp/$TOOL_NAME-build

# 2. Download and Archive
wget -q "$SOURCE_URL" -O "${TOOL_NAME}-${FREETYPE_VERSION}.tar.gz"
cp "${TOOL_NAME}-${FREETYPE_VERSION}.tar.gz" "$SOURCE_ARCHIVE/"

# 3. Unpack
tar -xzf "${TOOL_NAME}-${FREETYPE_VERSION}.tar.gz"
cd "freetype-${FREETYPE_VERSION}"

# 4. Configure with Meson
meson setup build_dir \
    --prefix="$TARGET_DIR" \
    --buildtype=release

# 5. Build and Install
meson compile -C build_dir
meson install -C build_dir

# 6. Cleanup Build Area
rm -rf /tmp/$TOOL_NAME-build

# 7. Module generation
make_lua_module "freetype" "$FREETYPE_VERSION"

echo "FreeType installation complete"
