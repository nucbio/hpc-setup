# Variables
# Variables
TOOL_NAME="xz"
XZ_VERSION="5.8.2"
SOURCE_URL="https://github.com/tukaani-project/xz/releases/download/v${XZ_VERSION}/xz-${XZ_VERSION}.tar.xz"
TARGET_DIR="$INSTALL_DIR/$TOOL_NAME/$TOOL_NAME-$XZ_VERSION"
SOURCE_ARCHIVE="$INSTALL_DIR/sources"

# 1. Prepare Environment
mkdir -p "$SOURCE_ARCHIVE"
rm -rf /tmp/xz-build
mkdir -p /tmp/xz-build
cd /tmp/xz-build

# 2. Download and Archive
wget -q "$SOURCE_URL" -O "xz-${XZ_VERSION}.tar.xz"
cp "xz-${XZ_VERSION}.tar.xz" "$SOURCE_ARCHIVE/"

# 3. Unpack and Build
tar -xJf "xz-${XZ_VERSION}.tar.xz"
cd "xz-${XZ_VERSION}"

# We install directly to $TARGET_DIR to keep paths clean
./configure --prefix="$TARGET_DIR"

make -j$(nproc)
make install

# 4. Cleanup Build Area
rm -rf /tmp/xz-build

# 5. Module generation
make_lua_module "xz" "$XZ_VERSION"
