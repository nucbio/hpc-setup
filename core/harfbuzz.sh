echo "Install HarfBuzz"

# Variables
PKG_NAME="harfbuzz"
export HARFBUZZ_VERSION="12.2.0"
PKG_SRC_URL="https://github.com/harfbuzz/harfbuzz/releases/download/${HARFBUZZ_VERSION}/harfbuzz-${HARFBUZZ_VERSION}.tar.xz"
PKG_PREFIX="$INSTALL_DIR/$PKG_NAME/$PKG_NAME-$HARFBUZZ_VERSION"
PKG_ARCHIVE="$INSTALL_DIR/sources"

# Load dependencies
module use $INSTALL_DIR/modulefiles
module load python/$PYTHON_VERSION  # Provides meson and ninja
# Note: HarfBuzz often benefits from loading freetype and glib modules here

# 1. Prepare Environment
mkdir -p "$PKG_ARCHIVE"
rm -rf /tmp/$PKG_NAME-build
mkdir -p /tmp/$PKG_NAME-build
cd /tmp/$PKG_NAME-build

# 2. Download and Archive
wget -qL "$PKG_SRC_URL" -O "${PKG_NAME}-${HARFBUZZ_VERSION}.tar.xz"
cp "${PKG_NAME}-${HARFBUZZ_VERSION}.tar.xz" "$PKG_ARCHIVE/"

# 3. Unpack
tar -xJf "${PKG_NAME}-${HARFBUZZ_VERSION}.tar.xz"
cd "harfbuzz-${HARFBUZZ_VERSION}"

# 4. Configure with Meson
# Added -Dtests=disabled and -Ddocs=disabled to streamline the build
meson setup build_dir \
    --prefix="$PKG_PREFIX" \
    --buildtype=release \
    -Dtests=disabled \
    -Ddocs=disabled \
    -Dintrospection=disabled

# 5. Build and Install
meson compile -C build_dir
meson install -C build_dir

# 6. Cleanup Build Area
rm -rf /tmp/$PKG_NAME-build

# 7. Module generation
make_lua_module "harfbuzz" "$HARFBUZZ_VERSION"
