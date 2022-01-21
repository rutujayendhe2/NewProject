CREATE A SEQUENCE DIRECTLY
-CREATE SEQUENCE IF NOT EXISTS name
Example:
CREATE SEQUENCE test_sequence

--See What Current Value is
SELECT currval('test_sequence')

--See Most Recent nextval
SELECT lastval()

--SET THE VALUE
//set value but next value will increment
SELECT setval('test_sequence',14);
SELECT nextval('test_sequence');

//set value and next value will be what you set
SELECT setval('test_sequence',25,false);
SELECT nextval('test_sequence');

--CONTROL THE SPACING OF VALUES
CREATE SEQUENCE IF NOT EXISTS test_sequence2 INCREMENT 5
 
--FULL CONTROL
CREATE SEQUENCE IF NOT EXISTS test_sequence3
INCREMENT 50
MINVALUE 30
MAXVALUE 5000
START WITH 550

--ATTACHING SEQUENCE TO A FIELD
CREATE SEQUENCE name OWNED BY table_name.col_name

--LET'S ADD ONE TO EMPLOYEES
SELECT MAX(employeeid)FROM employees

CREATE SEQUENCE IF NOT EXISTS employees_employeeid_seq
START WITH 10 OWNED BY employees.employeeid

WHAT IF YOU NEED ID VALUE?
-USE RETURNING syntax on insert statement 
INSERT INTO users(name,age)VALUES('Liszt',10) RETURNING id



CREATE SEQUENCE test_sequnece;

SELECT nextval('test_sequnece');

SELECT currval('test_sequnece')

SELECT lastval();

SELECT setval('test_sequnece',14);

SELECT nextval('test_sequnece');

SELECT setval('test_sequnece',25,false);

SELECT nextval('test_sequnece');


CREATE SEQUENCE IF NOT EXISTS test_sequence2 INCREMENT 5;
SELECT nextval('test_sequence2');

CREATE SEQUENCE IF NOT EXISTS test_sequence3
INCREMENT 50
MINVALUE 30
MAXVALUE 5000
START WITH 550;

SELECT nextval('test_sequence3');

CREATE SEQUENCE IF NOT EXISTS test_sequence4
INCREMENT 7
START WITH 33;

SELECT nextval('test_sequence4');


SELECT MAX(employeeid)FROM employees;


CREATE SEQUENCE IF NOT EXISTS employees_employeeid_seq
START WITH 10 OWNED BY employees.employeeid

INSERT INTO employees(lastname,firstname,title,reportsto)
VALUES('Smith','Bob','Assistant',2);

--ERROR:  null value in column "employeeid" of relation "employees" violates not-null constraint
--DETAIL:  Failing row contains (null, Smith, Bob, Assistant, null, null, null, null, null, null, null, null, null, null, null, null, 2, 

ALTER TABLE employees
ALTER COLUMN employeeid SET DEFAULT nextval('employees_employeeid_seq');

SELECT * FROM employees;

INSERT INTO employees
(lastname,firstname,title,reportsto)
VALUES('Smith','Bob','Assistant',2)
RETURNING employeeid;


SELECT MAX(orderid)FROM orders;

CREATE SEQUENCE IF NOT EXISTS orders_orderid_seq
START WITH 11078;

ALTER TABLE orders
ALTER COLUMN orderid SET DEFAULT nextval('orders_orderid_seq');

INSERT INTO orders
(customerid,employeeid,requireddate,shippeddate)
VALUES('VINET',5,'1996-08-01','1996-08-06')
RETURNING orderid;

--ALTER AND DELETE SEQUENCES
SYNTAX TO CHANGE SEQUENCE
ALTER SEQUENCE name RESTART WITH start
ALTER SEQUENCE name RENAME TO new_name
EXAMPLE:
ALTER SEQUENCE employees_employeeid_seq RESTART WITH 1000;

SELECT nextval('employees_employeeid_seq');

ALTER SEQUENCE orders_orderid_seq RESTART WITH 200000;
SELECT nextval('orders_orderid_seq');

--CHANGE NAME OF SEQUENCE
change test_sequence to test_sequence_1;

EXAMPLES:
ALTER SEQUENCE employees_employeeid_seq RESTART WITH 1000;

SELECT nextval('employees_employeeid_seq');

ALTER SEQUENCE orders_orderid_seq RESTART WITH 200000;
SELECT nextval('orders_orderid_seq');

ALTER SEQUENCE  test_sequnece RENAME TO test_sequnece_1;

ALTER SEQUENCE test_sequence4 RENAME TO test_sequnece_four;

--SYNTAX TO REMOVE A SEQUENCE
DROP SEQUENCE name;

EXAMPLE:
DROP SEQUENCE test_sequnece_1;

DROP SEQUENCE test_sequnece_four;

--USING SERIAL DATATYPES

--USED TO INCREMENT ID FIELDS AUTOMAGICALLY
smallserial-small int that increments automatically
serial-int that increments automatically
bigserial-bigint that increments automatically

CREATE TABLE tablename(
idfield SERIAL
);

EQUIVALENT TO
CREATE SEQUENCE tablename_columnname_seq;

CREATE TABLE tablename(
	colname integer NOT NULL DEFAULT nextval('tablename_colname_seq') 
);

ALTER SEQUENCE tablename_columnname_seq OWNED BY tablename.colname;

Example:
DROP SEQUENCE test_sequnece_1;

DROP SEQUENCE test_sequnece_four;

DROP TABLE IF EXISTS exes;

CREATE TABLE exes(
	exid SERIAL,
	name varchar(255)
);

INSERT INTO exes (name) VALUES ('Carrie') RETURNING exid;

DROP TABLE IF EXISTS pets;

CREATE TABLE pets(
	petid SERIAL,
	name varchar(255)
);

INSERT INTO pets (name) VALUES ('Fluffy') RETURNING petid;
INSERT INTO pets (name) VALUES ('Gruffy') RETURNING petid;

















