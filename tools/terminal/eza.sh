#!/bin/bash

# eza - CLI tool
EZA_RELEASE_TAG="${EZA_RELEASE_TAG:-v0.23.4}"
# Install eza
cargo install \
  --git https://github.com/eza-community/eza.git \
  --tag "$EZA_RELEASE_TAG" \
  --locked

