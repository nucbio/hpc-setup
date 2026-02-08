echo "Install Cairo"

# Variables
PKG_NAME="cairo"
export CAIRO_VERSION="1.18.4"
PKG_SRC_URL="https://cairographics.org/releases/cairo-${CAIRO_VERSION}.tar.xz"
PKG_PREFIX="$INSTALL_DIR/$PKG_NAME/$PKG_NAME-$CAIRO_VERSION"
PKG_BUILD_DIR="${BUILD_BASE}/${PKG_NAME}-${PKG_VERSION}-build-$$"

# Load dependencies
module use $INSTALL_DIR/modulefiles
module load python/$PYTHON_VERSION  # Provides meson and ninja
# Note: Ensure freetype and pixman modules are loaded here if they are dependencies

# Prepare build
rm -rf /tmp/$PKG_NAME-build
mkdir -p /tmp/$PKG_NAME-build
cd /tmp/$PKG_NAME-build

# 2. Download and Archive
wget -qL "$PKG_SRC_URL" -O "${PKG_NAME}-${CAIRO_VERSION}.tar.xz"
cp "${PKG_NAME}-${CAIRO_VERSION}.tar.xz" "$SOURCES_DIR/"

# 3. Unpack
tar -xJf "${PKG_NAME}-${CAIRO_VERSION}.tar.xz"
cd "cairo-${CAIRO_VERSION}"

# 4. Configure with Meson
# Standardized to use 'build_dir' and the release buildtype
meson setup build_dir \
    --prefix="$PKG_PREFIX" \
    --buildtype=release \
    -Dtests=disabled

# 5. Build and Install
meson compile -C build_dir
meson install -C build_dir

# 6. Cleanup Build Area
cd $REPO_DIR
rm -rf /tmp/$PKG_NAME-build

# 7. Module generation
make_lua_module "cairo" "$CAIRO_VERSION"
