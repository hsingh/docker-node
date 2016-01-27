FROM progrium/busybox
MAINTAINER Harpreet Singh <hs@hsingh.com>
# Based on https://github.com/hwestphal/docker-nodebox

ENV VERSION v0.10.38
ENV PATH /node-$VERSION-linux-x64/bin:$PATH

RUN opkg-install curl ca-certificates libstdcpp && \
  curl -ksSL https://nodejs.org/dist/${VERSION}/node-${VERSION}-linux-x64.tar.gz | gunzip -c - | tar -xf - && \
  opkg-cl remove ca-certificates && \
  rm -rf /etc/ssl \
         /usr/include \
         /usr/share/man \
         /root/.node-gyp \

CMD ["sh"]
