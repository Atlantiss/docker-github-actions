FROM ubuntu:eoan

ENV LLVM_VERSION=9.0 \
    CC=clang \
    CXX=clang++ \
    CMAKE_C_COMPILER=clang \
    CMAKE_CXX_COMPILER=clang++ \
    PYENV_ROOT=/opt/pyenv \
    PATH=/opt/pyenv/shims:${PATH}

RUN apt-get -qq update \
	&& apt-get -y --no-install-recommends install \
       sudo=1.* \
       wget=1.* \
       git=1:2.* \
       g++-multilib=4:9.* \
       clang-9=1:9* \
       make=4.* \
       libc6-dev-i386=2.* \
       libssl-dev=1* \
       ninja-build=1.* \
       libc++-dev=1:9.* \
       libc++abi-dev=1:9.* \
       pkg-config=0.* \
       libbz2-dev=1.* \
       libreadline-dev=8.* \
       xz-utils=5.* \
       curl=7.* \
       libncurses5-dev=6.* \
       ca-certificates \
       mariadb-server \
       mariadb-client \
       libmysqlclient-dev \
       python-dev \
       ccache \
	&& update-alternatives --install /usr/bin/clang++ clang++ /usr/bin/clang++-9 100 \
    && update-alternatives --install /usr/bin/clang clang /usr/bin/clang-9 100 \
    && update-alternatives --install /usr/bin/cc cc /usr/bin/clang-9 100 \
    && update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang++-9 100 \
    && update-alternatives --install /usr/bin/cpp cpp /usr/bin/clang++-9 100 \
    && ln -s /usr/include/locale.h /usr/include/xlocale.h \
    && rm -rf /var/lib/apt/lists/* \
    && wget -q --no-check-certificate https://cmake.org/files/v3.16/cmake-3.16.4-Linux-x86_64.tar.gz \
    && tar -xzf cmake-3.16.4-Linux-x86_64.tar.gz \
       --exclude=bin/cmake-gui \
       --exclude=doc/cmake \
       --exclude=share/cmake-3.12/Help \
    && cp -fR cmake-3.16.4-Linux-x86_64/* /usr \
    && rm -rf cmake-3.16.4-Linux-x86_64 \
    && rm cmake-3.16.4-Linux-x86_64.tar.gz \
    && curl -SL https://dl.bintray.com/boostorg/release/1.72.0/source/boost_1_72_0.tar.gz | tar -zx \
    && cd boost_1_72_0 \
    && ./bootstrap.sh \
    && ./b2 install -j 8 \
    && cd .. \
    && rm -rf boost_1_72_0 \
    && useradd -ms /bin/bash atlantiss \
    && printf "atlantiss:atlantiss" | chpasswd \
    && adduser atlantiss sudo \
    && printf "atlantiss ALL= NOPASSWD: ALL\\n" >> /etc/sudoers

RUN update-rc.d mysql defaults && \
    update-rc.d mysql start 

USER atlantiss
WORKDIR /home/atlantiss
