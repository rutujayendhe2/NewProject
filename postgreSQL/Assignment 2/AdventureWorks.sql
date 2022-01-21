
--SECTION 07
--what customers? have a contact whose first name starts with D ? 
SELECT companyname,contactname
FROM customers
WHERE contactname LIKE 'D%';

SELECT companyname,contactname
FROM customers
WHERE contactname LIKE 'R%';

--which of our suppliers?Have 'or' as the 2nd and 3rd letters in the company name
SELECT companyname
FROM suppliers
WHERE companyname LIKE '_or%';

--which customer company names end in 'er'?
SELECT companyname
FROM customers
WHERE companyname LIKE '%er';

SELECT unitprice*quantity AS Totalspent
FROM order_details;

--this won't work
--SELECT unitprice*quantity AS Totalspent
--FROM order_details
--WHERE Totalspent > 10;

--Use the Alias in order by ...Order the previous query by Totalspent DESC?
SELECT unitprice*quantity AS Totalspent
FROM order_details
ORDER BY Totalspent DESC;


--Calculate our inventory value of product(need unitprice and unitsinstock fieds)
--and return as Totalnventory and order by this column desc
SELECT unitprice*unitsinstock AS Totalnventory
FROM products
ORDER BY Totalnventory DESC;

--Find the 3 most expensive order details? ... will need to use calculated fields, order by and imit.
SELECT  productid,unitprice*quantity AS TotalCost
FROM order_details
ORDER BY TotalCost DESC
LIMIT 3;

--Calculate the 2 products with the least inventory in stock by total dollar amount of inventory?
SELECT productid,unitprice*unitsinstock AS Totalnventory
FROM products
ORDER BY Totalnventory ASC
LIMIT 2;

--How many customers?...don't have a region value.
SELECT COUNT(*)
FROM customers
WHERE region IS NULL;

--How many suppliers ?...Have a region value.
SELECT COUNT(*)
FROM suppliers
WHERE region IS NOT NULL;

--How many orders did not have a ship region?
SELECT COUNT(*)
FROM orders
WHERE shipregion IS NULL;