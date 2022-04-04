#! /bin/bash

PATH_INTO_STORE=abcdefgh
export LC_ALL="C"
echo export LC_ALL=\"C\" >> $HOME/.bashrc
echo export PATH="$HOME/bin${PATH:+:}$PATH" >> $HOME/.bashrc
echo export GUILE_LOAD_PATH="$HOME/gnu/store/rj0pzbki1m5hpcshs614mhkrgs2b3i9d-artanis-0.5.2/share/guile/site/3.0:$HOME/gnu/store/780bll8lp0xvj7rnazb2qdnrnb329lbw-guile-json-3.5.0/share/guile/site/3.0:$HOME/gnu/store/jmn100gjcpqbfpxrhrna6gzab8hxkc86-guile-redis-2.1.1/share/guile/site/3.0:$HOME/gnu/store/3f0lv3m4vlzqc86750025arbskfrq05p-guile-dbi-2.1.8/share/guile/site/2.2${GUILE_LOAD_PATH:+:}$GUILE_LOAD_PATH" >> $HOME/.bashrc
echo export GUILE_DBD_PATH="$HOME/gnu/store/z5kilafxayw2kdvn3anw1shkqij17dqb-guile-dbd-postgresql-2.1.8/lib" >> $HOME/.bashrc

mkdir -p $HOME/.config/limsn
cp $PATH_INTO_STORE/share/guile/site/3.0/limsn/conf/artanis.conf $HOME/.config/limsn

echo "Initialization file $HOME/.config/limsn/artanis.conf created and environment variables added to .bashrc"
echo "Log out and log back in to set environment variables"

