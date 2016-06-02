FROM multiarch/alpine:x86-latest-stable

RUN adduser -D user
RUN mkdir -p /home/user/bin

ENV SYNCTHING_VERSION 0.13.4
ENV ARCH=386 
RUN echo "http://dl-cdn.alpinelinux.org/alpine/latest-stable/main/" > /etc/apk/repositories && \
apk add wget --update && \
#FIXME check certificate
wget --no-check-certificate https://github.com/syncthing/syncthing/releases/download/v$SYNCTHING_VERSION/syncthing-linux-$ARCH-v$SYNCTHING_VERSION.tar.gz -O sycnthing.tar.gz && \
tar zxvf sycnthing.tar.gz && \
mv syncthing-linux-$ARCH-v$SYNCTHING_VERSION/syncthing /home/user/bin/ && \
rm -rf /tmp/src && \
rm -rf /var/cache/apk/*

RUN chown user.user /home/user/bin -Rv

USER user

env PATH /home/user/bin:$PATH
ENTRYPOINT ["syncthing"]
CMD ["-gui-address=0.0.0.0:8384"]

EXPOSE 8384
EXPOSE 22000


