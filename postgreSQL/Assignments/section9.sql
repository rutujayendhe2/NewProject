--how many customers..do we have in each country?
SELECT country,COUNT(*)
FROM customers
GROUP BY country
ORDER BY count(*) DESC;

--what is the no.of products for each category?
SELECT categoryname,COUNT(*)
FROM categories
JOIN products ON products.categoryid=categories.categoryid
GROUP BY categoryname
ORDER BY count(*) DESC;

--what is the avg no of items ordered for products ordered by the avg amount?
SELECT productname,AVG(quantity)
FROM products
JOIN order_details ON products.productid=order_details.productid
GROUP BY productname
ORDER BY AVG(quantity) DESC;

--how many suppliers in each country?
SELECT country,COUNT(*)
FROM suppliers
GROUP BY country
ORDER BY count(*) DESC;

--Total value of each product sold for year of 1997
SELECT productname,SUM(order_details.unitprice*quantity)
FROM products
JOIN order_details
ON products.productid=order_details.productid
JOIN orders ON orders.orderid=order_details.orderid
WHERE orderdate BETWEEN '1997-01-01' AND '1997-12-31'
GROUP BY productname
ORDER BY SUM(order_details.unitprice*quantity)DESC;

--find products that sold less than $2000
SELECT productname,SUM(order_details.unitprice*quantity) AS AmountBought
FROM products
JOIN order_details USING (productid)
GROUP BY productname
HAVING SUM(order_details.unitprice*quantity) < 2000
ORDER BY AmountBought ASC;

--customers that have bought more than $5000 of products?
SELECT companyname,SUM(order_details.unitprice*quantity) AS AmountBought
FROM customers
NATURAL JOIN orders
NATURAL JOIN order_details
GROUP BY companyname
HAVING SUM(order_details.unitprice*quantity) > 5000
ORDER BY AmountBought DESC;

--customers that have bought more than $5000 of products with order date in first six months of the year of 1997
SELECT companyname,SUM(order_details.unitprice*quantity) AS AmountBought
FROM customers
NATURAL JOIN orders
NATURAL JOIN order_details
WHERE orderdate BETWEEN '1997-01-01' AND '1997-06-30'
GROUP BY companyname
HAVING SUM(order_details.unitprice*quantity) > 5000
ORDER BY AmountBought DESC;

--total sales grouped by product and category?
SELECT categoryname,productname,SUM(od.unitprice*quantity)
FROM categories
NATURAL JOIN products
NATURAL JOIN order_details AS od
GROUP BY GROUPING SETS ((categoryname),(categoryname,productname))
ORDER BY categoryname,productname;

--find total sales by both customers companyname renamed as buyer and suppliers company name renamed as supplier and 
--order by buyer and supplier

SELECT c.companyname AS buyer,s.companyname AS supplier,SUM(od.unitprice*quantity)
FROM customers AS c
NATURAL JOIN orders
NATURAL JOIN order_details AS od
JOIN products USING (productid)
JOIN suppliers AS s USING (supplierid)
GROUP BY GROUPING SETS ((buyer),(buyer,supplier))
ORDER BY buyer,supplier;

--find total sales grouped by customer companyname and categoryname,
--order by companyname,categoryname with NULLS FIRST?
SELECT companyname,categoryname,SUM(od.unitprice*quantity)
FROM customers
NATURAL JOIN orders
NATURAL JOIN order_details AS od
JOIN products USING (productid)
JOIN categories USING (categoryid)
GROUP BY GROUPING SETS ((companyname),(companyname,categoryname))
ORDER BY companyname,categoryname NULLS FIRST;


--ROOLUP
--let's do a rollup with customer,categories and products?
SELECT companyname,categoryname,productname,SUM(od.unitprice*quantity)
FROM customers
NATURAL JOIN orders
NATURAL JOIN order_details AS od
JOIN products USING (productid)
JOIN categories USING (categoryid)
GROUP BY ROLLUP (companyname,categoryname,productname);



SELECT s.companyname AS supplier,c.companyname AS buyer,productname,SUM(od.unitprice*quantity)
FROM suppliers AS s
JOIN products USING (supplierid)
JOIN order_details AS od USING (productid)
JOIN orders USING (orderid)
JOIN customers AS c USING (customerid)
GROUP BY ROLLUP (supplier,buyer,productname)
ORDER BY supplier,buyer,productname;

--lets do a cube of total sales by customer,categories and products
SELECT companyname,categoryname,productname,SUM(od.unitprice*quantity)
FROM customers
NATURAL JOIN orders
NATURAL JOIN order_details AS od
JOIN products USING (productid)
JOIN categories USING (categoryid)
GROUP BY CUBE (companyname,categoryname,productname);


SELECT s.companyname AS supplier,c.companyname AS buyer,productname,SUM(od.unitprice*quantity)
FROM suppliers AS s
JOIN products USING (supplierid)
JOIN order_details AS od USING (productid)
JOIN orders USING (orderid)
JOIN customers AS c USING (customerid)
GROUP BY CUBE (supplier,buyer,productname)
ORDER BY supplier NULLS FIRST,buyer NULLS FIRST,productname NULLS FIRST;

--FIND products get a list of all customer and supplier company names
SELECT companyname
FROM customers
UNION
SELECT companyname
FROM suppliers;

--find cities of all our customers and suppliers, with one record for each companies city
SELECT city
FROM customers
UNION ALL
SELECT city
FROM suppliers;

SELECT DISTINCT country
FROM customers
UNION ALL
SELECT country
FROM suppliers
ORDER BY country ASC;








