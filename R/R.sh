#!/bin/bash

# Dependencies
module use $INSTALL_DIR/modulefiles
module load libcurl
module load pcre2
module load libpng
module load libjpeg
module load pandoc
module load cairo
module load harfbuzz
module load fribidi
module load freetype
module load bzip2
module load libwebp
module load libvips
module load xz
module load ncurses
module load readline
module load java

export R_VERSION="4.5.2"
PKG_VERSION=$R_VERSION
PKG_NAME="R"
PKG_SRC_URL="https://cran.r-project.org/src/base/R-4/R-$R_VERSION.tar.gz"


# Standard configuration installation
PKG_ARCHIVE="$SOURCES_DIR/${PKG_NAME}-${PKG_VERSION}.tar.gz"

# Set PKG_SRC_DIR, PKG_PREFIX, PKG_BUILD_DIR
set_pkg_dirs  $PKG_NAME $PKG_VERSION
set_build_dir $PKG_NAME $PKG_VERSION

wget -nv "$PKG_SRC_URL" -O "$PKG_ARCHIVE"
tar -xzf "$PKG_ARCHIVE" -C "$PKG_SRC_DIR" --strip-components=1

cd "$PKG_BUILD_DIR"
"$PKG_SRC_DIR/configure" \
    --prefix="$PKG_PREFIX"  \
    --enable-memory-profiling \
    --enable-R-shlib \
    --with-blas \
    --with-lapack \
    --with-libpng \
    --with-jpeglib \
    --with-cairo \
    --with-readline=yes \
    --with-system-tre=no

make -j $(nproc)
make install

# Cleanup Build Area
cd "$REPO_DIR"
rm -rf "$PKG_BUILD_DIR"

# Create Module File
make_lua_module $PKG_NAME $PKG_VERSION
