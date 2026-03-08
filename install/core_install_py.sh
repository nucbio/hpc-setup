#!/bin/bash

module use $INSTALL_DIR/modulefiles
module load python

# 1. glib
source $REPO_DIR/core/glib.sh

# 2. freetype2
source $REPO_DIR/core/freetype2.sh

# 3. fontconfig
source $REPO_DIR/core/fontconfig.sh

# 4. imagemagic
source $REPO_DIR/core/magick.sh

# 5. fribidi
module load freetype2
source $REPO_DIR/core/fribidi.sh

# 6. harfbuzz
module load fribidi
module load glib
source $REPO_DIR/core/harfbuzz.sh

# 7. cairo
module load freetype2
module load fribidi
module load harfbuzz
source $REPO_DIR/core/cairo.sh

# 8. libvips
module load libjpeg
module load libwebp
module load libpng
module load cairo
module load glib
module load libexpat
module load magick
source $REPO_DIR/core/libvips.sh

