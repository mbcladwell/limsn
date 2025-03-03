#!/bin/sh

PATH_INTO_STORE=pathintostore/share/guile/site/3.0/limsn/postgres
   
 psql -U $1 -h 127.0.0.1 postgres -a -f $PATH_INTO_STORE/initdba.sql
 psql -U ln_admin -h 127.0.0.1 postgres -a -f $PATH_INTO_STORE/initdbb.sql
 psql -U ln_admin -h 127.0.0.1 -d lndb -a -f $PATH_INTO_STORE/initdbc.sql
 psql -U ln_admin -h 127.0.0.1 -d lndb -a -f $PATH_INTO_STORE/create-db.sql
 psql -U ln_admin -h 127.0.0.1 -d lndb -a -f $PATH_INTO_STORE/example-data.sql

