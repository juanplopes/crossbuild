#!/bin/bash
set -xeof pipefail

mkdir -p tmp-openssl
cd tmp-openssl
OPENSSL=openssl-1.1.1s
if [ ! -d $OPENSSL ]; then
  wget --no-check-certificate https://www.openssl.org/source/$OPENSSL.tar.gz
  tar zfx $OPENSSL.tar.gz
fi
cd $OPENSSL

export CROSS_COMPILE=/usr/$CROSS_TRIPLE/bin/
./Configure $OPENSSL_CONF --prefix=$PWD/../$CROSS_TRIPLE
make clean
make install_runtime_libs install_dev