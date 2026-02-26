#!/bin/bash

echo "Install fdfind"
## fdfind - modern cd
export FD_VERSION="10.3.0"
# Install fdfind
cargo install \
  --git https://github.com/sharkdp/fd.git \
  --tag "v$FD_VERSION" \
  --locked

# Module
make_lua_module "fd" "$FD_VERSION" "$INSTALL_DIR/rust/rust-$RUST_VERSION/cargo/bin"
