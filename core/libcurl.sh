#!/bin/bash

export LIBCURL_VERSION="8.17.0"

LIB_DIR=$INSTALL_DIR/libcurl/libcurl-$LIBCURL_VERSION
BUILD_DIR=/tmp/libcurl-$LIBCURL_VERSION-build

SRC_DIR=$LIB_DIR/src
mkdir -p $SRC_DIR
cd $LIB_DIR
wget --no-check-certificate https://curl.se/download/curl-$LIBCURL_VERSION.tar.gz
tar -xzf curl*.tar.gz -C ${SRC_DIR} --strip-components=1
# tmp dir for compilation
rm -rf ${BUILD_DIR}
mkdir -p ${BUILD_DIR}
cd ${BUILD_DIR}
# Configure
${SRC_DIR}/configure \
    --prefix=$LIB_DIR \
    --enable-shared \
    --enable-static \
    --with-openssl="$INSTALL_DIR/openssl/openssl-$OPENSSL_VERSION" \
    --enable-optimize \
    --disable-manual \
    --disable-ldap \
    --disable-ldaps \
    --without-libpsl
# Compile
make -j$(nproc) && make install
# Cleanup
rm -rf $BUILD_DIR
rm -rf $SRC_DIR

# Modules
make_lua_module "libcurl" "$LIBCURL_VERSION"
