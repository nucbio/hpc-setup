# Variables
TOOL_NAME="xz"
XZ_VERSION="5.8.2"
SOURCE_URL="https://github.com/tukaani-project/xz/releases/download/v${XZ_VERSION}/xz-${XZ_VERSION}.tar.xz"
TARGET_DIR="$INSTALL_DIR/xz/$TOOL_VERSION"

# Download and Unpack
wget -q "$SOURCE_URL" -O xz.tar.xz
tar -xJf xz.tar.xz
cd xz-${XZ_VERSION}

# Configure and Install
./configure --prefix="$TARGET_DIR"

make -j$(nproc)
make install

# Clean up
cd .. && rm -rf xz-${XZ_VERSION} xz.tar.gz

# Modules
make_lua_module "xz" "$XZ_VERSION"
