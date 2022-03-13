--init db b
 

CREATE DATABASE lndb;
REVOKE ALL ON DATABASE lndb FROM public;  -- see notes below!

GRANT CONNECT ON DATABASE lndb TO ln_user;  -- others inherit

--Must connect to lndb here see initdbb


