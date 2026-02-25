#!/bin/bash

echo "Install BWA-mem2"

pkg_install \
  -n "bwa-mem2" \
  -v "2.3" \
  -u "https://github.com/bwa-mem2/bwa-mem2/releases/download/v2.3/bwa-mem2-2.3_x64-linux.tar.bz2" \
  -t "unpack"
