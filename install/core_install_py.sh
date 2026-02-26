#!/bin/bash

module use $INSTALL_DIR/modulefiles
module load python

# 1. glib
source $REPO_DIR/core/glib.sh

# 2. freetype
source $REPO_DIR/core/freetype.sh

# 3. fontconfig
source $REPO_DIR/core/fontconfig.sh

# 4. imagemagic
source $REPO_DIR/core/imagemagick.sh

# 5. fribidi
module load freetype
source $REPO_DIR/core/fribidi.sh

# 6. harfbuzz
module load fribidi
module load glib
source $REPO_DIR/core/harfbuzz.sh

# 7. cairo
module load freetype
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
module load imagemagick
source $REPO_DIR/core/libvips.sh

