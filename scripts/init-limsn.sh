#! /bin/bash

PATH_INTO_STORE=abcdefgh
export LC_ALL="C"
export GUIX_EXECUTION_ENGINE=performance
echo export LC_ALL=\"C\" >> $HOME/.bashrc
echo export PATH="$HOME/bin${PATH:+:}$PATH"
echo export GUIX_EXECUTION_ENGINE=performance

mkdir -p $HOME/.config/limsn
cp $PATH_INTO_STORE/share/guile/site/3.0/limsn/conf/artanis.conf $HOME/.config/limsn

