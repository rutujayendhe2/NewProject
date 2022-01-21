WHAT are Window Functions?
-A way to combine Group by aggregation with regular select statements.The value of aggregation is calculated without combining the returned rows.
SYNTAX:
SELECT *
function OVER(PARTITION BY field_name)
from...
Example:
SELECT categoryname,productname,unitprice,
AVG(unitprice) OVER (PARTITION BY categoryname)
FROM products
JOIN categories ON categories.categoryid = products.categoryid
ORDER BY categoryname,unitprice DESC;

--We are looking for strange orders of the product 'Alice Mutton'.Find all records of order details of this product compared to the average order.
SELECT productname,quantity,
AVG(quantity) OVER (PARTITION BY order_details.productid)
FROM products
JOIN order_details ON order_details.productid = products.productid
WHERE productname='Alice Mutton'
ORDER BY quantity DESC;

--compare each product's order quantity compared to the average order for that product
SELECT productname,orderid,quantity,
AVG (quantity) OVER (PARTITION BY order_details.productid)
FROM products
JOIN order_details ON products.productid=order_details.productid
ORDER BY productname, quantity DESC;

--Using window functions with subqueries
SELECT  companyname,orderid,amount,average_order
FROM
(SELECT companyname,orderid,amount,AVG(amount) OVER (PARTITION BY companyname)AS average_order
FROM
(SELECT companyname,orders.orderid,SUM(unitprice*quantity) AS amount
FROM customers
JOIN orders ON orders.customerid=customers.customerid
JOIN order_details ON orders.orderid=order_details.orderid
GROUP BY companyname,orders.orderid) AS order_amounts) AS order_averages
WHERE amount > average_order * 5;


--Find any suppliers that had 3 times the normal quantity of orders over all their products versus the avg order per month
SELECT companyname,month,year,total_orders,average_monthly
FROM
(SELECT companyname,total_orders,month,year,AVG(total_orders) OVER (PARTITION BY companyname) AS average_monthly
FROM
(SELECT companyname,SUM(quantity) AS total_orders,date_part('month',orderdate)as month,
date_part('year',orderdate) AS year
FROM order_details
JOIN products ON products.productid = order_details.productid
JOIN suppliers ON suppliers.supplierid=products.supplierid
JOIN orders ON orders.orderid=order_details.orderid
GROUP BY companyname,month,year)as orders_by_month) AS average_monthly
WHERE total_orders > 3*average_monthly;


--Using Rank() to find first n records:
Q.How do I join two tables and returns the top 2 results from the 2nd table for each row in first table?
LIMIT won't work because it limits total rows returned.
window function rank()will do this.

--Top two most valuable items ordered for each others records.
SELECT * FROM 
(SELECT orders.orderid,productid,unitprice,quantity,
rank() OVER (PARTITION BY order_details.orderid ORDER BY (quantity*unitprice)DESC)AS rank_amount
FROM orders
NATURAL JOIN order_details) as ranked
WHERE rank_amount<=2;

--Find the 3least expensive products from each supplier.Return supplier name,product name,& price
SELECT companyname,productname,unitprice 
FROM
(SELECT companyname,productname,unitprice,
rank() OVER (PARTITION BY products.supplierid ORDER BY unitprice ASC)AS price_rank
FROM suppliers
NATURAL JOIN products) AS ranked_products
WHERE price_rank <=3;