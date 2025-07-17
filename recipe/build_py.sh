#!/bin/sh

set -e

if [[ "$target_platform" == linux-* ]]; then
    mkdir -p bluez/include/bluetooth
    cp -r bluez-src/lib/*.h bluez/include/bluetooth/
    export CXXFLAGS="$CXXFLAGS -I$SRC_DIR/bluez/include"
fi

mkdir -p build2
cd build2

cmake -DBUILD_TESTING=OFF -DBUILD_GEN=OFF -DBUILD_PYTHON3=ON \
    -DBUILD_CORE=OFF \
    -DBUILD_DOCUMENTATION=OFF \
    -DCMAKE_BUILD_TYPE:STRING=Release -DPYTHON3_EXECUTABLE=$PREFIX/bin/python \
    -DCMAKE_VERBOSE_MAKEFILE=ON -DSWIG_PYTHON_EXTRA_ARGS="-DSWIGWORDSIZE64" \
    -DCMAKE_PREFIX_PATH=${PREFIX} \
    -DCMAKE_INSTALL_PREFIX=${PREFIX} \
    -DCMAKE_INSTALL_LIBDIR=lib -DBUILD_SHARED_LIBS:BOOL=ON  ${CMAKE_ARGS} ..

cmake --build . --config Release -- -j2
cd out/Python3
$PYTHON -m pip install --no-deps --ignore-installed . -vv