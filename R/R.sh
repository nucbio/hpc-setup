#!/bin/bash

# Dependencies
module use $INSTALL_DIR/modulefiles
module load libcurl/$LIBCURL_VERSION
module load pcre2/$PCRE2_VERSION
module load libpng/$LIBPNG_VERSION
module load libjpeg/$LIBJPEG_VERSION
module load pandoc/$PANDOC_VERSION
module load cairo/$CAIRO_VERSION
module load harfbuzz/$HARFBUZZ_VERSION
module load fribidi/$FRIBIDI_VERSION
module load freetype/$FREETYPE_VERSION
module load bzip2/$BZIP2_VERSION
module load libwebp/$LIBWEBP_VERSION
module load libvips/$LIBVIPS_VERSION
module load xz/$XZ_VERSION
module load ncurses/$NCURSES_VERSION
module load readline/$READLINE_VERSION
module load java/$JAVA_VERSION

export R_VERSION="4.5.2"
PKG_VERSION=$R_VERSION
PKG_NAME="R"
PKG_SRC_URL="https://cran.r-project.org/src/base/R-4/R-$R_VERSION.tar.gz"
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
