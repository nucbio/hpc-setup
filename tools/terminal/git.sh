#!/bin/bash

echo "Install git"

module purge
module load zlib
module load xz
module load pcre2
module load libcurl
module load openssl
module load gettext
module load libexpat
# Git >= 2.52 builds a Rust component (libgitcore.a) by default: needs cargo
module load rust

PKG_NAME="git"
PKG_VERSION=$(pkg_version "$PKG_NAME")
PKG_URL=$(pkg_url "$PKG_NAME")
export GIT_VERSION="$PKG_VERSION"

# Already installed by a previous run? (see functions/stamp.sh)
if skip_if_installed "$PKG_NAME" "$PKG_VERSION"; then
  return 0
fi

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

# PKG_SRC_DIR and PKG_PREFIX
set_pkg_dirs "$PKG_NAME" "$PKG_VERSION"
mkdir -p "$PKG_SRC_DIR"

tar -xf "$PKG_ARCHIVE" -C "$PKG_SRC_DIR" --strip-components=1

cd "$PKG_SRC_DIR" || return
./configure --prefix="$PKG_PREFIX" 

make -j "$(nproc)"
make install

module_templater "$PKG_NAME"

