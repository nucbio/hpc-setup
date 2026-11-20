#!/bin/bash

echo "Install MACS3"

module load python/$PYTHON_VERSION

pkg_install \
  -n "macs3" \
  -t "venv"
