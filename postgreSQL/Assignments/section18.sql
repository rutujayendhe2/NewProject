--WITH QUERIES
PURPOSE
CTE-Common Table Expressions define temporary tables that are uesd just for the current query.
Syntax:
WITH name AS(
SELECT statement 
)
SELECT statement that includes name from WITH part

EXAMPLE:
WITH top_category_sales AS(
	SELECT categoryname, SUM (od.unitprice*quantity) AS sales
	FROM categories AS c 
	JOIN products USING (categoryid)
	JOIN order_details AS od USING (productid)
	GROUP BY categoryname
	ORDER BY sales DESC LIMIT 3
)
SELECT * FROM top_category_sales;


WITH top_category_sales AS(
	SELECT categoryname, SUM (od.unitprice*quantity) AS sales
	FROM categories AS c 
	JOIN products USING (categoryid)
	JOIN order_details AS od USING (productid)
	GROUP BY categoryname
	ORDER BY sales DESC LIMIT 3
)
SELECT categoryname,productname,SUM(od.quantity) AS product_units,
	SUM (od.unitprice*quantity) AS product_sales
	FROM categories AS c 
	JOIN products USING (categoryid)
	JOIN order_details AS od USING (productid)
	GROUP BY categoryname,productname
	ORDER BY categoryname;

	
	WITH slowest_products AS(
	SELECT productid, SUM (od.quantity) 
	FROM products  
	JOIN order_details AS od USING (productid)
	GROUP BY productid
	ORDER BY SUM(od.quantity) ASC LIMIT 2
)
SELECT * FROM slowest_products;

WITH slowest_products AS(
	SELECT productid, SUM (od.quantity) 
	FROM products  
	JOIN order_details AS od USING (productid)
	GROUP BY productid
	ORDER BY SUM(od.quantity) ASC LIMIT 2
)
SELECT DISTINCT (companyname)
FROM customers
NATURAL JOIN orders
NATURAL JOIN order_details
WHERE productid IN(SELECT productid FROM slowest_products);




--USING CTE TO GRAB IDENTITY FIELD FROM INSERT

WITH new_order AS(
	INSERT INTO orders
	(customerid,employeeid,orderdate,requireddate)
	VALUES('ALFKI',1,'1997-03-10','1997-03-25')
	RETURNING orderid
)
INSERT INTO order_details(orderid, productid, unitprice, quantity, discount)
SELECT orderid, 1, 20, 5, 0
FROM new_order;

SELECT * FROM orders
ORDER BY orderid DESC
LIMIT 1;

SELECT * FROM order_details
WHERE orderid=(SELECT MAX(orderid) FROM orders);
 
 
 
WITH new_employee AS(
	INSERT INTO employees
	(lastname,firstname,title,reportsto)
	VALUES('Doger','Roger','Assistant',2)
	RETURNING employeeid
)
INSERT INTO orders
(customerid,employeeid,orderdate,requireddate)
SELECT 'ALFKI',employeeid,'1997-03-10','1997-03-25'
FROM new_employee;

SELECT * FROM employees
ORDER BY employeeid DESC
LIMIT 1;

SELECT * FROM orders
ORDER BY orderid DESC
LIMIT 1;


--creating hierarchical data

UPDATE employees
SET reportsto = NULL
WHERE employeeid= 2;


DELETE FROM employees WHERE employeeid > 9;

