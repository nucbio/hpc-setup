#!/bin/bash

JAVA_VERSION=$(pkg_version "java")
export JAVA_VERSION

pkg_install \
  -n "java" \
  -t "unpack"
