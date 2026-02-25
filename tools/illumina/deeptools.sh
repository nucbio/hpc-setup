#!/bin/bash

echo "Install Deeptools"

pkg_install \
  -n "deeptools" \
  -v "3.5.6" \
  -t "venv"
