#!/bin/bash

echo "Install gum"

export GUM_VERSION="0.17.0"

pkg_install \
  -n "gum" \
  -v "$GUM_VERSION" \
  -u "https://github.com/charmbracelet/gum/releases/download/v${GUM_VERSION}/gum_${GUM_VERSION}_Linux_x86_64.tar.gz" \
  -t "unpack"

