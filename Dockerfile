FROM ubuntu:20.04

ARG CLANG_VERSION
ARG CMAKE_VERSION
ARG BOOST_VERSION

ENV CLANG_VERSION=10.0
ENV CMAKE_VERSION="3.19.3"
ENV BOOST_VERSION="1.75.0"

ENV LLVM_VERSION=${CLANG_VERSION} \
    CC=clang \
    CXX=clang++ \
    CMAKE_C_COMPILER=clang \
    CMAKE_CXX_COMPILER=clang++ \
    PYENV_ROOT=/opt/pyenv \
    PATH=/opt/pyenv/shims:${PATH}

RUN mkdir scripts

ADD scripts/install_clang.sh scripts/install_clang.sh
ADD scripts/install_boost.sh scripts/install_boost.sh
ADD scripts/install_cmake.sh scripts/install_cmake.sh

RUN chmod +x scripts/. -R

RUN apt-get -qq update \
 && apt-get -y --no-install-recommends install \
    ca-certificates \
    curl \
    wget \
    git \
    libssl-dev \
    libc++-dev \
    libc++abi-dev \
    pkg-config \
    libreadline-dev xz-utils \
    libncurses5-dev \
    libmysqlclient-dev \
    libbz2-dev \
    bzip2 \
    ccache \
    ninja-build \
&& ln -s /usr/include/locale.h /usr/include/xlocale.h 

RUN scripts/install_clang.sh
RUN scripts/install_cmake.sh
RUN scripts/install_boost.sh

RUN rm -rf /var/lib/apt/lists/*
