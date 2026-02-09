#!/bin/bash

echo "Install Python"
module use $INSTALL_DIR/modulefiles
#module load openssl/$OPENSSL_VERSION
module load python/$PYTHON_VERSION

# 1. freetype (use zlib, bzip2, png, harfbuzz)
echo "Install FreeType"
source $REPO_DIR/core/freetype.sh

# 2. fribidi (load freetype)
echo "Install Freebidi"
module load freetype/$FREETYPE_VERSION
source $REPO_DIR/core/fribidi.sh

# 3. harfbuzz
echo "Install Harfbuzz"
module load fribidi/$FRIBIDI_VERSION
source $REPO_DIR/core/harfbuzz.sh

# 5. glib (load zlib, pcre2, libff)
module load zlib/$ZLIB_VERSION
module load pcre2/$PCRE2_VERSION
module load libff/$LIBFF_VERSION
source $REPO_DIR/core/glib.sh

# 4. cairo (load freetype, fribidi, harfbuzz)
echo "Install Cairo"
module load harfbuzz/$HARFBUZZ_VERSION
module load glib/$GLIB_VERSION
source $REPO_DIR/core/cairo.sh

# 5. libvips
echo "Install Libvips"
module load libjpeg/$LIBJPEG_VERSION
module load libwebp/$LIBWEBP_VERSION
module load libpng/$LIBPNG_VERSION
module load cairo/$CAIRO_VERSION
module load glib/$GLIB_VERSION
source $REPO_DIR/core/libvips.sh

