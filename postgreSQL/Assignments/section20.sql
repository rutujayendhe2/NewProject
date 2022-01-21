CASE WHEN
BASIC SYNTAX AND USE

Like IF/THEN statements in regular programming
Used in SELECT expression
CASE WHEN condition THEN result
	WHEN condition THEN result
	ELSE default
END

EXAMPLE:
SELECT orderid,customerid,
CASE date_part('year',orderdate)
	WHEN 1996 THEN 'year1'
	WHEN 1997 THEN 'year2'
	WHEN 1998 THEN 'year3'
END
FROM orders;

--WE want to return company name,country,and continent our customers are from
SELECT DISTINCT(country)
FROM customers;

SELECT companyname,country,
CASE WHEN country IN ('Austria','Germany','Poland')THEN 'Europe'
	WHEN country IN ('Mexico','USA','Canada')THEN 'North America'
	WHEN country IN ('Brazil','Venezuala','Argentina')THEN 'South America'
	ELSE 'unknown'
END AS continent
FROM customers;



SELECT productname,unitprice,
CASE WHEN unitprice < 10 THEN 'inexpensive'
	 WHEN unitprice >= 10 AND unitprice <= 50 THEN 'mid-range'
	 WHEN unitprice > 50 THEN 'premium'
	ELSE 'unknown'
END AS quality
FROM products;

--SECOND SYNTAX
CASE field WHEN value THEN result
	WHEN value THEN result
	ELSE default
END


SELECT companyname,
CASE city WHEN 'New Orleans' THEN 'Big Easy'
		 WHEN 'Paris' THEN 'City of Lights'
		 ELSE city
END
FROM suppliers;


SELECT orderid,customerid,
CASE date_part('year',orderdate)
	WHEN 1996 THEN 'year1'
	WHEN 1997 THEN 'year2'
	WHEN 1998 THEN 'year3'
	ELSE 'unknown'
END
FROM orders;

--Coalesce Function
you supply a list of fields or values.It returns the first non-null value.Often used to substitute a default value for a null value.

COALESCE(field1,field2,....)

--Return 'N/A'for region from orders when field is full
SELECT customerid,COALESCE(shipregion,'N/A')
FROM orders;

SELECT companyname,COALESCE(homepage,'Call to find')
FROM suppliers;

--NULLIF
BASIC SYNTAX and Usage
Used to return a null if two values are equal.Used to trigger a null in COALESCE so next value is used.

NULLIF(field1,field2)

Need to modify some data
UPDATE suppliers
SET homepage="
WHERE homepage IS NULL

UPDATE customers
SET fax="
WHERE fax IS NULL

UPDATE suppliers
SET homepage=''
WHERE homepage IS NULL;

UPDATE customers
SET fax=''
WHERE fax IS NULL;

SELECT companyname,phone,
COALESCE (NULLIF(homepage,''),'Need to call')
FROM suppliers;

SELECT companyname,
COALESCE(fax,phone) AS confirmation
FROM customers;


SELECT companyname,
COALESCE(NULLIF(fax,''),phone) AS confirmation
FROM customers;































