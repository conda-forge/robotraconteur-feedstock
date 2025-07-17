#!/bin/sh

set -e

if [[ "$target_platform" == linux-* ]]; then
    mkdir -p bluez/include/bluetooth
    cp -r bluez-src/lib/*.h bluez/include/bluetooth/
    export CXXFLAGS="$CXXFLAGS -I$SRC_DIR/bluez/include"
fi

mkdir -p build2
cd build2

cmake -DBUILD_TESTING=OFF -DBUILD_GEN=ON \
    -DBUILD_NET=ON -DRR_NET_BUILD_NATIVE_ONLY=ON \
    -DRR_NET_INSTALL_NATIVE_LIB=ON -DBUILD_DOCUMENTATION=OFF \
    -DCMAKE_BUILD_TYPE:STRING=Release -DROBOTRACONTEURCORE_SOVERSION_MAJOR_ONLY=ON \
    -DCMAKE_VERBOSE_MAKEFILE=ON \
    -DCMAKE_INSTALL_LIBDIR=lib -DBUILD_SHARED_LIBS:BOOL=ON  ${CMAKE_ARGS} ..

cmake --build . --config Release -- -j$CPU_COUNT
cmake --build . --config Release --target install
