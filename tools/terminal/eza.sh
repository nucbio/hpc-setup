#!/bin/bash

echo "Install eza"

module purge
module load rust

# eza - CLI tool
EZA_VERSION=$(pkg_version "eza")
# Install eza
cargo install \
  --git "$(pkg_url eza)" \
  --tag "v$EZA_VERSION" \
  --locked

# Module
module_templater "eza" "$INSTALL_DIR/rust/rust-$RUST_VERSION/cargo/bin"
