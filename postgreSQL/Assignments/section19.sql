--Views -HOW TO CREATE 
--SYNTAX
CREATE VIEW view_name AS
SELECT statement
Example:
--create a view called customer_order_details that links customers,orders, and order_details
CREATE VIEW customer_order_details AS
SELECT companyname,orders.customerid,employeeid,requireddate,shippeddate,shipvia,freight,shipname,shipregion,
shippostalcode,shipcountry,
order_details.*
FROM customers
JOIN orders ON customers.customerid=orders.customerid
JOIN order_details ON orders.orderid=order_details.orderid;

SELECT *
FROM customer_order_details
WHERE customerid='TOMSP';

--create a view called supplier_order_details that will show all orders and order_details
--then select all the order details for supplierid=5
CREATE VIEW supplier_order_details AS
SELECT companyname,suppliers.supplierid,
products.productid,productname,order_details.unitprice,quantity,discount,
orders.*
FROM suppliers
JOIN products ON suppliers.supplierid=products.supplierid
JOIN order_details ON order_details.productid=products.productid
JOIN orders ON order_details.orderid=orders.orderid

SELECT *
FROM supplier_order_details
WHERE supplierid=5;

--VIEWS -HOW TO MODIFY
--BASIC SYNTAX
CREATE OR REPLACE VIEW view_name AS SELECT query

--Add contactname to customer_order_details from previous lecture
CREATE OR REPLACE VIEW public.customer_order_details
 AS
 SELECT customers.companyname,
    orders.customerid,
    orders.employeeid,
    orders.requireddate,
    orders.shippeddate,
    orders.shipvia,
    orders.freight,
    orders.shipname,
    orders.shipregion,
    orders.shippostalcode,
    orders.shipcountry,
    order_details.orderid,
    order_details.productid,
    order_details.unitprice,
    order_details.quantity,
    order_details.discount,
	customers.contactname
   FROM customers
     JOIN orders ON customers.customerid = orders.customerid
     JOIN order_details ON orders.orderid = order_details.orderid;


SELECT * FROM customer_order_details;

SELECT * FROM customer_order_details
WHERE customerid='TOMSP';


--Add contactname to customer_order_details from previous lecture
CREATE OR REPLACE VIEW public.customer_order_details
 AS
 SELECT customers.companyname,
    orders.customerid,
    orders.employeeid,
    orders.requireddate,
    orders.shippeddate,
    orders.shipvia,
    orders.freight,
    orders.shipname,
    orders.shipregion,
    orders.shippostalcode,
    orders.shipcountry,
    order_details.orderid,
    order_details.productid,
    order_details.unitprice,
    order_details.quantity,
    order_details.discount,
	customers.contactname
   FROM customers
     JOIN orders ON customers.customerid = orders.customerid
     JOIN order_details ON orders.orderid = order_details.orderid;


SELECT * FROM customer_order_details;

SELECT * FROM customer_order_details
WHERE customerid='TOMSP';

--Add phone to the supplier_order_details view you created in last exercise
CREATE OR REPLACE VIEW public.supplier_order_details
 AS
 SELECT suppliers.companyname,
    suppliers.supplierid,
    products.productid,
    products.productname,
    order_details.unitprice,
    order_details.quantity,
    order_details.discount,
    orders.orderid,
    orders.customerid,
    orders.employeeid,
    orders.orderdate,
    orders.requireddate,
    orders.shippeddate,
    orders.shipvia,
    orders.freight,
    orders.shipname,
    orders.shipaddress,
    orders.shipcity,
    orders.shipregion,
    orders.shippostalcode,
    orders.shipcountry,
	suppliers.phone
   FROM suppliers
     JOIN products ON suppliers.supplierid = products.supplierid
     JOIN order_details ON order_details.productid = products.productid
     JOIN orders ON order_details.orderid = orders.orderid;

SELECT * FROM supplier_order_details
WHERE supplierid=5;

