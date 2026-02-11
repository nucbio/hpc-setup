#!/bin/bash

echo "Install libcurl"

pkg_install -n "libcurl" \
            -v "8.17.0" \
            -u "https://curl.se/download/curl-8.17.0.tar.gz" \
            -o "--enable-shared \
--enable-static \
--enable-optimize \
--disable-manual \
--disable-ldap \
--disable-ldaps \
--without-libpsl \
--with-openssl"
