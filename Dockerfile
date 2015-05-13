FROM alpine:3.1
MAINTAINER Harpreet Singh <hs@hsingh.com>
# Based on https://github.com/mhart/alpine-node

ENV VERSION=v0.10.38 CFLAGS="-D__USE_MISC"

RUN apk add --update curl make gcc g++ python paxctl libgcc libstdc++ && \
  curl -sSL https://nodejs.org/dist/${VERSION}/node-${VERSION}.tar.gz | tar -xz && \
  cd /node-${VERSION} && \
  ./configure --prefix=/usr --without-npm && \
  make -j$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) && \
  make install && \
  paxctl -cm /usr/bin/node && \
  cd / && \
  apk del curl make gcc g++ python paxctl && \
  rm -rf /etc/ssl /usr/include /node-${VERSION} \
    /usr/share/man /tmp/* /root/.node-gyp

CMD ["sh"]
