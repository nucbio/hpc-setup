#!/bin/bash

echo "Install gettext"

GETTEXT_VERSION=$(pkg_version "gettext")
export GETTEXT_VERSION

pkg_install -n "gettext"
