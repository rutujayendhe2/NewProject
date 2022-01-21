CREATE DATABASE SYNTAX:

CREATE DATABASE northwind2;

--create a second northwind
using the command line
createdb db_name
Ex:
postgres=# createdb fiddlesticks
postgres-# createdb mydb5_bak
postgres-#

DROP DATABASE SYNTAX:

DROP DATABASE IF EXISTS database_name;

--delete second northwind
DROP DATABASE IF EXISTS northwind2;

using the command line:
dropdb db_name;
Ex:
postgres=# dropdb fiddlesticks

--Drop the database mydb5 using SQL and mydb5_bak with command line
DROP DATABASE IF EXISTS mydb5;
postgres-# dropdb mydb5_bak