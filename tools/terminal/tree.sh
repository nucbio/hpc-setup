#!/bin/bash

# tree - CLI tool
export TREE_VERSION="1.3.0"
# Install eza
cargo install \
  --git https://github.com/peteretelej/tree.git \
  --tag "v$TREE_VERSION" \
  --locked

# Module
make_lua_module "bat" "$TREE_VERSION" "$INSTALL_DIR/rust/rust-$RUST_VERSION/cargo/bin"
