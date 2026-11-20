#!/bin/bash

echo "Install fd"

module purge
module load rust

## fdfind - modern cd
FD_VERSION=$(pkg_version "fd")
# Install fdfind
cargo install \
  --git "$(pkg_url fd)" \
  --tag "v$FD_VERSION" \
  --locked

# Module
module_templater "fd" "$INSTALL_DIR/rust/rust-$RUST_VERSION/cargo/bin"
