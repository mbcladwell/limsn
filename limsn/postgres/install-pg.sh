#!/bin/sh

mkdir lndata

echo "export PGDATA=\"$HOME/lndata\"" >> $HOME/.bashrc
export PGDATA="$HOME/lndata"
export LC_ALL="C"

sudo mkdir -p /var/run/postgresql
sudo chown -R admin:admin /var/run/postgresql
initdb -D $HOME/lndata
    
sed -i 's/\#listen_addresses =/listen_addresses =/'  $HOME/lndata/postgresql.conf

pg_ctl -D $HOME/lndata -l logfile start
 
 psql -U admin -h 127.0.0.1 postgres -a -f initdba.sql
 psql -U ln_admin -h 127.0.0.1 postgres -a -f initdbb.sql
 psql -U ln_admin -h 127.0.0.1 -d lndb -a -f initdbc.sql
 psql -U ln_admin -h 127.0.0.1 -d lndb -a -f create-db.sql
 psql -U ln_admin -h 127.0.0.1 -d lndb -a -f example-data.sql


