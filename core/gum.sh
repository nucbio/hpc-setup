#!/bin/bash

export GUM_VERSION="0.17.0"
GUM_BIN="$INSTALL_DIR/gum"
ARCH="x86_64"
# ARCH="aarch64"                          # ARM e.g. Graviton, Ampere, Apple M-series in VM, some new clusters

cd /tmp

# Download binary tarball
TARBALL="gum_${VERSION}_Linux_${ARCH}.tar.gz"
URL="https://github.com/charmbracelet/gum/releases/download/v${VERSION}/${TARBALL}"

curl -fsSL --retry 3 --retry-delay 2 "$URL" -o gum.tar.gz || {
    echo "Download failed. Check version & architecture." >&2
    exit 1
}

tar -xzf gum.tar.gz gum

install -m 0755 gum "$GUM_BIN"
rm -f gum gum.tar.gz checksums.txt

