#!/bin/bash

BAT_VERSION="0.26.1"
# Install ripgrep
cargo install \
  --git https://github.com/sharkdp/bat.git \
  --tag "v$BAT_VERSION" \
  --locked

# Module
make_lua_module "bat" "$BAT_VERSION" "$INSTALL_DIR/rust/rust-$RUST_VERSION/cargo/bin"
