#!/bin/bash

echo "Install FreeType"

# Variables
PKG_NAME="freetype"
export FREETYPE_VERSION="2.14.1"
PKG_SRC_URL="https://download.savannah.gnu.org/releases/freetype/freetype-${FREETYPE_VERSION}.tar.gz"
PKG_PREFIX="$INSTALL_DIR/$PKG_NAME/$PKG_NAME-$FREETYPE_VERSION"
PKG_ARCHIVE="$INSTALL_DIR/sources"

# 1. Prepare Environment
mkdir -p "$PKG_ARCHIVE"
rm -rf /tmp/$PKG_NAME-build
mkdir -p /tmp/$PKG_NAME-build
cd /tmp/$PKG_NAME-build

# 2. Download and Archive
wget -q "$PKG_SRC_URL" -O "${PKG_NAME}-${FREETYPE_VERSION}.tar.gz"
cp "${PKG_NAME}-${FREETYPE_VERSION}.tar.gz" "$PKG_ARCHIVE/"

# 3. Unpack
tar -xzf "${PKG_NAME}-${FREETYPE_VERSION}.tar.gz"
cd "freetype-${FREETYPE_VERSION}"

# 4. Configure with Meson
meson setup build_dir \
    --prefix="$PKG_PREFIX" \
    --buildtype=release

# 5. Build and Install
meson compile -C build_dir
meson install -C build_dir

# 6. Cleanup Build Area
rm -rf /tmp/$PKG_NAME-build

# 7. Module generation
make_lua_module "freetype" "$FREETYPE_VERSION"

echo "FreeType installation complete"
