#!/bin/sh
/usr/bin/set_user.sh

CMD="$APP_BIN $APP_ARGS $@"
echo call "$CMD"
su user -c "$CMD"
