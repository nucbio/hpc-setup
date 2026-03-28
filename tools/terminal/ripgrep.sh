#!/bin/bash

echo "Install ripgrep"

module purge
module load rust

## ripgrep - modern grep
export RIPGREP_VERSION="15.1.0"
# Install ripgrep
cargo install \
  --git https://github.com/BurntSushi/ripgrep.git ripgrep\
  --tag "$RIPGREP_VERSION" \
  --locked

# Module
module_templater "ripgrep" "$INSTALL_DIR/rust/rust-$RUST_VERSION/cargo/bin"
