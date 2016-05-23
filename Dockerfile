FROM alpine

ENV SYNCTHING_VERSION 0.13.2
ENV ARCH=amd64 
RUN apk add wget --update && \
#FIXME check certificate
wget --no-check-certificate https://github.com/syncthing/syncthing/releases/download/v0.13.2/syncthing-linux-$ARCH-v$SYNCTHING_VERSION.tar.gz -O sycnthing.tar.gz && \
tar zxvf sycnthing.tar.gz && \
mv syncthing-linux-$ARCH-v$SYNCTHING_VERSION/syncthing /usr/bin/ && \
rm -rf /tmp/src && \
rm -rf /var/cache/apk/*

RUN adduser -D user
USER user

ENTRYPOINT ["syncthing"]
CMD ["-gui-address=0.0.0.0:8384"]

EXPOSE 8384
EXPOSE 22000


