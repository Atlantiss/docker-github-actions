FROM alpine:edge as build

RUN apk --update add \
    clang \
    cmake \
    boost-dev \
    git \
    libressl-dev \
    readline-dev \
    ncurses-dev \
    mariadb-dev \
    bzip2-dev \
    ccache \
    ninja \
&& rm -rf /var/cache/apk/*

FROM scratch
COPY --from=build / /
WORKDIR /
