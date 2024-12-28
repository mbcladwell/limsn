#! /bin/bash
PATH_INTO_STORE=path-into-store
guile -e main -s $PATH_INTO_STORE/share/guile/site/3.0/limsn/lib/run-lnpg.scm $1 $2 $3 $4 $5 $6 $7

