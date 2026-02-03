#!/bin/bash

## zoxide - modern cd
ZOXIDE_RELEASE_TAG="${ZOXIDE_RELEASE_TAG:-v0.9.7}"
# Install ripgrep
cargo install \
  --git https://github.com/ajeetdsouza/zoxide.git \
  --tag "$ZOXIDE_RELEASE_TAG" \
  --locked
