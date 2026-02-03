# Variables
TOOL_NAME="xz"
XZ_VERSION="5.8.2"
SOURCE_URL="https://github.com/tukaani-project/xz/releases/download/v${XZ_VERSION}/xz-${XZ_VERSION}.tar.xz"
TARGET_DIR="$INSTALL_DIR/xz"

mkdir -p $TARGET_DIR
cd $TARGET_DIR
# Download and Unpack
wget -q "$SOURCE_URL" -O xz-$XZ_VERSION.tar.xz
tar -xJf xz-$XZ_VERSION.tar.xz
cd xz-${XZ_VERSION}

# Configure and Install
./configure --prefix="$TARGET_DIR/$TOOL_NAME-$XZ_VERSION"

make -j$(nproc)
make install

# Modules
make_lua_module "xz" "$XZ_VERSION"
