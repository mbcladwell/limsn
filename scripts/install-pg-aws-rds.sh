#!/bin/sh

PATH_INTO_STORE=abcdefgh/share/guile/site/3.0/limsn/postgres
   
 host=$1
 password=$2
 
psql postgresql://postgres:$2@$1:5432/postgres  -f $PATH_INTO_STORE/initdba.sql
psql postgresql://ln_admin:welcome@$1:5432/postgres  -f $PATH_INTO_STORE/initdbb.sql
psql postgresql://ln_admin:welcome@$1:5432/lndb  -f $PATH_INTO_STORE/initdbc.sql
psql postgresql://ln_admin:welcome@$1:5432/lndb  -f $PATH_INTO_STORE/initdbc.sql
psql postgresql://ln_admin:welcome@$1:5432/lndb  -f $PATH_INTO_STORE/create-db.sql
psql postgresql://ln_admin:welcome@$1:5432/lndb  -f $PATH_INTO_STORE/example-data.sql

 
