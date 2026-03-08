#!/bin/bash

echo "Install R"

export R_VERSION="${R_VERSION:-4.5.2}"

# Load dependencies
module use $INSTALL_DIR/modulefiles
module purge
module load libcurl
module load pcre2
module load libpng
module load libjpeg
module load libtiff
module load pandoc
module load cairo
module load harfbuzz
module load fribidi
module load freetype2
module load bzip2
module load libwebp
module load libvips
module load xz
module load ncurses
module load readline
module load java
module load pkgconf
module load zlib
module load magick
module load fontconfig

# Check if X11 libraries are available for R installation
if pkg-config --exists x11 xt xext xmu 2>/dev/null; then
    echo "X11 support for R is enabled."
    X_OPT="--with-x=yes"
else
    echo "X11 support for R is disabled."
    X_OPT="--with-x=no"
fi

# Standard config installation
pkg_install -n "R" \
            -v "$R_VERSION" \
            -u "https://cran.r-project.org/src/base/R-4/R-${R_VERSION}.tar.gz" \
            -o "--enable-memory-profiling \
--enable-R-shlib \
--with-blas \
--with-lapack \
--with-libpng \
--with-jpeglib \
--with-libtiff \
--with-cairo \
--with-readline=yes \
--with-system-tre=no \
$X_OPT" 

# new added: --with-libtiff --with-libxml2 --with-libcurl --with-openssl --with-zlib --with-bzlib --with-lzma
# removed as unrecognized:
# --with-libxml2 \
# --with-libcurl \
# --with-openssl \
# --with-zlib \
# --with-bzlib \
# --with-lzma \
