--init db b

--Must connect to lndb here
-- psql -U postgres -h 192.168.1.7 lndb

--\connect lndb  -- psql syntax doesn't work as script

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





