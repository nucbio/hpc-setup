#!/bin/bash

echo "Install fribidi"

FRIBIDI_VERSION=$(pkg_version "fribidi")
export FRIBIDI_VERSION

pkg_install -n "fribidi"
