#!/bin/bash

echo "Install Python"
module use $INSTALL_DIR/modulefiles
#module load openssl/$OPENSSL_VERSION
module load python

# 1. glib
source $REPO_DIR/core/glib.sh

# 2. freetype (use zlib, bzip2, png, harfbuzz)
echo "Install FreeType"
source $REPO_DIR/core/freetype.sh

# 3. fribidi (load freetype)
echo "Install Freebidi"
module load freetype
source $REPO_DIR/core/fribidi.sh

# 4. harfbuzz
echo "Install Harfbuzz"
module load fribidi
module load glib
source $REPO_DIR/core/harfbuzz.sh

# 5. cairo (load freetype, fribidi, harfbuzz)
echo "Install Cairo"
module load harfbuzz
source $REPO_DIR/core/cairo.sh

# 6. libvips
echo "Install Libvips"
module load libjpeg
module load libwebp
module load libpng
module load cairo
module load glib
source $REPO_DIR/core/libvips.sh

