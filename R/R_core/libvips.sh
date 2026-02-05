echo "Install libvips"

# Variables
TOOL_NAME="libvips"
export LIBVIPS_VERSION="8.17.3"
SOURCE_URL="https://github.com/libvips/libvips/releases/download/v${LIBVIPS_VERSION}/vips-${LIBVIPS_VERSION}.tar.gz"
TARGET_DIR="$INSTALL_DIR/$TOOL_NAME/$TOOL_NAME-$LIBVIPS_VERSION"
SOURCE_ARCHIVE="$INSTALL_DIR/sources"

# Load dependencies
module use $INSTALL_DIR/modulefiles
module load python/$PYTHON_VERSION  # Provides meson and ninja
# Recommended: load cairo, harfbuzz, and freetype modules here
echo "TEST FLAG 1"
# 1. Prepare Environment
mkdir -p "$SOURCE_ARCHIVE"
rm -rf /tmp/$TOOL_NAME-build
mkdir -p /tmp/$TOOL_NAME-build
cd /tmp/$TOOL_NAME-build
echo "TEST FLAG 2"
# 2. Download and Archive
# Note: Using the official release tarball is preferred over the source-code-only zip
#wget -qL "$SOURCE_URL" -O "${TOOL_NAME}-${LIBVIPS_VERSION}.tar.gz"
wget -L "$SOURCE_URL" -O "${TOOL_NAME}-${LIBVIPS_VERSION}.tar.gz" || {
    echo "wget failed with exit code: $?"
    ls -lh "${TOOL_NAME}-${LIBVIPS_VERSION}.tar.gz" 2>/dev/null || echo "File not created"
    exit 1
}

cp "${TOOL_NAME}-${LIBVIPS_VERSION}.tar.gz" "$SOURCE_ARCHIVE/"
echo "TEST FLAG 3"
# 3. Unpack
tar -xzf "${TOOL_NAME}-${LIBVIPS_VERSION}.tar.gz"
cd "vips-${LIBVIPS_VERSION}"
echo "TEST FLAG 4"
# 4. Configure with Meson
meson setup build_dir \
    --prefix="$TARGET_DIR" \
    --buildtype=release \
    -Dgtk_doc=disabled \
    -Dintrospection=disabled \
    -Dexamples=false

# 5. Build and Install
meson compile -C build_dir
meson install -C build_dir

# 6. Cleanup Build Area
rm -rf /tmp/$TOOL_NAME-build

# 7. Module generation
make_lua_module "libvips" "$LIBVIPS_VERSION"
