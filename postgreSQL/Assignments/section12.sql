SELECT * FROM ORDERS
WHERE customerid='VINET';

INSERT INTO orders
(orderid,customerid,employeeid,orderdate,requireddate,
shipvia,freight,shipname,shipaddress,shipcity,shippostalcode,shipcountry)
VALUES(11078,'VINET',4, '2017-09-16','2017-09-30',3,
	  42.5,'Vins et alcools Chevalier','59 rue de l''Abbaye',
	  'Reims','51100','France');
	  
SELECT * FROM products
WHERE productname LIKE 'Queso%';	  
	  
INSERT INTO order_details(orderid,productid,unitprice,quantity,discount)
VALUES(11078,11,14,20,0);

--UPDATE
UPDATE orders
SET requireddate='2017-09-20',freight=50
WHERE orderid=11078;

UPDATE order_details
SET quantity=40,discount=0.5
WHERE orderid=11078;

SELECT *FROM orders
WHERE orderid=11078;

--DELETE
DELETE FROM order_details
WHERE orderid=11078 AND productid=11;

DELETE FROM orders
WHERE orderid=11078;

--SELECT INTO
SELECT * INTO suppliers_nortamerica
FROM suppliers
WHERE country IN('USA','Canada');

--INSERT INTO SELECT
INSERT INTO suppliers_nortamerica
SELECT * 
FROM suppliers
WHERE country IN('Brazil','Argentina');


INSERT INTO orders_1997
SELECT * FROM orders
WHERE orderdate BETWEEN '1996-12-01' AND '1996-12-31';


INSERT INTO employees 
(firstname,lastname,title,employeeid,reportsto)
VALUES('Bob','Smith','Mr Big',50,2)
RETURNING employeeid;

INSERT INTO orders
(customerid,employeeid,requireddate,shippeddate,orderid)
VALUES('VINET',5,'1996-08-01','1996-08-10',501)
RETURNING orderid;



UPDATE products
SET unitprice=unitprice*1.2
WHERE productid=1
RETURNING productid,unitprice AS new_price;

UPDATE order_details
SET quantity =quantity *2
WHERE orderid=10248 AND productid=11
RETURNING quantity AS new_quantity;

DELETE FROM employees
WHERE employeeid=50
RETURNING  *;

DELETE FROM orders 
WHERE orderid=500
RETURNING *;


