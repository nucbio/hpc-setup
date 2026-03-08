#!/bin/bash

export JAVA_VERSION="25.0.1"

pkg_install \
  -n "java" \
  -v "$JAVA_VERSION" \
  -u "https://download.oracle.com/java/25/archive/jdk-${JAVA_VERSION}_linux-x64_bin.tar.gz" \
  -t "unpack"
