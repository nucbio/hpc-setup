#!/bin/bash


export PCRE2_VERSION="10.47"
LIB_DIR=$INSTALL_DIR/pcre2/pcre2-$PCRE2_VERSION
SRC_DIR=$LIB_DIR/src
PKG_BUILD_DIR=/tmp/pcre2-build

# Prepare source directory
mkdir -p $SRC_DIR
cd $LIB_DIR
wget https://github.com/PCRE2Project/pcre2/releases/download/pcre2-$PCRE2_VERSION/pcre2-$PCRE2_VERSION.tar.gz
tar -xzf pcre2*.tar.gz -C ${SRC_DIR} --strip-components=1

# Clean old builds
rm -rf ${PKG_BUILD_DIR}
mkdir -p ${PKG_BUILD_DIR}

# Configure and build with proper settings
cmake -S $SRC_DIR -B $PKG_BUILD_DIR \
    -DCMAKE_INSTALL_PREFIX=$LIB_DIR \
    -DBUILD_SHARED_LIBS=ON \
    -DBUILD_STATIC_LIBS=OFF \
    -DPCRE2_BUILD_PCRE2_8=ON \
    -DPCRE2_BUILD_PCRE2_16=ON \
    -DPCRE2_BUILD_PCRE2_32=ON \
    -DPCRE2_SUPPORT_UNICODE=ON \
    -DCMAKE_POSITION_INDEPENDENT_CODE=ON \
    -DCMAKE_C_FLAGS="-O2 -fPIC" \
    -DCMAKE_CXX_FLAGS="-O2 -fPIC"

cmake --build $PKG_BUILD_DIR -j 4
cmake --install $PKG_BUILD_DIR

# Modules
make_lua_module "pcre2" "$PCRE2_VERSION"
