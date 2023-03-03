#!/bin/bash
set -eof pipefail

DOCKER_REPO=juanplopes/crossbuild

# A POSIX variable
OPTIND=1 # Reset in case getopts has been used previously in the shell.

while getopts "d:" opt; do
    case "$opt" in
        d)  DOCKER_REPO=$OPTARG
        ;;
    esac
done

shift $((OPTIND-1))

[ "$1" = "--" ] && shift

DOCKER_TEST_ARGS="-it --rm -v $(pwd)/test:/test -w /test"

assert() {
  EXPECTED="$1"; shift
  for triple in $*; do
    docker run ${DOCKER_TEST_ARGS} \
           -e "ORIGINAL=$triple" -e "CROSS_TRIPLE=$triple" -e "EXPECTED=$EXPECTED" \
           ${DOCKER_REPO} make -s test
  done
}

assert_win() {
  EXPECTED="$1"; shift
  for triple in $*; do
    docker run ${DOCKER_TEST_ARGS} \
           -e "ORIGINAL=$triple" -e "CROSS_TRIPLE=$triple" -e "EXPECTED=$EXPECTED" \
           ${DOCKER_REPO} make -s test-win
  done
}

# MAC
#not supported: assert "Mach-O 64-bit x86_64_haswell subarchitecture=8 executable" i386-apple-darwin osx32 darwin32 #
assert "Mach-O 64-bit x86_64 executable" x86_64-apple-darwin osx osx64 darwin darwin64
assert "Mach-O 64-bit arm64 executable" aarch64-apple-darwin aarch-apple-darwin arm64-apple-darwin arm-apple-darwin #osx64arm
assert "Mach-O 64-bit x86_64_haswell subarchitecture=8 executable" x86_64h-apple-darwin osx64h darwin64h x86_64h

# WINDOWS
assert_win "PE32+ executable (console) x86-64" x86_64-w64-mingw32 windows win64
assert_win "PE32 executable (console) Intel 80386" i686-w64-mingw32 win32

# LINUX
assert "ELF 64-bit LSB pie executable, x86-64" x86_64-linux-gnu linux x86_64 amd64
assert "ELF 64-bit LSB pie executable, ARM aarch64" aarch64-linux-gnu arm64 aarch64
assert "ELF 32-bit LSB pie executable, ARM, EABI5 version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux-armhf.so.3" arm-linux-gnueabihf armhf armv7 armv7l
assert "ELF 32-bit LSB pie executable, ARM, EABI5 version 1 (SYSV), dynamically linked, interpreter /lib/ld-linux.so.3" arm-linux-gnueabi arm armv5
assert "ELF 64-bit LSB pie executable, 64-bit PowerPC or cisco 7500" powerpc64le-linux-gnu powerpc powerpc64 powerpc64le
assert "ELF 32-bit LSB pie executable, MIPS, MIPS32 rel2 version 1" mipsel-linux-gnu mips mipsel
