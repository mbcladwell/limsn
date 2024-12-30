#!/bin/bash
PATH_INTO_STORE=$HOMEpathintostore
export LC_ALL="C"
mkdir -p /var/tmp/limsn/tmp/cache
cd $PATH_INTO_STORE/share/guile/site/3.0/limsn
art.in work -h0.0.0.0 --config=$HOME/.config/limsn/artanis.conf
