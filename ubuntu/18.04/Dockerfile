FROM ubuntu:18.04

ENV LLVM_VERSION=9.0 \
    CC=clang \
    CXX=clang++ \
    CMAKE_C_COMPILER=clang \
    CMAKE_CXX_COMPILER=clang++ \
    PYENV_ROOT=/opt/pyenv \
    PATH=/opt/pyenv/shims:${PATH}

RUN apt-get -qq update \
	&& apt-get -y --no-install-recommends install \
       wget \
       git \
       g++ \
       gcc \
       clang-9 \
       make \
       libc6-dev-i386 \
       libssl-dev \
       ninja-build \
       libc++-dev \
       libc++abi-dev \
       pkg-config \
       libbz2-dev \
       libreadline-dev \
       xz-utils \
       curl \
       libncurses5-dev \
       ca-certificates \
       mariadb-server \
       mariadb-client \
       libmysqlclient-dev \
       python-dev \
       ccache \
       libbz2-dev \
       bzip2 \
	&& update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-9 100 \
    && update-alternatives --install /usr/bin/clang clang /usr/bin/clang-9 100 \
    && update-alternatives --install /usr/bin/cc cc /usr/bin/clang-9 100 \
    && update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++-9 100 \
    && update-alternatives --install /usr/bin/cpp cpp /usr/bin/clang++-9 100 \
    && ln -s /usr/include/locale.h /usr/include/xlocale.h \
    && rm -rf /var/lib/apt/lists/* \
    && wget -q --no-check-certificate https://github.com/Kitware/CMake/releases/download/v3.18.4/cmake-3.18.4-Linux-x86_64.tar.gz\
    && tar -xzf cmake-3.18.4-Linux-x86_64.tar.gz \
       --exclude=bin/cmake-gui \
       --exclude=doc/cmake \
       --exclude=share/cmake-3.12/Help \
    && cp -fR cmake-3.18.4-Linux-x86_64/* /usr \
    && rm -rf cmake-3.18.4-Linux-x86_64 \
    && rm cmake-3.18.4-Linux-x86_64.tar.gz \
    && curl -SL https://dl.bintray.com/boostorg/release/1.74.0/source/boost_1_74_0.tar.gz | tar -zx \
    && cd boost_1_74_0 \
    && ./bootstrap.sh --with-libraries=all --with-toolset=clang \
    && ./b2 install -j 8 \
    && cd .. \
    && rm -rf boost_1_74_0 \
    && mkdir /home/workspace

RUN update-rc.d mysql defaults

WORKDIR /home/workspace

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
