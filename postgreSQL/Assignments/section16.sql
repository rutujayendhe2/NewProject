--NOT NULL CONSTRAINT
1.NOT NUL: FIELD MUST HAVE A VALUE
2.UNIQUE:VALUE MUST NOT ALREADY BE IN TABLE
3.PRIMARY KEY:MUST HAVE VALUE AND BE UNIQUE ,USED TO IDENTIFY RECORD
4.FOREIGN KEY:ALL VALUES MUST EXIST IN ANOTHER TABLE
5.CHECK: CHECKS THAT ALL VALUES MEET CONDITION
6.DEFAULT:IF NO VALUE PROVIDED,VALUE IS SET TO THE DEFAULT

NOT NULL SYNTAX:
CREATE TABLE table_name(
column1 datatype NOT NULL);

CREATE TABLE practices(
	practiceid integer NOT NULL);
	
DROP TABLE practices;

CREATE TABLE practices(
	practiceid integer NOT NULL,
	practice_field varchar(50) NOT NULL);
	
--ALTER TABLE SYNTAX
ALTER TABLE table_name
ALTER COLUMN column_name SET NOT NULL;

ALTER TABLE products 
ALTER unitprice SET NOT NULL; 

ALTER TABLE  employees
ALTER lastname SET NOT NULL; 

--UNIQUE CONSTRAINT
CREATE TABLE table_name(column1 datatype UNIQUE);

DROP TABLE practices;

CREATE TABLE practices(
practiceid integer UNIQUE,
practicefield varchar(50) NOT NULL
);

CREATE TABLE pets(
petid integer UNIQUE,
name varchar(25)NOT NULL);

ALTER TABLE SYNTAX:
ALTER TABLE table_name
ADD CONSTRAINT some_name UNIQUE(column);

ALTER TABLE region 
ADD CONSTRAINT regiondescription_region UNIQUE (regiondescription);

ALTER TABLE shippers 
ADD CONSTRAINT companyname_shippers UNIQUE (companyname);

--PRIMARY KEY CONSTRAINT SYNTAX
CREATE TABLE table_name(column1 datatype PRIMARY KEY);
 EQUIVALENT TO:UNIQUE NOT NULL
 
CREATE TABLE practices(
practiceid integer PRIMARY KEY,
fieldname varchar (50) NOT NULL);

INSERT INTO practices(practiceid,fieldname)
VALUES(null,'something');

--ERROR:  null value in column "practiceid" of relation "practices" violates not-null constraint
--DETAIL:  Failing row contains (null, something).
--SQL state: 23502

INSERT INTO practices(practiceid,fieldname)
VALUES(1,'red');

DROP TABLE pets;

CREATE TABLE pets(
petid integer PRIMARY KEY,
name varchar (25) NOT NULL);

--ALTER TABLE SYNTAX
ALTER TABLE table_name
ADD PRIMARY KEY(column);

ALTER TABLE table_name
DROP CONSTRAINT column_pkey;
EXAMPLES:
ALTER TABLE practices
DROP CONSTRAINT practices_pkey;

ALTER TABLE practices
ADD PRIMARY KEY (practiceid);


ALTER TABLE pets
DROP CONSTRAINT pets_pkey;

ALTER TABLE pets
ADD PRIMARY KEY (petid);

--FOREIGN KEY CONSTRAINT SYNTAX
CREATE TABLE table_name(
col1 datatype,
col2 datatype,
....,
FOREIGN KEY (column_name)REFERENCES table2(col_name));


example:

DROP TABLE practices;

CREATE TABLE practices(
practiceid integer primary key,
fieldname varchar(50)NOT NULL,
employeeid integer NOT NULL,
FOREIGN KEY (employeeid)REFERENCES employees (employeeid) );

DROP TABLE pets;

CREATE TABLE pets(
petid integer primary key,
name varchar(25)NOT NULL,
customerid char(5) NOT NULL,
FOREIGN KEY (customerid)REFERENCES customers (customerid) );

--ALTER TABLE SYNTAX
ALTER TABLE table_name
ADD CONSTRAINT constraint_name
FOREIGN KEY (column)REFERENCES table2(col);

ALTER TABLE table_name
DROP CONSTRAINT constraint_name;

Example:
ALTER TABLE practices
DROP CONSTRAINT practices_employeeid_fkey;

ALTER TABLE practices
ADD CONSTRAINT practices_employeeid_fkey
FOREIGN KEY(employeeid) REFERENCES employees (employeeid);

ALTER TABLE pets
DROP CONSTRAINT pets_customerid_fkey;

--CHECK CONSTRAINT 
CREATE TABLE table_name(
col1 datatype,
col2 datatype CONSTRAINT name CHECK(condition),
....,
CONSTRAINT name CHECK(condition));

