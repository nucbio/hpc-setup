#!/bin/bash

# Configuration
RUST_VERSION="1.93.0"
INSTALL_ROOT="$INSTALL_DIR/rust/rust-$RUST_VERSION"

# Define local paths
export RUSTUP_HOME="$INSTALL_ROOT/rustup"
export CARGO_HOME="$INSTALL_ROOT/cargo"

# Create directories
mkdir -p "$RUSTUP_HOME" "$CARGO_HOME"

# Download and execute installer
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- \
    -y \
    --default-toolchain "$RUST_VERSION" \
    --no-modify-path \
    --profile complete



# TEST: install packs
# FIX: lock problem
#rustup update
#rustup default stable



for install_tool in ${REPO_DIR}/tools/test/*.sh
  do 
    source $install_tool
  done

