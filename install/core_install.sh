#!/bin/bash

# Dependencies for Python and R
module use $INSTALL_DIR/modulefiles

# No dependencies
# 1. zlib
source $REPO_DIR/core/zlib.sh
# 2. bzip2
source $REPO_DIR/core/bzip2.sh
# 3. pcre2
source $REPO_DIR/core/pcre2.sh
# 4. xz
source $REPO_DIR/core/xz.sh
# 5. libjpeg
source $REPO_DIR/core/libjpeg.sh
# 6. libpng
module load zlib/$ZLIB_VERSION
source $REPO_DIR/core/libpng.sh
# 7. libwebp
source $REPO_DIR/core/libwebp.sh
# # 8. pandoc
# source $REPO_DIR/core/pandoc.sh
# # 9. openssl
# source $REPO_DIR/core/openssl.sh
# # 10. libcurl
# module load openssl/$OPENSSL_VERSION
# source $REPO_DIR/core/libcurl.sh
# # 11. ncurses
# source $REPO_DIR/core/ncurses.sh
# # 12. readline (load ncurses)
# module load ncurses/$NCURSES_VERSION
# source $REPO_DIR/core/readline.sh
# # 13. sqlite
# source $REPO_DIR/core/sqlite.sh

