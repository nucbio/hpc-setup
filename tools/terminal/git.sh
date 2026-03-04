#!/bin/bash

echo "Install git"

module load libcurl
module load openssl

export GIT_VERSION="2.53.0"

PKG_NAME="git"
PKG_VERSION="$GIT_VERSION"
PKG_URL="https://mirrors.edge.kernel.org/pub/software/scm/git/git-$GIT_VERSION.tar.xz"

# Derive Archive Name
ARCHIVE_NAME="${PKG_URL##*/}"
PKG_ARCHIVE="$SOURCES_DIR/$ARCHIVE_NAME"
  
# Download & Extract
echo "Downloading $PKG_NAME..."
if wget -nv -c \
          --tries=10 \
          --read-timeout=30 \
          --waitretry=5 \
          "$PKG_URL" -O "$PKG_ARCHIVE"; then
  echo "Downloaded $ARCHIVE_NAME"
else
  echo "ERROR: Failed to download $PKG_NAME."
  echo "Check if the URL is valid: $PKG_URL"
  return 1
fi

set_pkg_dirs "$PKG_NAME" "$PKG_VERSION"
mkdir -p "$PKG_SRC_DIR"

tar -xf "$PKG_ARCHIVE" -C "$PKG_SRC_DIR" --strip-components=1

cd "$PKG_SRC_DIR" || return
./configure --prefix="$PREFIX" --without-tcltk

make -j "$(nproc)" \
  NO_GITWEB=YesPlease \
  NO_PERL=YesPlease \
  NO_PYTHON=YesPlease \
  NO_EXPAT=YesPlease

make install NO_INSTALL_GITWEB=YesPlease

make_lua_module "$PKG_NAME" "$PKG_VERSION"

