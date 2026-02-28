#!/bin/bash

echo "Installing STAR aligner"

pkg_install \
  -n "star" \
  -v "2.7.11b" \
  -u "https://github.com/alexdobin/STAR/releases/download/$PKG_VERSION/STAR_$PKG_VERSION.zip" \
  -t "unpack"


