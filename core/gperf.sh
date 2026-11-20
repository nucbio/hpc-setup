#!/bin/bash

echo "Install gperf"

GPERF_VERSION=$(pkg_version "gperf")
export GPERF_VERSION

pkg_install \
    -n "gperf"
