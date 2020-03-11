FROM ubuntu:18.04

ENV LLVM_VERSION=9.0 \
    CC=clang \
    CXX=clang++ \
    CMAKE_C_COMPILER=clang \
    CMAKE_CXX_COMPILER=clang++ \
    PYENV_ROOT=/opt/pyenv \
    PATH=/opt/pyenv/shims:${PATH}

RUN apt-get update \
	&& apt-get -y --no-install-recommends install systemd ca-certificates curl git clang cmake make gcc g++ libmysqlclient-dev libssl-dev libbz2-dev libreadline-dev libncurses-dev mariadb-client mariadb-server python-dev ninja-build ccache p7zip \
	&& apt-get clean -y \
	&& rm -rf /var/lib/apt/lists/*

RUN update-alternatives --install /usr/bin/cc cc /usr/bin/clang 100 \
    && update-alternatives --install /usr/bin/c++ c++ /usr/bin/clang 100

# Install Boost 1.72
RUN curl -SL https://dl.bintray.com/boostorg/release/1.72.0/source/boost_1_72_0.tar.gz | tar -zx && \
    cd boost_1_72_0 && \
    ./bootstrap.sh && \
    ./b2 install -j 8 && \
    cd .. && rm -rf boost_1_72_0

RUN systemctl enable mariadb

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
