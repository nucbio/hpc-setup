#!/bin/bash

echo "Install fd"

module purge
module load rust

## fdfind - modern cd
export FD_VERSION="10.3.0"
# Install fdfind
cargo install \
  --git https://github.com/sharkdp/fd.git \
  --tag "v$FD_VERSION" \
  --locked

# Module
module_templater "fd" "$INSTALL_DIR/rust/rust-$RUST_VERSION/cargo/bin"
