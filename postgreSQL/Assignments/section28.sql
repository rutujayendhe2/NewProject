--Build your first trigger
must have no arguments and return type is trigger

	CREATE FUNCTION name()RETURNS trigger AS $$
	BUILD 
	....
	END;
	$$ LANGUAGE plpgsql;

--Function return value:
either a null or a record/row value having the structure of the table the trigger was fired for.

--Two variables that help:
for insert/update triggers - NEW - holds the new database row
for update/delete triggers - OLD - holds the old database row

Example:
--one simple task that triggers are used for is to update timestamps every time a record is changed.lets build one for emp database
ALTER TABLE employees
ADD COLUMN last_updated timestamp;

CREATE OR REPLACE FUNCTION employees_timestamp()RETURNS trigger AS $$
BEGIN
	NEW.last_updated := now();
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--Create Trigger:
CREATE TRIGGER trigger_name conditions ON table_name
	FOR EACH ROW EXECUTE FUNCTION function_name();

--Conditions:
BEFORE or AFTER
INSERT,UPDATE,or DELETE

Example:
--we want to always update last_update to current time,so will need to be before insert and update
DROP TRIGGER IF EXISTS employees_timestamp ON employees;

CREATE TRIGGER employees_timestamp BEFORE INSERT OR UPDATE ON employees
FOR EACH ROW EXECUTE FUNCTION employees_timestamp();

UPDATE employees
SET address='33 West Spring Road'
WHERE employeeid=1;

SELECT last_updated,*
FROM employees
WHERE employeeid=1; 

--Add a last_updated to products table and create a function and trigger that updates the field every time there is a change.
ALTER TABLE products
ADD COLUMN last_updated timestamp;

CREATE OR REPLACE FUNCTION prodcuts_timestamp() RETURNS trigger AS $$
BEGIN
	NEW.last_updated := now();
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS products_timestamp ON products;

CREATE TRIGGER prodcuts_timestamp BEFORE INSERT OR UPDATE ON products
FOR EACH ROW EXECUTE FUNCTION prodcuts_timestamp();


UPDATE products
SET unitprice=19.00
WHERE productid=2;

SELECT last_updated,*
FROM products
WHERE productid=2;

--statement triggers:
--Run trigger for single statement
versus each row
FOR EACH STATEMENT EXECUTE FUNCTION function_name();

--How to access information
OLD and NEW wont work at the statement level,could have many rows.
REFERENCES NEW TABLE AS new_name
REFERENCES OLD TABLE AS old_name
REFERENCES OLD TABLE AS old_name NEW TABLE AS new_name

--how to tell the operation type
how do you know in procedure if INSERT,UPDATE or DELETE was called?
Variable:TG_OP

--another useful function
current_uesr()

Example:
--lets create an audit table for order_details and insert changed information into this audit table when insert,delete or update happens.

CREATE TABLE order_detail_audit(
	operation char(1) NOT NULL,
	userid text NOT NULL,
	stamp timestamp NOT NULL,
	orderid smallint NOT NULL,
	productid smallint NOT NULL,
	unitprice real NOT NULL,
	quantity smallint NOT NULL,
	discount real
);

CREATE OR REPLACE FUNCTION audit_order_details() RETURNS trigger AS $$
BEGIN
	IF (TG_OP = 'DELETE') THEN
		INSERT INTO order_details_audit
		SELECT 'D',user,now(),o.*FROM old_table o;
	ELSIF (TG_OP = 'UPDATE')THEN
		INSERT INTO order_details_audit
		SELECT 'U',user,now(),o.*FROM new_table o;
	ELSIF (TG_OP = 'INSERT')THEN
		INSERT INTO order_details_audit
		SELECT 'I',user,now(),o.*FROM new_table o;
	END IF;
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;



DROP TRIGGER IF EXISTS audit_order_details_insert ON order_details;

CREATE TRIGGER audit_order_details_insert AFTER INSERT ON order_details
REFERENCING NEW TABLE AS new_table
FOR EACH STATEMENT EXECUTE FUNCTION audit_order_details();

