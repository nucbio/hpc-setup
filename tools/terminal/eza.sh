#!/bin/bash

echo "Install eza"

module purge
module load rust

# eza - CLI tool
export EZA_VERSION="0.23.4"
# Install eza
cargo install \
  --git https://github.com/eza-community/eza.git \
  --tag "v$EZA_VERSION" \
  --locked

# Module
module_templater "eza" "$INSTALL_DIR/rust/rust-$RUST_VERSION/cargo/bin"
