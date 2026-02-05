echo "Install libvips"

# Variables
TOOL_NAME="libvips"
export LIBVIPS_VERSION="8.18.0"
SOURCE_URL="https://github.com/libvips/libvips/releases/download/v$LIBVIPS_VERSION/vips-$LIBVIPS_VERSION.tar.xz"
TARGET_DIR="$INSTALL_DIR/$TOOL_NAME/$TOOL_NAME-$LIBVIPS_VERSION"
SOURCE_ARCHIVE="$INSTALL_DIR/sources"

# Recommended: load cairo, harfbuzz, and freetype modules here
# 1. Prepare Environment
mkdir -p "$SOURCE_ARCHIVE"
rm -rf /tmp/$TOOL_NAME-build
mkdir -p /tmp/$TOOL_NAME-build
cd /tmp/$TOOL_NAME-build
# 2. Download and Archive
# Note: Using the official release tarball is preferred over the source-code-only zip
wget -qL "$SOURCE_URL" -O "${TOOL_NAME}-${LIBVIPS_VERSION}.tar.xz"

cp "${TOOL_NAME}-${LIBVIPS_VERSION}.tar.xz" "$SOURCE_ARCHIVE/"
# 3. Unpack
tar -xJf  "${TOOL_NAME}-${LIBVIPS_VERSION}.tar.xz"
cd "vips-${LIBVIPS_VERSION}"

# FIX: distutils is needed but depricated 
export SETUPTOOLS_USE_DISTUTILS=local
meson setup build_dir \
  --prefix="$TARGET_DIR" \
  --buildtype=release \
  -Dintrospection=disabled \
  -Dmatio=disabled \
  -Dcfitsio=disabled \
  -Dpdfium=disabled \
  -Dmagick=disabled

# 5. Build and Install
meson compile -C build_dir
meson install -C build_dir

# 6. Cleanup Build Area
rm -rf /tmp/$TOOL_NAME-build

# 7. Module generation
make_lua_module "libvips" "$LIBVIPS_VERSION"
