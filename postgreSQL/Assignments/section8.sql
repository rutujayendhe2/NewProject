--SECTION08
SELECT companyname,orderdate,shipcountry
FROM orders
JOIN customers ON customers.customerid=orders.customerid;

--connect employees to orders and pull back first name ,last name and order date for all orders
SELECT firstname,lastname,orderdate
FROM orders
JOIN employees ON employees.employeeid=orders.employeeid;

---connect products to suppliers and pull back company name,unit cost and units in stock.
SELECT companyname,unitprice,unitsinstock
FROM products
JOIN suppliers ON products.supplierid=suppliers.supplierid;

--Connect customers,orders,orderdetails...Bring back company name,order date,productid,unit price,quantity
SELECT companyname,orderdate,productid,unitprice,quantity
FROM orders
JOIN order_details ON orders.orderid=order_details.orderid
JOIN customers ON customers.customerid=orders.customerid;

--connect categories to previous and bring back category name
SELECT companyname,productname,categoryname,orderdate,order_details.unitprice,quantity
FROM orders
JOIN order_details ON orders.orderid=order_details.orderid
JOIN customers ON customers.customerid=orders.customerid
JOIN products ON products.productid=order_details.productid
JOIN categories ON categories.categoryid=products.categoryid; 

--take previous query and add where clause that select category name of seafood and amount spen>=500
SELECT companyname,productname,categoryname,orderdate,order_details.unitprice,quantity
FROM orders
JOIN order_details ON orders.orderid=order_details.orderid
JOIN customers ON customers.customerid=orders.customerid
JOIN products ON products.productid=order_details.productid
JOIN categories ON categories.categoryid=products.categoryid
WHERE categoryname='Seafood' AND order_details.unitprice*quantity >=500;

---LEFT JOINS
--connect customers to orders...Bring back company name,order id
SELECT companyname,orderid
FROM customers
LEFT JOIN orders ON orders.customerid=customers.customerid;

---use where with is null
SELECT companyname,orderid
FROM customers
LEFT JOIN orders ON orders.customerid=customers.customerid
WHERE orderid IS NULL;

--leftjoin between products and order_details
SELECT productname,orderid
FROM products
LEFT JOIN order_details ON products.productid=order_details.productid;

SELECT productname,orderid
FROM products
LEFT JOIN order_details ON products.productid=order_details.productid
WHERE orderid IS NULL;

--RIGHT JOINS
--connect orders to customers... bring back company name,orderid,using reverse table orderfrom last lesson
SELECT companyname,orderid
FROM orders
RIGHT JOIN customers ON customers.customerid=orders.customerid
WHERE orderid IS NULL;

--right join between customer demo and customers
SELECT companyname,customercustomerdemo.customerid
FROM customercustomerdemo 
RIGHT JOIN customers ON customers.customerid=customercustomerdemo.customerid;

--FULL JOIN
--connect orders to customers... bring back company name,orderid
SELECT companyname,orderid
FROM customers
FULL JOIN orders ON customers.customerid=orders.customerid;

--products and categories
SELECT productname,categoryname
FROM products
FULL JOIN categories ON categories.categoryid=products.categoryid;

--SELF JOIN 
--find customers...who are in the same city and order by city
SELECT c1.companyname AS CustomerName1,c2.companyname AS CustomerName2,c1.city
FROM customers AS c1
JOIN customers AS c2 ON c1.city=c2.city
ORDER BY c1.city;

--find suppliers from same country and order by country
SELECT s1.companyname AS SupplierName1,s2.companyname AS SupplierName2,s1.country
FROM suppliers AS s1
JOIN suppliers AS s2 ON s1.country=s2.country
ORDER BY s1.country;

--join orders to order_details with USING
SELECT *
FROM orders
JOIN order_details USING(orderid);

SELECT *
FROM orders
JOIN order_details USING(orderid)
JOIN products USING(productid);

--join orders to order_details with using NATURAL
SELECT *
FROM orders
NATURAL JOIN order_details;

--Add customers
SELECT *
FROM customers
NATURAL JOIN orders
NATURAL JOIN order_details;


SELECT COUNT(*)
FROM products
NATURAL JOIN order_details;


SELECT COUNT(*)
FROM products
JOIN order_details USING (productid);


--sort every employee on the basis of hired date .as  recently joined first
SELECT *
FROM humanresources.employee
ORDER BY hiredate DESC;

--Sort the employee data based onrecently hired and job title
SELECT loginid,jobtitle,hiredate,gender
FROM humanresources.employee
ORDER BY hiredate DESC,jobtitle ASC,gender;

--display the count of employee joint on every join date
SELECT hiredate ,COUNT(hiredate)
FROM humanresources.employee
GROUP BY hiredate
ORDER BY hiredate;



