#!/bin/bash

echo "Install DuckDB"

export DUCKDB_VERSION="1.1.3"

PKG_VERSION=$DUCKDB_VERSION
PKG_NAME="duckdb"
export PANDOC_VERSION=$PKG_VERSION
PKG_SRC_URL="https://github.com/duckdb/duckdb/releases/download/v${DUCKDB_VERSION}/duckdb_cli-linux-amd64.zip"
PKG_ARCHIVE="$SOURCES_DIR/$PKG_NAME-$PKG_VERSION.zip"

# Set PKG_SRC_DIR, PKG_PREFIX
set_pkg_dirs  $PKG_NAME $PKG_VERSION

# Download to sources directory
wget -nv "$PKG_SRC_URL" -O "$PKG_ARCHIVE"
tar -xzf "$PKG_ARCHIVE" -C "$PKG_PREFIX" --strip-components=1

# Modules lua file
make_lua_module "$PKG_NAME" "$PANDOC_VERSION" "$PKG_PREFIX"
mkdir -p "$PKG_PREFIX/bin"
unzip -q "$PKG_ARCHIVE" -d "$PKG_PREFIX/bin"

# Create Module File
make_lua_module $PKG_NAME $PKG_VERSION
