echo "Install Cairo"

# Variables
TOOL_NAME="cairo"
export CAIRO_VERSION="1.18.4"
SOURCE_URL="https://cairographics.org/releases/cairo-${CAIRO_VERSION}.tar.xz"
TARGET_DIR="$INSTALL_DIR/$TOOL_NAME/$TOOL_NAME-$CAIRO_VERSION"
SOURCE_ARCHIVE="$INSTALL_DIR/sources"

# Load dependencies
module use $INSTALL_DIR/modulefiles
module load python/$PYTHON_VERSION  # Provides meson and ninja
# Note: Ensure freetype and pixman modules are loaded here if they are dependencies

# 1. Prepare Environment
mkdir -p "$SOURCE_ARCHIVE"
rm -rf /tmp/$TOOL_NAME-build
mkdir -p /tmp/$TOOL_NAME-build
cd /tmp/$TOOL_NAME-build

# 2. Download and Archive
# Using -L to follow potential redirects for cairographics.org
wget -qL "$SOURCE_URL" -O "${TOOL_NAME}-${CAIRO_VERSION}.tar.xz"
cp "${TOOL_NAME}-${CAIRO_VERSION}.tar.xz" "$SOURCE_ARCHIVE/"

# 3. Unpack
tar -xJf "${TOOL_NAME}-${CAIRO_VERSION}.tar.xz"
cd "cairo-${CAIRO_VERSION}"

# 4. Configure with Meson
# Standardized to use 'build_dir' and the release buildtype
meson setup build_dir \
    --prefix="$TARGET_DIR" \
    --buildtype=release \
    -Dtests=disabled

# 5. Build and Install
meson compile -C build_dir
meson install -C build_dir

# 6. Cleanup Build Area
rm -rf /tmp/$TOOL_NAME-build

# 7. Module generation
make_lua_module "cairo" "$CAIRO_VERSION"
