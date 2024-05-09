#!/bin/bash

cd home
mkdir $USER
cd $USER
git clone https://sourceware.org/git/glibc.git
mkdir build
cd build
../glibc/configure CC="gcc -march=rv64gcv -mabi=lp64d " CXX="g++ -march=rv64gcv -mabi=lp64d " --prefix=$(pwd) --build=riscv64-unknown-linux-gnu --with-timeout-factor=8 2>&1 | tee config.log
make -k -O -j $(nproc) 2>&1 | tee build.log
export GLIBC_TEST_ALLOW_TIME_SETTING=1
make check -j $(nproc) -k -O 2>&1 | tee check.log
