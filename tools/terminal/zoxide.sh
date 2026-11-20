#!/bin/bash

echo "Install zoxide"

module purge
module load rust

## zoxide - modern cd
ZOXIDE_VERSION=$(pkg_version "zoxide")
# Install ripgrep
cargo install \
  --git "$(pkg_url zoxide)" \
  --tag "v$ZOXIDE_VERSION" \
  --locked

# Module
module_templater "zoxide" "$INSTALL_DIR/rust/rust-$RUST_VERSION/cargo/bin"
