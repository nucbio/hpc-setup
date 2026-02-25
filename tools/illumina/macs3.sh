#!/bin/bash

echo "Install MACS3"

module load python/$PYTHON_VERSION

pkg_install \
  -n "macs3" \
  -v "3.0.4" \
  -t "venv"
