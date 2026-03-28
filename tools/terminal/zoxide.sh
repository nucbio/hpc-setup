#!/bin/bash

echo "Install zoxide"

module purge
module load rust

## zoxide - modern cd
export ZOXIDE_VERSION="0.9.7"
# Install ripgrep
cargo install \
  --git https://github.com/ajeetdsouza/zoxide.git \
  --tag "v$ZOXIDE_VERSION" \
  --locked

# Module
module_templater "zoxide" "$INSTALL_DIR/rust/rust-$RUST_VERSION/cargo/bin"
