#!/bin/bash

echo "Install libcurl"

export LIBCURL_VERSION="8.17.0"

pkg_install -n "libcurl" \
            -v "$LIBCURL_VERSION" \
            -u "https://curl.se/download/curl-$LIBCURL_VERSION.tar.gz" \
            -o "--enable-shared \
--enable-static \
--enable-optimize \
--disable-manual \
--disable-ldap \
--disable-ldaps \
--without-libpsl \
--with-openssl"
