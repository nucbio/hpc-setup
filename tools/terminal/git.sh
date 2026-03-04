#!/bin/bash

echo "Install git"

export GIT_VERSION="2.53.0"

pkg_install \
  -n "git" \
  -v "GIT_VERSION" \
  -u "https://mirrors.edge.kernel.org/pub/software/scm/git/git-$GIT_VERSION.tar.xz"

# PKG_NAME="git"
# PKG_VERSION="$GIT_VERSION"
# PKG_URL="https://mirrors.edge.kernel.org/pub/software/scm/git/git-$GIT_VERSION.tar.xz"
#
# # Derive Archive Name
# ARCHIVE_NAME="${PKG_URL##*/}"
# PKG_ARCHIVE="$SOURCES_DIR/$ARCHIVE_NAME"
#   
# # Download & Extract
# echo "Downloading $PKG_NAME..."
# if wget -nv -c \
#           --tries=10 \
#           --read-timeout=30 \
#           --waitretry=5 \
#           "$PKG_URL" -O "$PKG_ARCHIVE"; then
#   echo "Downloaded $ARCHIVE_NAME"
# else
#   echo "ERROR: Failed to download $PKG_NAME."
#   echo "Check if the URL is valid: $PKG_URL"
#   return 1
# fi
#
# set_pkg_dirs "$PKG_NAME" "$PKG_VERSION"
# mkdir -p "$PKG_SRC_DIR"
#
# tar -xf "$PKG_ARCHIVE" -C "$PKG_SRC_DIR" --strip-components=1
#
# cd "$PKG_SRC_DIR" || return
#
# ./configure --prefix="$PREFIX"
# make -j$(nproc)
# make install
#
# make_lua_module "$PKG_NAME" "$PKG_VERSION"

# cd git-2.8.0
# make configure
# ./configure --prefix=/usr
# make all doc info
# sudo make install install-doc install-html install-info
