#!/bin/bash

echo "Install sqlite3"

SQLITE_VERSION=$(pkg_version "sqlite3")
export SQLITE_VERSION
pkg_install -n "sqlite3"
