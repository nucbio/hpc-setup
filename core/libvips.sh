echo "Install libvips"

# Variables
PKG_NAME="libvips"
export LIBVIPS_VERSION="8.18.0"
PKG_SRC_URL="https://github.com/libvips/libvips/releases/download/v$LIBVIPS_VERSION/vips-$LIBVIPS_VERSION.tar.xz"
PKG_PREFIX="$INSTALL_DIR/$PKG_NAME/$PKG_NAME-$LIBVIPS_VERSION"
PKG_ARCHIVE="$INSTALL_DIR/sources"

# Recommended: load cairo, harfbuzz, and freetype modules here
# 1. Prepare Environment
mkdir -p "$PKG_ARCHIVE"
rm -rf /tmp/$PKG_NAME-build
mkdir -p /tmp/$PKG_NAME-build
cd /tmp/$PKG_NAME-build
# 2. Download and Archive
# Note: Using the official release tarball is preferred over the source-code-only zip
wget -qL "$PKG_SRC_URL" -O "${PKG_NAME}-${LIBVIPS_VERSION}.tar.xz"

cp "${PKG_NAME}-${LIBVIPS_VERSION}.tar.xz" "$PKG_ARCHIVE/"
# 3. Unpack
tar -xJf  "${PKG_NAME}-${LIBVIPS_VERSION}.tar.xz"
cd "vips-${LIBVIPS_VERSION}"

# FIX: distutils is needed but depricated 
export SETUPTOOLS_USE_DISTUTILS=local
meson setup build_dir \
  --prefix="$PKG_PREFIX" \
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
rm -rf /tmp/$PKG_NAME-build

# 7. Module generation
make_lua_module "libvips" "$LIBVIPS_VERSION"
