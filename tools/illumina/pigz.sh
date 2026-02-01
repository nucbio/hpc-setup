#!/bin/bash

mkdir -p ${INSTALL_DIR}/tools/pigz/source && \
  cd ${INSTALL_DIR}/tools/pigz/source
wget https://www.zlib.net/pigz/pigz-2.8.tar.gz
tar -C .. -xzvf pigz-2.8.tar.gz
cd ../pigz-2.8
make -j 8
