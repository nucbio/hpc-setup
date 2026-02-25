#!/bin/bash

echo "Install Dorado"

PKG_NAME="dorado"
PKG_VERSION="1.3.0"

pkg_intall \
  -n "$PKG_NAME" \
  -v "$PKG_VERSION" \
  -u "https://cdn.oxfordnanoportal.com/software/analysis/dorado-${PKG_VERSION}-linux-x64.tar.gz" \
  -t "unpack"

# Download selected Dorado models

DORADO_MODELS="$INSTALL_DIR/dorado/models"

mkdir -p $DORADO_MODELS

module load dorado

dorado download \
    --directory $DORADO_MODELS \
    --model dna_r10.4.1_e8.2_400bps_sup@v4.3.0 \
    --model dna_r10.4.1_e8.2_400bps_sup@v5.0.0 \
    --model dna_r10.4.1_e8.2_400bps_sup@v5.0.0_6mA@v3 \
    --model dna_r10.4.1_e8.2_400bps_sup@v5.0.0_5mCG_5hmCG@v3

# PKG_NAME="dorado"
# export DORADO_VERSION="1.3.0"
#
# # Using the ONT CDN for the precompiled linux-x64 binary
# SOURCE_URL="https://cdn.oxfordnanoportal.com/software/analysis/dorado-${DORADO_VERSION}-linux-x64.tar.gz"
#
# TARGET_DIR="$INSTALL_DIR/$PKG_NAME/$PKG_NAME-$DORADO_VERSION"
# SOURCE_ARCHIVE="$INSTALL_DIR/sources"
#
# # 1. Prepare Environment
# mkdir -p "$SOURCE_ARCHIVE"
# rm -rf /tmp/$TOOL_NAME-build
# mkdir -p /tmp/$TOOL_NAME-build
# cd /tmp/$TOOL_NAME-build
#
# # 2. Download and Archive
# wget -qL "$SOURCE_URL" -O "${TOOL_NAME}-${DORADO_VERSION}-linux-x64.tar.gz"
# cp "${TOOL_NAME}-${DORADO_VERSION}-linux-x64.tar.gz" "$SOURCE_ARCHIVE/"
#
# # 3. Unpack and Install
# # Create target directory and unpack directly into it
# mkdir -p "$TARGET_DIR"
# tar -xzf "${TOOL_NAME}-${DORADO_VERSION}-linux-x64.tar.gz" -C "$TARGET_DIR" --strip-components=1
#
# # 4. Cleanup Build Area
# rm -rf /tmp/$TOOL_NAME-build
#
# # 5. Module generation
# make_lua_module "dorado" "$DORADO_VERSION"
