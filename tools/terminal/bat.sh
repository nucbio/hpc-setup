#!/bin/bash

echo "Install bat"

module purge
module load rust

BAT_VERSION="0.26.1"
# Install ripgrep
cargo install \
  --git https://github.com/sharkdp/bat.git \
  --tag "v$BAT_VERSION" \
  --locked

# Module
module_templater "bat" "$INSTALL_DIR/rust/rust-$RUST_VERSION/cargo/bin"