--Change Name Of View
ALTER VIEW old_name RENAME TO new_name

--Change view customer_order_details to customer_order_detailed
ALTER VIEW customer_order_details RENAME TO customer_order_detailed;

ALTER VIEW supplier_order_details RENAME TO supplier_orders;


--Creating updatable views

--create a view of customers called north_america_customers for all customers from USA,Canada,Mexico
CREATE VIEW north_america_customers AS
SELECT *
FROM customers
WHERE country IN('USA','Canada','Mexico');

INSERT INTO north_america_customers
(customerid,companyname,contactname,contacttitle,address,city,region,postalcode,country,phone,fax)
VALUES('CFDCM','CatFish Dot Con','Will Bunker','President','Old Country Road','Lake Village','AR','77777','USA','555-555-5555',null)

SELECT * FROM north_america_customers
WHERE customerid='CFDCM';

UPDATE north_america_customers
SET fax='555-333-444'
WHERE customerid='CFDCM';

DELETE FROM north_america_customers
WHERE customerid='CFDCM';

--Create a updatable view of all products that are in Dairy Products,Meat/Poultry,and Seafood categories(categoryid of 4,6,&8).
--call this protein_products.
--Test that you can modify.
--create a view of customers called north_america_customers for all customers from USA,Canada,Mexico
CREATE VIEW north_america_customers AS
SELECT *
FROM customers
WHERE country IN('USA','Canada','Mexico');

INSERT INTO north_america_customers
(customerid,companyname,contactname,contacttitle,address,city,region,postalcode,country,phone,fax)
VALUES('CFDCM','CatFish Dot Con','Will Bunker','President','Old Country Road','Lake Village','AR','77777','USA','555-555-5555',null)

SELECT * FROM north_america_customers
WHERE customerid='CFDCM';

UPDATE north_america_customers
SET fax='555-333-444'
WHERE customerid='CFDCM';

DELETE FROM north_america_customers
WHERE customerid='CFDCM';


DROP VIEW IF EXISTS supplier_orders;

CREATE VIEW protein_products AS
SELECT *
FROM products
WHERE categoryid IN(4,6,5);

SELECT * FROM protein_products;

INSERT INTO protein_products
(productid,productname,supplierid,categoryid,discontinued)
VALUES(78,'Kobe Beef',12,8,0);

UPDATE protein_products
SET unitprice=55
WHERE productid=78;


DELETE FROM protein_products
WHERE productid=78;

--with check option

INSERT INTO north_america_customers
(customerid,companyname,contactname,contacttitle,address,city,region,postalcode,country,phone,fax)
VALUES('CFDCH','CatFish Dot Con','Will Bunker','President','Old Country Road','Berlin',null,'33333','Germany',null,null);

SELECT * FROM north_america_customers
WHERE customerid='CFDCH';

SELECT * FROM customers
WHERE customerid='CFDCH';

DELETE FROM customers
WHERE customerid='CFDCH';

--HOW TO PREVENT
USE the WITH CHECK OPTION
2 Version:
WITH LOCAL CHECK OPTION
WITH CASCADED CHECK OPTION

--change north_america_query to check that the country is correct and test.
CREATE OR REPLACE VIEW north_america_customers AS 
SELECT * 
FROM customers
WHERE country IN ('USA','Canada','Mexico')
WITH LOCAL CHECK OPTION;


CREATE OR REPLACE VIEW protein_products AS 
SELECT * 
FROM products
WHERE categoryid IN (4,6,8)
WITH LOCAL CHECK OPTION;

INSERT INTO protein_products
(productid,productname,supplierid,categoryid,discontinued)
VALUES(78,'Tasty Tea',12,1,0);

--DROP VIEW
BASIC SYNTAX:
DROP VIEW view_name
OR
DROP VIEW IF EXISTS view_name

--drop the view customer_order-detailed
DROP  VIEW customer_order_detailed;

DROP  VIEW supplier_orders;






















