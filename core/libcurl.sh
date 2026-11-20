#!/bin/bash

echo "Install libcurl"

LIBCURL_VERSION=$(pkg_version "libcurl")
export LIBCURL_VERSION

pkg_install -n "libcurl" \
            -o "--enable-shared \
--enable-static \
--enable-optimize \
--disable-manual \
--disable-ldap \
--disable-ldaps \
--without-libpsl \
--with-openssl"