DROP TRIGGER IF EXISTS audit_order_details_update ON order_details;

CREATE TRIGGER audit_order_details_update AFTER UPDATE ON order_details
REFERENCING NEW TABLE AS new_table
FOR EACH STATEMENT EXECUTE FUNCTION audit_order_details();

DROP TRIGGER IF EXISTS audit_order_details_delete ON order_details;

CREATE TRIGGER audit_order_details_delete AFTER DELETE ON order_details
REFERENCING OLD TABLE AS old_table
FOR EACH STATEMENT EXECUTE FUNCTION audit_order_details();


DROP TRIGGER IF EXISTS audit_order_details_insert ON order_details;

CREATE TRIGGER audit_order_details_insert AFTER INSERT ON order_details
REFERENCING NEW TABLE AS new_table
FOR EACH STATEMENT EXECUTE FUNCTION audit_order_details();

DROP TRIGGER IF EXISTS audit_order_details_update ON order_details;

CREATE TRIGGER audit_order_details_update AFTER UPDATE ON order_details
REFERENCING NEW TABLE AS new_table
FOR EACH STATEMENT EXECUTE FUNCTION audit_order_details();

DROP TRIGGER IF EXISTS audit_order_details_delete ON order_details;

CREATE TRIGGER audit_order_details_delete AFTER DELETE ON order_details
REFERENCING OLD TABLE AS old_table
FOR EACH STATEMENT EXECUTE FUNCTION audit_order_details();

INSERT INTO order_details
VALUES (10248, 3, 10, 5, 0);


UPDATE order_details
SET discount = 0.05
WHERE orderid = 10248 AND productid=3;

DELETE FROM order_details
WHERE orderid=10248 AND productid=3;

SELECT * FROM order_details_audit;

INSERT INTO order_details
SELECT  orderid,productid,unitprice,quantity,discount FROM order_details_audit
WHERE operation ='D' AND orderid NOT IN(10248);

--Create an audit trail for orders using the same three steps of creating table,function and triggers.

CREATE TABLE orders_audit(
	
	operation char(1) NOT NULL,
	userid text NOT NULL,
	stamp timestamp,
    orderid smallint NOT NULL ,
    customerid bpchar,
    employeeid smallint,
    orderdate date,
    requireddate date,
    shippeddate date,
    shipvia smallint,
    freight real,
    shipname character varying(40) ,
    shipaddress character varying(60) ,
    shipcity character varying(15) ,
    shipregion character varying(15),
    shippostalcode character varying(10) ,
    shipcountry character varying(15) 

);

CREATE OR REPLACE FUNCTION audit_orders() RETURNS trigger AS $$
BEGIN
	IF (TG_OP = 'INSERT')THEN
		INSERT INTO orders_audit
		SELECT 'I',user,now(),n.* FROM new_table n;
    ELSIF (TG_OP = 'UPDATE')THEN
		INSERT INTO orders_audit
		SELECT 'U',user,now(),n.* FROM new_table n;
	ELSIF (TG_OP = 'DELETE')THEN
		INSERT INTO orders_audit
		SELECT 'D',user,now(),n.* FROM old_table n;
	END IF;
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS audit_orders_insert ON orders;

CREATE TRIGGER audit_orders_insert AFTER INSERT ON orders
REFERENCING NEW TABLE AS new_table
FOR EACH STATEMENT EXECUTE FUNCTION audit_orders();
			
DROP TRIGGER IF EXISTS audit_orders_delete ON orders;

CREATE TRIGGER audit_orders_delete AFTER DELETE ON orders
REFERENCING OLD TABLE AS old_table
FOR EACH STATEMENT EXECUTE FUNCTION audit_orders();

DROP TRIGGER IF EXISTS audit_orders_update ON orders;

CREATE TRIGGER audit_orders_update AFTER UPDATE ON orders
REFERENCING NEW TABLE AS new_table
FOR EACH STATEMENT EXECUTE FUNCTION audit_orders();

						















