#!/bin/bash

echo "Install gum"

GUM_VERSION=$(pkg_version "gum")
export GUM_VERSION

pkg_install \
  -n "gum" \
  -t "unpack"

