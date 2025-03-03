#!/bin/bash
export LC_ALL="C"

   GUIX_PROFILE="$HOME/.guix-profile"
     . "$GUIX_PROFILE/etc/profile"

#export GUILE_LOAD_PATH="/gnu/store/rfgcri126zxyd3kdxp23751pw18lrca4-artanis-1.0.0/share/guile/site/3.0${GUILE_LOAD_PATH:+:}$GUILE_LOAD_PATH"
#export GUILE_DBD_PATH="/gnu/store/pg4pg9j78bxp6lvyc0dlmyf27q5rgzp5-guile-dbd-postgresql-2.1.8/lib${GUILE_DBD_PATH:+:}$GUILE_DBD_PATH"

art work --config=/home/mbc/.config/limsn/artanis.conf

## working with artanis 1.0.0 but not nss/nspr
