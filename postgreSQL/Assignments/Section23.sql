Composite Type Basics:
create a composite
CREATE TYPE name AS(
	field1 datatype,
	field2 datatype,
	.....
)
No connstraints just field names and data types.
EX:
Lets create an address composite type
CREATE TYPE address AS (
	street_address varchar(50),
	street_address2 varchar(50),
	city varchar(50),
	state_region varchar(50),
	country varchar(50),
	postalcode varchar(15)
);

--create a table for friends and use the composite type.
CREATE TABLE friends(
	first_name varchar(50),
	last_name varchar(50),
	address address
);

--REMOVE A COMPOSITE
DROP IF EXISTS TYPE name;
find must remove columns that uses the composite or use CASCADE
DROP IF EXISTS TYPE name CASCADE;

DROP TABLE friends;

CREATE TYPE full_name AS (
	first_name varchar(50),
	middle_name varchar(50),
	last_name varchar(50)
);

CREATE TYPE address AS(
	street_address varchar(50),
	street_address2 varchar(50),
	city varchar(50),
	state_region varchar(50),
	country varchar(50),
	postalcode varchar(15)
);

CREATE TABLE friends(
	name full_name,
	address address
);

--Remove Types:
--Drop both types and the table friends
DROP TYPE full_name CASCADE;

DROP TYPE address CASCADE;
DROP TABLE friends;

--Using composite types:
2 ways to construct composites
with quotes abd double quotes
'("Will","W","Bunker")'
OR much easier way ROW operator
ROW('Will','W','Bunker')

INSERT INTO friends (name,address,specialdates)
VALUES(ROW('Boyd','M','Gregory'),ROW('7777','Boise','Idaho','USA','99999'),
	  ROW('1969-02-01',49,'2001-07-15'));
	  
SELECT * FROM friends;

SELECT name FROM friends;

--Accessing composite columns
Must surround the composite column name in quotes.
SELECT (type).column_name FROM table_name

--pull back the city and birthdate from friends
SELECT(address).city,(specialdates).birthdate FROM friends;

--Use in where clause
--select all friends whose first name is Boyd


SELECT (address).city,(specialdates).birthdate
FROM friends
WHERE (name).first_name='Boyd';

--select state,middle name,age of everyone whose last name is Gregory
SELECT(address).state_region,(specialdates).age,(name).middle_name
FROM friends
WHERE (name).last_name='Gregory';