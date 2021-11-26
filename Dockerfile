FROM ubuntu:20.04 as build

ARG CLANG_VERSION
ARG CMAKE_VERSION
ARG BOOST_VERSION

ENV CLANG_VERSION=10.0
ENV CMAKE_VERSION="3.19.3"
ENV BOOST_VERSION="1.76.0"

ENV LLVM_VERSION=${CLANG_VERSION} \
    CC=clang \
    CXX=clang++ \
    CMAKE_C_COMPILER=clang \
    CMAKE_CXX_COMPILER=clang++ \
    PYENV_ROOT=/opt/pyenv \
    PATH=/opt/pyenv/shims:${PATH}

WORKDIR /tmp

COPY ./scripts/install_boost.sh /tmp/
COPY ./scripts/install_clang.sh /tmp/
COPY ./scripts/install_cmake.sh /tmp/
COPY ./scripts/install_docker.sh /tmp/

ENV TZ=Etc/UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get -qq update \
 && apt-get -y --no-install-recommends install \
    apt-transport-https \
    gnupg \ 
    lsb-release \
    ca-certificates \
    curl

RUN /tmp/install_docker.sh

RUN apt-get -qq update \
 && apt-get -y --no-install-recommends install \
    git \
    libssl-dev \
    libreadline-dev \
    libncurses-dev \
    libmysqlclient-dev \
    libbz2-dev \
    ccache \
    ninja-build \
    mysql-server \
    expect \
    make \
    automake \
    python3-pip \
    libffi-dev \
    python3-dev \
    build-essential \
    zip \
    p7zip-full p7zip-rar \
    nodejs \
    npm \
    docker-ce docker-ce-cli containerd.io \
    libzmq3-dev \
    libace-dev \
&& ln -s /usr/include/locale.h /usr/include/xlocale.h \
&& chmod +x /tmp/install_boost.sh \
&& chmod +x /tmp/install_clang.sh \
&& chmod +x /tmp/install_cmake.sh \
&& /tmp/install_clang.sh \
&& /tmp/install_cmake.sh \
&& /tmp/install_boost.sh \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

FROM scratch
COPY --from=build / /
WORKDIR /home/workspace
