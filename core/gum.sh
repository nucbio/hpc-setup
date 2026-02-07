#!/bin/bash

export GUM_VERSION="0.17.0"
GUM_BIN="$INSTALL_DIR/gum"
ARCH="x86_64"
# ARCH="aarch64"                          # ARM e.g. Graviton, Ampere, Apple M-series in VM, some new clusters

cd /tmp

# Download binary tarball
TARBALL="gum_${GUM_VERSION}_Linux_${ARCH}.tar.gz"
URL="https://github.com/charmbracelet/gum/releases/download/v0.17.0/gum_0.17.0_Linux_x86_64.tar.gz"

wget "$URL" -O gum.tar.gz

tar -xzf gum.tar.gz
cd gum
install -m 0755 gum "$GUM_BIN"
#rm -f gum gum.tar.gz

