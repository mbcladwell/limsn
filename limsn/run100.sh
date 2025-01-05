#!/bin/bash
export LC_ALL="C"

export GUILE_LOAD_PATH="/home/mbc/projects/limsn:/gnu/store/rfgcri126zxyd3kdxp23751pw18lrca4-artanis-1.0.0/share/guile/site/3.0:/gnu/store/x388h9kr9sx99pm2wq6fk0ga3cip5sjx-guile-dbi-2.1.8/share/guile/site/2.2:/gnu/store/aygzibvkqvvq5wfmhlks0nbg2ch57wq0-guile-redis-2.2.0/share/guile/site/3.0:/gnu/store/b0vf329whqiz3f6s386a5h0r8h3b31jg-guile-readline-3.0.9/share/guile/site/3.0:/gnu/store/711y2zrpg0ygxaghy72v8hzwla7mjaqg-guile-json-4.7.3/share/guile/site/3.0${GUILE_LOAD_PATH:+:}$GUILE_LOAD_PATH"
export GUILE_LOAD_COMPILED_PATH="/gnu/store/bhhgrxslz5d00hrbjnfrpclgg0phdryh-artanis-0.5.2/share/guile/site/3.0${GUILE_LOAD_COMPILED_PATH:+:}$GUILE_LOAD_COMPILED_PATH"
export GUILE_DBD_PATH="/gnu/store/pg4pg9j78bxp6lvyc0dlmyf27q5rgzp5-guile-dbd-postgresql-2.1.8/lib${GUILE_DBD_PATH:+:}$GUILE_DBD_PATH"

mkdir -p /tmp/limsn/tmp/cache
art work --config=/home/mbc/.config/limsn/artanis.conf

## working with artanis 1.0.0 but not nss/nspr
