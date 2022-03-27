#!/bin/sh

PATH_INTO_STORE=abcdefgh/share/guile/site/3.0/limsn/postgres
. $HOME/.guix-profile/etc/profile
   
mkdir lndata

echo "export PGDATA=\"$HOME/lndata\"" >> $HOME/.bashrc
export PGDATA="$HOME/lndata"
export LC_ALL="C"

sudo mkdir -p /var/run/postgresql
sudo chown -R admin:admin /var/run/postgresql
initdb -D $HOME/lndata
    
sed -i 's/\#listen_addresses =/listen_addresses =/'  $HOME/lndata/postgresql.conf

pg_ctl -D $HOME/lndata -l logfile start
 
 psql -U admin -h 127.0.0.1 postgres -a -f $PATH_INTO_STORE/initdba.sql
 psql -U ln_admin -h 127.0.0.1 postgres -a -f $PATH_INTO_STORE/initdbb.sql
 psql -U ln_admin -h 127.0.0.1 -d lndb -a -f $PATH_INTO_STORE/initdbc.sql
 psql -U ln_admin -h 127.0.0.1 -d lndb -a -f $PATH_INTO_STORE/create-db.sql
 psql -U ln_admin -h 127.0.0.1 -d lndb -a -f $PATH_INTO_STORE/example-data.sql


