#!/bin/bash

echo "Install ripgrep"

module purge
module load rust

## ripgrep - modern grep
RIPGREP_VERSION=$(pkg_version "ripgrep")
# Install ripgrep
cargo install \
  --git "$(pkg_url ripgrep)" ripgrep\
  --tag "$RIPGREP_VERSION" \
  --locked

# Module
module_templater "ripgrep" "$INSTALL_DIR/rust/rust-$RUST_VERSION/cargo/bin"
