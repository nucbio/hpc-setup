#!/bin/bash

echo "Install Rust"

module load libcurl

# Configuration
RUST_VERSION=$(pkg_version "rust")
export RUST_VERSION
INSTALL_ROOT="$INSTALL_DIR/rust/rust-$RUST_VERSION"

# Define local paths
export RUSTUP_HOME="$INSTALL_ROOT/rustup"
export CARGO_HOME="$INSTALL_ROOT/cargo"

# Create directories
mkdir -p "$RUSTUP_HOME" "$CARGO_HOME"

# Download and execute installer
curl --proto '=https' --tlsv1.2 -sSf "$(pkg_url rust)" | sh -s -- \
    -y \
    --default-toolchain "$RUST_VERSION" \
    --no-modify-path \
    --profile complete

# Module
module_templater "rust"

