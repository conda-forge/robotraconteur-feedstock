#!/bin/sh

set -e

if [[ "$target_platform" == linux-* ]]; then
    mkdir -p bluez/include/bluetooth
    cp -r bluez-src/lib/*.h bluez/include/bluetooth/
    export CXXFLAGS="$CXXFLAGS -I$SRC_DIR/bluez/include"
fi

mkdir -p build3
cd build3

cmake -DBUILD_TESTING=OFF -DBUILD_GEN=OFF -DBUILD_PYTHON3=ON \
    -DBUILD_CORE=OFF \
    -DBUILD_DOCUMENTATION=OFF \
    -DPYTHON3_EXECUTABLE=$PYTHON \
    -DPython3_NumPy_INCLUDE_DIR=$STDLIB_DIR/site-packages/numpy/_core/include \
    -DCMAKE_VERBOSE_MAKEFILE=ON \
    -DBUILD_SHARED_LIBS:BOOL=ON  ${CMAKE_ARGS} ..

cmake --build . --config Release -- -j2
cd out/Python3
$PYTHON -m pip install --no-deps --ignore-installed . -vv