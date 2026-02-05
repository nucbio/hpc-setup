echo "Install HarfBuzz"

# Variables
TOOL_NAME="harfbuzz"
export HARFBUZZ_VERSION="12.2.0"
SOURCE_URL="https://github.com/harfbuzz/harfbuzz/releases/download/${HARFBUZZ_VERSION}/harfbuzz-${HARFBUZZ_VERSION}.tar.xz"
TARGET_DIR="$INSTALL_DIR/$TOOL_NAME/$TOOL_NAME-$HARFBUZZ_VERSION"
SOURCE_ARCHIVE="$INSTALL_DIR/sources"

# Load dependencies
module use $INSTALL_DIR/modulefiles
module load python/$PYTHON_VERSION  # Provides meson and ninja
# Note: HarfBuzz often benefits from loading freetype and glib modules here

# 1. Prepare Environment
mkdir -p "$SOURCE_ARCHIVE"
rm -rf /tmp/$TOOL_NAME-build
mkdir -p /tmp/$TOOL_NAME-build
cd /tmp/$TOOL_NAME-build

# 2. Download and Archive
wget -qL "$SOURCE_URL" -O "${TOOL_NAME}-${HARFBUZZ_VERSION}.tar.xz"
cp "${TOOL_NAME}-${HARFBUZZ_VERSION}.tar.xz" "$SOURCE_ARCHIVE/"

# 3. Unpack
tar -xJf "${TOOL_NAME}-${HARFBUZZ_VERSION}.tar.xz"
cd "harfbuzz-${HARFBUZZ_VERSION}"

# 4. Configure with Meson
# Added -Dtests=disabled and -Ddocs=disabled to streamline the build
meson setup build_dir \
    --prefix="$TARGET_DIR" \
    --buildtype=release \
    -Dtests=disabled \
    -Ddocs=disabled \
    -Dintrospection=disabled

# 5. Build and Install
meson compile -C build_dir
meson install -C build_dir

# 6. Cleanup Build Area
rm -rf /tmp/$TOOL_NAME-build

# 7. Module generation
make_lua_module "harfbuzz" "$HARFBUZZ_VERSION"
