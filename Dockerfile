FROM ubuntu:20.04 as build

WORKDIR /tmp

ENV TZ=Etc/UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt-get -qq update \
 && apt-get -y --no-install-recommends install \
    ca-certificates \
    libssl-dev \
    libreadline-dev \
    libmysqlclient-dev \
    mysql-client \
&& ln -s /usr/include/locale.h /usr/include/xlocale.h \
&& apt-get clean \
&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* 

FROM scratch
COPY --from=build / /
WORKDIR /home/workspace
