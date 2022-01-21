section 10&11
--INTERSECT
--find all countries that we have both customers and suppliers in 
SELECT country FROM customers 
INTERSECT
SELECT country FROM suppliers;

--Find the no.of customer and supplier pairs that are in the same country 
SELECT COUNT(*) FROM
(SELECT country FROM customers 
INTERSECT ALL
SELECT country FROM suppliers)AS together;

--Distinct cities that we have a supplier and customer located in
SELECT city FROM customers 
INTERSECT
SELECT city FROM suppliers;

--the count of the no.of customers and suppliers pairs that are in the same city
SELECT COUNT(*) FROM
(SELECT city FROM customers 
INTERSECT ALL
SELECT city FROM suppliers)AS together;

--EXCEPT
--FIND all countries that we customers in but no suppliers
SELECT country FROM customers
EXCEPT 
SELECT country FROM suppliers;

--find the no.of customer that are in a country without suppliers
SELECT COUNT(*) FROM
(SELECT country FROM customers 
EXCEPT ALL
SELECT country FROM suppliers)AS lonely_customers;

--cities we have a supplier with no customer
SELECT city FROM  suppliers
EXCEPT
SELECT city FROM customers;

--how many customers do we have in cities without suppliers
SELECT COUNT (*) FROM 
(SELECT city FROM customers
EXCEPT ALL
SELECT city FROM suppliers)AS lonely_customers;

--EXISTS
--Find customers with an order in April,1997
SELECT companyname
FROM customers
WHERE EXISTS
(SELECT customerid FROM orders 
WHERE orders.customerid=customers.customerid AND orderdate BETWEEN '1997-04-01' AND '1997-04-30');

--you could have done that with join ...but how would you find customers who didn't have an order in April,1997?
SELECT companyname
FROM customers
WHERE  NOT EXISTS
(SELECT customerid FROM orders 
WHERE orders.customerid=customers.customerid AND orderdate BETWEEN '1997-04-01' AND '1997-04-30');

--your can have joins in subquery..what products didn't have an order in April,1997?
SELECT productname
FROM  products
WHERE  NOT EXISTS
(SELECT productid FROM order_details 
 JOIN orders ON orders.orderid=order_details.orderid
WHERE order_details.productid=products.productid AND orderdate BETWEEN '1997-04-01' AND '1997-04-30');

--find all suppliers with a product that costs more than $200?
SELECT companyname 
FROM suppliers
WHERE EXISTS
(SELECT productid FROM products
WHERE products.supplierid=suppliers.supplierid AND unitprice>200);

--find all suppliers that dont have an order in December 1996
SELECT companyname 
FROM suppliers
WHERE EXISTS
(SELECT products.productid FROM products
 JOIN order_details ON order_details.productid=products.productid
 JOIN orders ON orders.orderid=order_details.orderid
WHERE products.supplierid=suppliers.supplierid AND orderdate BETWEEN '1996-12-01' AND '1996-12-31');


--with an order detail with more than 50 items in a single product
SELECT companyname
FROM customers
WHERE customerid=ANY (SELECT customerid FROM orders
					 JOIN order_details ON orders.orderid=order_details.orderid
					 WHERE quantity > 50);


--find all suppliers that have had an order with 1 item
SELECT companyname
FROM suppliers
WHERE supplierid=ANY (SELECT products.supplierid FROM order_details
					 JOIN products ON products.productid=order_details.productid
					 WHERE quantity =1);
 
--find products ...which had order amounts that were higher than the average of all the products
SELECT DISTINCT productname
FROM products
JOIN order_details ON products.productid=order_details.productid
WHERE order_details.unitprice*quantity > ALL
(SELECT AVG(order_details.unitprice*quantity)
	FROM order_details
	GROUP BY productid);



--find all distinct customers that ordered more in one item than the avg order amount per item of all customers?
SELECT DISTINCT companyname
FROM customers
JOIN orders ON orders.customerid=customers.customerid
JOIN order_details ON orders.orderid=order_details.orderid
WHERE order_details.unitprice*quantity > ALL
(SELECT AVG(order_details.unitprice*quantity)
	FROM order_details
 	JOIN orders ON orders.orderid=order_details.orderid
	GROUP BY customerid);

--IN subquery
--FIND customers...that are in the same countries as the suppliers
SELECT companyname
FROM suppliers
WHERE city IN(SELECT city FROM customers);


--











