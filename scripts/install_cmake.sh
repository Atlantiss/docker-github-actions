#!/bin/sh

if [ -z "$CMAKE_VERSION" ]; then
    echo ERROR: CMAKE_VERSION is not defined
    exit 1
fi

curl -SL https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}-Linux-x86_64.tar.gz | \
   tar -zx --exclude=bin/cmake-gui --exclude=doc/cmake --exclude=share/cmake-${CMAKE_VERSION}/Help

cp -fR cmake-${CMAKE_VERSION}-Linux-x86_64/* /usr
rm -rf cmake-${CMAKE_VERSION}-Linux-x86_64

echo "CMake ($CMAKE_VERSION) installed."
