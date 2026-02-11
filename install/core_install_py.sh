#!/bin/bash

module use $INSTALL_DIR/modulefiles
#module load openssl/$OPENSSL_VERSION
module load python

# 1. glib
source $REPO_DIR/core/glib.sh

# 2. freetype
source $REPO_DIR/core/freetype.sh

# 3. fribidi
module load freetype
source $REPO_DIR/core/fribidi.sh

# 4. harfbuzz
module load fribidi
module load glib
source $REPO_DIR/core/harfbuzz.sh

# 5. cairo
module load freetype
module load fribidi
module load harfbuzz
source $REPO_DIR/core/cairo.sh

# 6. libvips
module load libjpeg
module load libwebp
module load libpng
module load cairo
module load glib
module load libexpat
source $REPO_DIR/core/libvips.sh

