--init db a
 
-- https://dba.stackexchange.com/questions/117109/how-to-manage-default-privileges-for-users-on-a-database-vs-schema/117661#117661
-- login initially:   psql -U postgres -h 192.168.1.7


CREATE USER ln_admin WITH PASSWORD 'welcome' CREATEDB CREATEROLE; -- see below
CREATE USER ln_user   WITH PASSWORD 'welcome';

GRANT ln_user TO ln_admin;

