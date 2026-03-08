#!/bin/bash

echo "Installing STAR aligner"

pkg_install \
  -n "star" \
  -v "2.7.11b" \
  -u "https://github.com/alexdobin/STAR/releases/download/2.7.11b/STAR_2.7.11b.zip" \
  -t "unpack"


