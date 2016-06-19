#!/bin/sh



PUID=${PUID:-911}
PGID=${PGID:-911}

if [ ! "$(id -g user)" -eq "$PGID" ]; then 
	delgroup user;
	addgroup -g "$PGID" user ; 
fi
if [ ! "$(id -u user)" -eq "$PUID" ]; then 
	deluser user;
	adduser -D -u "$PUID" user ; 
fi

echo "
-------------------------------------
GID/UID
-------------------------------------
User uid:    $(id -u user)
User gid:    $(id -g user)
-------------------------------------
"
chown -Rv user:user /home/user
#chown abc:abc /app
#chown abc:abc /config
#chown abc:abc /defaults