INSERT INTO employees (firstname,lastname,address,city,country,postalcode,homephone,title,employeeid,reportsto) VALUES
('Josephine','Boyer','463-4613 Ipsum Street','Saint-Prime','USA','73-638','741-0423','CEO',200,NULL),
('Marvin','Cole','P.O. Box 857, 9463 Et St.','Sauris','Philippines','91-806','717-0456','CFO',201,200),
('Lee','Hatfield','Ap #152-543 Facilisis. St.','Baden','Monaco','44981-785','990-7598','CTO',202,200),
('Chancellor','Hubbard','672-2470 Adipiscing Avenue','Chatteris','Macao','79613','1-655-930-7580','Head of Ops',203,200),
('Jakeem','Chaney','177 Mauris Road','Izmir','France','6729','1-849-661-5415','Ops Manager',204,203),
('Paul','Sutton','5572 Morbi St.','Fourbechies','United Kingdom','3072','1-664-924-2966','Ops Manager - Europe',205,203),
('Aaron','Erickson','2646 Sem, Avenue','Olen','USA','9656','1-713-526-0184','Ops Manager - USA',206,203),
('Azalia','Wagner','Ap #543-1195 Mi Av.','Swan Hills','USA','1481','544-1445','Warehouse USA',207,206),
('Elmo','Goodwin','Ap #609-977 Gravida Ave','Frascati','USA','5083','1-281-122-4910','Warehouse USA',208,206),
('Quon','Durham','523 Praesent Rd.','Lutsel K''e','USA','40535-562','951-4455','Warehouse USA',209,206),
('Keaton','Weber','Ap #228-2672 Nulla Av.','La Pintana','USA','6812','1-845-128-7756','Warehouse USA',210,206),
('Edward','Hahn','Ap #802-6505 Malesuada Rd.','Tuticorin','United Kingdom','017440','549-3727','Warehouse Europe',211,205),
('Ariana','Webster','7875 Tempus Avenue','Maltignano','United Kingdom','08573','137-2511','Warehouse Europe',212,205),
('Todd','Workman','3689 Ultrices Street','Northumberland','United Kingdom','8489','516-6304','Warehouse Europe',213,205),
('Zachery','May','Ap #995-8373 Urna. Ave','Malahide','Benin','60538','1-599-255-1156','Sales Assistant',214, 3),
('Bert','Hayden','Ap #302-641 Magna. Avenue','Erdemli','Netherlands','833743','699-3083','Sales Assistant',215, 6),
('Renee','Walter','P.O. Box 366, 9086 Molestie. Rd.','Spijkenisse','Turkey','24-954','1-346-528-1347','Sales Assistant',216, 3),
('Jessica','Moss','Ap #621-2177 Egestas. St.','Chépica','Ireland','2762','1-712-113-5307','Sales Assistant',217, 9),
('Kiona','Dudley','Ap #363-6364 Tincidunt Rd.','Antwerpen','Tonga','OL3H 6ZZ','1-365-255-0842','Sales Assistant',218, 4),
('Veronica','Sosa','Ap #261-3206 Tempus St.','Alcorcón','Malaysia','60804','479-1676','Sales Assistant',219, 8),
('Addison','Welch','P.O. Box 477, 206 Amet Avenue','Abbotsford','Zambia','34948-111','977-9391','Programmer',220, 202),
('Brendan','Parrish','Ap #875-923 In, Ave','Clovenfords','Ecuador','13168','949-4055','Data Analyst',221, 202),
('Dakota','Delgado','P.O. Box 653, 3364 Arcu Rd.','Valdivia','Antarctica','44623','1-206-971-7181','Accounting',222, 201),
('Kirby','Mullins','1166 Donec Rd.','Meridian','Mozambique','886609','807-6992','Accounting',223, 201),
('Stuart','Clarke','P.O. Box 177, 3565 Senectus St.','Viddalba','Libya','WS7 3JO','933-7681','Personal Assistant',224, 200);


UPDATE employees
SET reportsto = 200
WHERE employeeid= 2;



--USING RECURSION IN CTEs
--BASIC SYNTAX 
WITH RECURSIVE name(field1,field2,...)AS(
SELECT statement that returns definite value
UNION ALL
SELECT statement that combines with first statement
);


--create a set of 1 to 50
WITH RECURSIVE upto(t) AS (
	SELECT 1
	UNION ALL
	SELECT t+1 FROM upto
	WHERE t<50
)
SELECT * FROM upto;

--with a recursive CTE that starts at 500 and counts down to 2 by even numbers.
WITH RECURSIVE downfrom(t) AS (
	SELECT 500
	UNION ALL
	SELECT t-2 FROM downfrom
	WHERE t>2
)
SELECT * FROM downfrom;

--Find everyone that the CEO is responsible foe(Employeeid=200)
WITH RECURSIVE under_responsible(firstname,lastname,title,employeeid,reportsto,level) AS (
	SELECT firstname,lastname,title,employeeid,reportsto,0 FROM employees 
	WHERE employeeid=200
	UNION ALL
	SELECT managed.firstname,managed.lastname,managed.title,managed.employeeid,managed.reportsto,level+1
	FROM employees AS managed
	JOIN under_responsible ON managed.reportsto=under_responsible.employeeid
)
SELECT * FROM under_responsible;

--find the chain of command from Dudley Kiona(employeeid=218)up to the CEO
WITH RECURSIVE report_to(firstname,lastname,title,employeeid,reportsto,level) AS (
	SELECT firstname,lastname,title,employeeid,reportsto,0 FROM employees 
	WHERE employeeid=218
	UNION ALL
	SELECT manager.firstname,manager.lastname,manager.title,manager.employeeid,
	manager.reportsto,level+1
	FROM employees AS manager
	JOIN report_to ON manager.reportsto=manager.employeeid
)
SELECT * FROM report_to;

























