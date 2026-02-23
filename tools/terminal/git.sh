#!/bin/bash

echo "Install git"

export GIT_VERSION="2.9.5"

pkg_install -n "git" \
            -v "$GIT_VERSION" \
            -u "https://mirrors.edge.kernel.org/pub/software/scm/git/git-$GIT_VERSION.tar.xz"
