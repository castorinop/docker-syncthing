FROM multiarch/alpine:x86_64-latest-stable

RUN adduser -D user
RUN mkdir -p /home/user/bin

ENV SYNCTHING_VERSION 0.13.4
ENV ARCH=amd64 
RUN apk add wget --update && \
#FIXME check certificate
wget --no-check-certificate https://github.com/syncthing/syncthing/releases/download/v$SYNCTHING_VERSION/syncthing-linux-$ARCH-v$SYNCTHING_VERSION.tar.gz -O sycnthing.tar.gz && \
tar zxvf sycnthing.tar.gz && \
mv syncthing-linux-$ARCH-v$SYNCTHING_VERSION/syncthing /home/user/bin/ && \
rm sycnthing.tar.gz && \
rm -rf /tmp/src && \
rm -rf /var/cache/apk/*

RUN chown user.user /home/user/bin -Rv

COPY noarch/*.sh /usr/bin/
RUN chmod 755 /usr/bin/*sh

env PATH /home/user/bin:$PATH

ENTRYPOINT ["entrypoint.sh"]
CMD "syncthing" "-gui-address=0.0.0.0:8384"

EXPOSE 8384
EXPOSE 22000


