#!/bin/bash

echo "Install eza"

# eza - CLI tool
export EZA_VERSION="0.23.4"
# Install eza
cargo install \
  --git https://github.com/eza-community/eza.git \
  --tag "v$EZA_VERSION" \
  --locked

# Module
make_lua_module "eza" "$EZA_VERSION" "$INSTALL_DIR/rust/rust-$RUST_VERSION/cargo/bin"
