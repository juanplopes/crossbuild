#!/bin/bash
set -eof pipefail

DOCKER_REPO=juanplopes/crossbuild

assert() {
  docker run -it --rm -v $(pwd)/test:/test -w /test \
         -e "ORIGINAL=$1" -e "CROSS_TRIPLE=$1" -e "OPENSSL_CONF=$2" \
         ${DOCKER_REPO} ./make-openssl.sh
}

# MAC
assert x86_64-apple-darwin darwin64-x86_64-cc
assert aarch64-apple-darwin darwin64-arm64-cc

# WINDOWS
assert i686-w64-mingw32 mingw
assert x86_64-w64-mingw32 mingw64

# LINUX
assert x86_64-linux-gnu linux-x86_64
assert aarch64-linux-gnu linux-aarch64


