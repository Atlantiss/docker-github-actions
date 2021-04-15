#!/bin/sh

if [ -z "$CLANG_VERSION" ]; then
    echo ERROR: CLANG_VERSION is not defined
    exit 1
fi

CLANG_VERSION_SHORT=${CLANG_VERSION%.*}

apt-get -y --no-install-recommends install clang-${CLANG_VERSION_SHORT} clang-tools-${CLANG_VERSION_SHORT}

update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-${CLANG_VERSION_SHORT} 100
update-alternatives --install /usr/bin/clang clang /usr/bin/clang-${CLANG_VERSION_SHORT} 100
update-alternatives --install /usr/bin/cc cc /usr/bin/clang-${CLANG_VERSION_SHORT} 100
update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++-${CLANG_VERSION_SHORT} 100
update-alternatives --install /usr/bin/cpp cpp /usr/bin/clang++-${CLANG_VERSION_SHORT} 100

echo "Clang (${CLANG_VERSION}) installed."
