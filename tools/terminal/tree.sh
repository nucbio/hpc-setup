#!/bin/bash

echo "Install tree"

module purge
module load rust

export TREE_VERSION="1.3.0"

cargo install \
  --git https://github.com/peteretelej/tree.git \
  --tag "v$TREE_VERSION" \
  --locked

# Module
make_lua_module "tree" "$TREE_VERSION" "$INSTALL_DIR/rust/rust-$RUST_VERSION/cargo/bin"