EXAMPLES:
CREATE TABLE practices(
	practiceid integer PRIMARY KEY,
	fieldname varchar(50)NOT NULL,
	employeeid integer NOT NULL,
	cost integer CONSTRAINT practices_cost CHECK(cost >= 0 AND cost <= 1000),
	FOREIGN KEY (employeeid)REFERENCES employees(employeeid));
	
INSERT INTO practices(practiceid,fieldname,employeeid,cost)
VALUES(1,'somename',1,1500);

--ERROR:  new row for relation "practices" violates check constraint "practices_cost"
---DETAIL:  Failing row contains (1, somename, 1, 1500).

drop table pets;

CREATE TABLE pets(
	petid integer PRIMARY KEY,
	name varchar(50)NOT NULL,
	customerid char(5) NOT NULL,
	weight integer CONSTRAINT pets_weight CHECK(weight > 0 AND weight < 1000),
	FOREIGN KEY (customerid)REFERENCES customers(customerid));

--ALTER TABLE SYNTAX
ALTER TABLE table_name
ADD CONSTRAINT constraint_name
CHECK(CONDITION);

ALTER TABLE table_name
DROP CONSTRAINT constraint_name;


Example
ALTER TABLE orders 
ADD CONSTRAINT orders_freight CHECK(freight > 0);

ALTER TABLE products 
ADD CONSTRAINT products_unitprice CHECK(unitprice > 0);

--DEFAULT CONSTRAINT SYNTAX
CREATE TABLE table_name(
colmn1 datatype,
column2 datatype DEFAULT value/function,
)

Example:
DROP TABLE practices;

CREATE TABLE practices(
	practiceid integer PRIMARY KEY,
	fieldname varchar(50) NOT NULL,
	employeeid integer NOT NULL,
	cost integer DEFAULT 50 CONSTRAINT practices_cost CHECK (cost >=0 AND cost <=1000),
	FOREIGN KEY(employeeid) REFERENCES employees(employeeid)
); 

DROP TABLE pets;

CREATE TABLE pets(
	petid integer PRIMARY KEY,
	name varchar(50) NOT NULL,
	customerid char(50) NOT NULL,
	weight integer DEFAULT 5 CONSTRAINT pets_weight CHECK (weight >0 AND weight <200),
	FOREIGN KEY(customerid) REFERENCES customers(customerid)
); 

--ALTER TABLE SYNTAX
ALTER TABLE table_name
ALTER COLUMN col_name
SET DEFAULT value;

ALTER TABLE table_name
ALTER COLUMN col_name
DROP DEFAULT;

EXAMPLE:
ALTER TABLE orders
ALTER COLUMN shipvia
SET DEFAULT 1;

ALTER TABLE products
ALTER COLUMN reorderlevel
SET DEFAULT 5;

--BASIC SYNTAX TO ADD OR CHANGE DEFAULT
ALTER TABLE table
ALTER COLUMN column SET DEFAULT new_value;


SYNTAX TO REMOVE DEFAULT
ALTER TABLE tablename
ALTER COLUMN column DROP DEFAULT

Examples:
ALTER TABLE products
ALTER COLUMN reorderlevel
DROP DEFAULT ;

ALTER TABLE products
ALTER COLUMN reorderlevel SET DEFAULT 5;


ALTER TABLE products
ALTER COLUMN reorderlevel
DROP DEFAULT ;

ALTER TABLE suppliers
ALTER COLUMN homepage
DROP DEFAULT ;

--ADDING AND REMOVING A COLUMN CONSTRAINT
ALTER TABLE table_name ADD CHECK (col...)
ALTER TABLE table_name ADD CONSTRAINT c_name UNIQUE(col)
ALTER TABLE table_name ADD FOREIGN KEY (col)REFERENCES tab_name

EXAMPLES:

UPDATE products
SET reorderlevel=0
WHERE reorderlevel is null or reorderlevel<0

ALTER TABLE products
ADD CHECK (reorderlevel >= 0);


--ADD NOT NULL CONSTRAINT
ALTER TABLE table_name ALTER COLUMN col_name SET NOT NULL;

Example:
ALTER TABLE products
ALTER COLUMN discontinued SET NOT NULL;

--SYNTAX FOR REMOVING CONSTRAINT:
ALTER TABLE table_name DROP CONSTRAINT some_name
ALTER TABLE table_name DROP NOT NULL


ALTER TABLE products
DROP CONSTRAINT products_reorderlevel_check;

ALTER TABLE products
ALTER COLUMN discontinued DROP NOT NULL;

ALTER TABLE order_details
ADD CHECK (unitprice > 0);

ALTER TABLE order_details
ALTER COLUMN discount SET NOT NULL;

ALTER TABLE order_details
DROP CONSTRAINT order_details_unitprice_check;

ALTER TABLE order_details
ALTER COLUMN discont DROP NOT NULL;

















