#!/bin/bash

echo "Install Deeptools"

module load python/$PYTHON_VERSION

pkg_install \
  -n "deeptools" \
  -t "venv"
