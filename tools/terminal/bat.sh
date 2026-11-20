#!/bin/bash

echo "Install bat"

module purge
module load rust

BAT_VERSION=$(pkg_version "bat")
# Install ripgrep
cargo install \
  --git "$(pkg_url bat)" \
  --tag "v$BAT_VERSION" \
  --locked

# Module
module_templater "bat" "$INSTALL_DIR/rust/rust-$RUST_VERSION/cargo/bin"
