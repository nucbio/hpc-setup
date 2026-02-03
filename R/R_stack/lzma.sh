# Variables
TOOL_NAME="xz"
TOOL_VERSION="5.4.4"
LZMA_VERSION="5.4.4"
SOURCE_URL="https://github.com/tukaani-project/xz/releases/download/v${TOOL_VERSION}/xz-${TOOL_VERSION}.tar.gz"
TARGET_DIR="$INSTALL_DIR/xz/$TOOL_VERSION"

# Download and Unpack
wget -q "$SOURCE_URL" -O xz.tar.gz
tar -xzf xz.tar.gz
cd xz-${TOOL_VERSION}

# Configure and Install
./configure --prefix="$TARGET_DIR"

make -j$(nproc)
make install

# Clean up
cd .. && rm -rf xz-${TOOL_VERSION} xz.tar.gz

# Modules
make_lua_module "lzma" "$LZMA_VERSION"
