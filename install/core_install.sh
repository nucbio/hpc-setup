#!/bin/bash

# Dependencies for Python and R
module use $INSTALL_DIR/modulefiles


# 1. zlib
source $REPO_DIR/core/zlib.sh
# 2. pkgconfig
source $REPO_DIR/core/pkgconf.sh
# 3. libffi
source $REPO_DIR/core/libffi.sh
# 4. bzip2
source $REPO_DIR/core/bzip2.sh
# 5. pcre2
source $REPO_DIR/core/pcre2.sh
# 6. xz
source $REPO_DIR/core/xz.sh
# 7. libtiff
source $REPO_DIR/core/libtiff.sh
# 8. libjpeg
source $REPO_DIR/core/libjpeg.sh
# 9. libpng
module load zlib
source $REPO_DIR/core/libpng.sh
# 10. libwebp
source $REPO_DIR/core/libwebp.sh
# 11. pandoc
source $REPO_DIR/core/pandoc.sh
# 12. openssl
source $REPO_DIR/core/openssl.sh
# 13. libcurl
module load openssl
source $REPO_DIR/core/libcurl.sh
# 14. ncurses
source $REPO_DIR/core/ncurses.sh
# 15. readline
module load ncurses
source $REPO_DIR/core/readline.sh
# 16. gettext
source $REPO_DIR/core/gettext.sh
# 17. sqlite3
source $REPO_DIR/core/sqlite3.sh
# 18. libexpat
source $REPO_DIR/core/libexpat.sh
# 19. gperf
source $REPO_DIR/core/gperf.sh
# 20. libgit2 (for R gert -> usethis -> devtools)
module load openssl zlib pcre2
source $REPO_DIR/core/libgit2.sh
# 21. hdf5 (for h5py: MACS3 -> anndata, pod5 -> vbz_h5py_plugin)
module load zlib
source $REPO_DIR/core/hdf5.sh
