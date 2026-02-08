# Variables
# Variables
PKG_NAME="xz"
export XZ_VERSION="5.8.2"
PKG_SRC_URL="https://github.com/tukaani-project/xz/releases/download/v${XZ_VERSION}/xz-${XZ_VERSION}.tar.xz"
PKG_PREFIX="$INSTALL_DIR/$PKG_NAME/$PKG_NAME-$XZ_VERSION"
PKG_ARCHIVE="$INSTALL_DIR/sources"

# 1. Prepare Environment
mkdir -p "$PKG_ARCHIVE"
rm -rf /tmp/xz-build
mkdir -p /tmp/xz-build
cd /tmp/xz-build

# 2. Download and Archive
wget -q "$PKG_SRC_URL" -O "xz-${XZ_VERSION}.tar.xz"
cp "xz-${XZ_VERSION}.tar.xz" "$PKG_ARCHIVE/"

# 3. Unpack and Build
tar -xJf "xz-${XZ_VERSION}.tar.xz"
cd "xz-${XZ_VERSION}"

# We install directly to $PKG_PREFIX to keep paths clean
./configure --prefix="$PKG_PREFIX"

make -j$(nproc)
make install

# 4. Cleanup Build Area
rm -rf /tmp/xz-build

# 5. Module generation
make_lua_module "xz" "$XZ_VERSION"
