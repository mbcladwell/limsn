--init db
 
-- https://dba.stackexchange.com/questions/117109/how-to-manage-default-privileges-for-users-on-a-database-vs-schema/117661#117661
-- login initially:   psql -U postgres -h 192.168.1.7


CREATE USER ln_admin WITH PASSWORD 'welcome' CREATEDB CREATEROLE; -- see below
CREATE USER ln_user   WITH PASSWORD 'welcome';

GRANT ln_user TO ln_admin;

CREATE DATABASE lndb;
REVOKE ALL ON DATABASE lndb FROM public;  -- see notes below!

GRANT CONNECT ON DATABASE lndb TO ln_user;  -- others inherit

--Must connect to lndb here
\connect lndb  -- psql syntax

--I am naming the schema lims_nucleus (not lndb which would be confusing). Pick any name. Optionally make ln_admin the owner of the schema:

CREATE SCHEMA lims_nucleus AUTHORIZATION ln_admin;
GRANT ALL ON SCHEMA lims_nucleus TO ln_admin;


ALTER DATABASE lndb SET search_path = lims_nucleus;  -- see notes

ALTER ROLE ln_admin IN DATABASE lndb SET search_path = lims_nucleus; -- not inherited
ALTER ROLE ln_user   IN DATABASE lndb SET search_path = lims_nucleus;

GRANT USAGE  ON SCHEMA lims_nucleus TO ln_user;
-- GRANT USAGE  ON SCHEMA lims_nucleus TO ln_admin;
-- GRANT CREATE ON SCHEMA lims_nucleus TO ln_admin;

-- ALTER DEFAULT PRIVILEGES FOR ROLE ln_admin
-- GRANT SELECT, INSERT, UPDATE, DELETE, TRUNCATE  ON TABLES TO ln_admin;  

ALTER DEFAULT PRIVILEGES FOR ROLE ln_user
GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO ln_user;


GRANT TEMPORARY on DATABASE lndb to ln_admin;
GRANT TEMPORARY on DATABASE lndb to ln_user;


set schema 'lims_nucleus';	
--CREATE EXTENSION pgcrypto;
CREATE EXTENSION intarray;
--Once set up:
-- psql -U ln_admin -h 192.168.1.1 -d lndb





