#!/bin/sh



mkdir lndata

echo "export PGDATA=\"/home/admin/lndata\"" >> /home/admin/.bashrc
export PGDATA="/home/admin/lndata"


initdb -D /home/admin/lndata

cp /home/admin/limsn/limsn/postgres/pg_hba.conf /home/admin/lndata
cp /home/admin/limsn/limsn/postgres/pg_ident.conf /home/admin/lndata
cp /home/admin/limsn/limsn/postgres/postgresql.conf /home/admin/lndata

pg_ctl -D /home/admin/lndata -l logfile start

psql -U admin -h 127.0.0.1 postgres -a -f /home/admin/limsn/limsn/postgres/initdba.sql
psql -U admin -h 127.0.0.1 lndb -a -f /home/admin/limsn/limsn/postgres/initdbb.sql
psql -U ln_admin -h 127.0.0.1 -d lndb -a -f /home/admin/limsn/limsn/postgres/create-db.sql
psql -U ln_admin -h 127.0.0.1 -d lndb -a -f /home/admin/limsn/limsn/postgres/example-data.sql


