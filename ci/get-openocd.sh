#!/usr/bin/env bash

set -e

# Can't install version (without patch)
VERSION="af3a034b57279d2a400d87e7508c9a92254ec165"
# Can be able to run version, but not 
#VERSION="41b9c69e92d9660cb2eff508f3bc8218a3b3e461"

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

mkdir -p $RISCV/
cd $RISCV

check_version() {
    $1 --version | awk "NR==1 {if (\$NF>$2) {exit 0} exit 1}" || (
	echo $3 requires at least version $2 of $1. Aborting.
	exit 1
    )
}

if [ -z ${NUM_JOBS} ]; then
    NUM_JOBS=1
fi

if ! [ -e $RISCV/bin/openocd ]; then
    if ! [ -e $RISCV/riscv-openocd ]; then
	git clone https://github.com/riscv/riscv-openocd.git
    fi
    check_version automake 1.14 "OpenOCD build"
    check_version autoconf 2.64 "OpenOCD build"

    cd riscv-openocd
    git checkout $VERSION
    git submodule update --init --recursive

    echo "Compiling OpenOCD"
    ./bootstrap
    ./configure --prefix=$RISCV --disable-werror --disable-wextra --enable-remote-bitbang
    patch -p1 < ${SCRIPT_DIR}/openocd.patch

    make -j${NUM_JOBS}
    make install
    echo "Compilation Finished"
fi

