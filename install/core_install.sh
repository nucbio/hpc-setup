#!/bin/bash

# Dependencies for Python and R
module use $INSTALL_DIR/modulefiles

# No dependencies
# 0. zlib
source $REPO_DIR/core/zlib.sh

# 1. bzip2
source $REPO_DIR/core/bzip2.sh
# 2. pcre2
source $REPO_DIR/core/pcre2.sh
# 3. xz
source $REPO_DIR/core/xz.sh
# 4. libjpeg
source $REPO_DIR/core/libjpeg.sh
# 5. libpng
module load zlib/$ZLIB_VERSION
source $REPO_DIR/core/libpng.sh
# 6. libwebp
source $REPO_DIR/core/libwebp.sh
# 7. pandoc
source $REPO_DIR/core/pandoc.sh
# 8. openssl
source $REPO_DIR/core/openssl.sh
# 9. libcurl
module load openssl/$OPENSSL_VERSION
source $REPO_DIR/core/libcurl.sh
# 10. ncurses
source $REPO_DIR/core/ncurses.sh
# 11. readline (load ncurses)
module load ncurses/$NCURSES_VERSION
source $REPO_DIR/core/readline.sh
# 12. sqlite
source $REPO_DIR/core/sqlite.sh

