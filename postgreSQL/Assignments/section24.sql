FUNCTION
--four kinds of functions
1.Query language - written in SQL (what we are doing in this section)
2.procedural language - written inPL/pgSQL or PL/Tcl(we will cover PL/pgSQL in another section)
3.Internal functions-written in C and statically linked into server
4.C-languagefunctions(very advanced)

SYNTAX:

CREATE OR REPLACE FUNCTION name()RETURNS void AS'
...statement...
'LANGUAGE SQL

to avoid quote issue use $$

CREATE FUNCTION name()RETURNS void AS $$
...statement...
$$LANGUAGE SQL

--write a function called fix_homepage that updates all suppliers with null in homepage field to 'N/A'
CREATE OR REPLACE FUNCTION fix_homepage() RETURNS void AS $$
	UPDATE suppliers
	SET homepage='N/A'
	WHERE homepage IS NULL
$$ LANGUAGE SQL;

--FUNCTION PARAMETER
CREATE OR REPLACE FUNCTION most_ordered_product(customerid bpchar) RETURNS varchar(40) AS $$
	SELECT productname
	FROM products
	WHERE productid IN (SELECT productid FROM
	(SELECT SUM(quantity)as total_ordered,productid
	FROM order_details
	NATURAL JOIN orders 
	WHERE customerid=$1
	GROUP BY productid
	ORDER BY total_ordered DESC
	LIMIT 1) as ordered_products);
$$ LANGUAGE SQL 

SELECT most_ordered_product('CACTU');


--FUNCTION THAT HAVE COMPOSITE PARAMETERS:
--Lets build a function takes a product and price increase percent and returns the new price
CREATE OR REPLACE FUNCTION new_price(products, increase_percent numeric)
RETURNS double precision AS $$
	SELECT $1.unitprice * increase_percent/100
$$ LANGUAGE SQL

SELECT productname,unitprice,new_price(products,110)
FROM products;

SELECT productname,unitprice,new_price(products.*,110)
FROM products;

--create a function full_name that takes employees and return title,firstname,lastname concatenated together.then use this in a select satement
CREATE OR REPLACE FUNCTION full_name(employees)RETURNS varchar(62) AS $$
	SELECT $1.title || ' ' || $1.firstname || $1.lastname
$$ LANGUAGE SQL;

SELECT full_name(employees.*),city,country
FROM employees;

--FUNCTIONS THAT RETURNS A COMPOSITE:
--Return the most recent hire
CREATE OR REPLACE FUNCTION newest_hire() RETURNS employees as $$
	SELECT *
	FROM employees
	ORDER BY hiredate ASC
	LIMIT 1;
$$ LANGUAGE SQL;

SELECT newest_hire();

SELECT lastname(newest_hire());

--create a function called highest_inventory that returns the products row that has the most amount of money tied up in inventory (costs times units)
CREATE OR REPLACE FUNCTION highest_inventory() RETURNS products AS $$
	SELECT * FROM products
	ORDER BY (unitprice*unitsinstock) DESC
	LIMIT 1;
$$ LANGUAGE SQL;

--Run function and grab the productname only
SELECT productname(highest_inventory());

--FUNCTION WITH OUTPUT PARAMETERS:
Can label parameters:
Using IN,OUT,INOUT(both input and output),and VARIADIC(covered with arrays)
CREATE FUNCTION name(IN x int,IN y int,OUT sum int)

CREATE OR REPLACE FUNCTION sum_n_product(x int,y int,OUT sum int,OUT product int)AS $$
	SELECT x+y,x*y
$$ LANGUAGE SQL;

SELECT sum_n_product(5,20);

--Create a function that takes a single number and returns the square and cube of the number using OUT parameter.Call it square_n_cube.
CREATE OR REPLACE FUNCTION square_n_cube(x int,y int,OUT square int,OUT cube int)AS $$
	SELECT x*x,x*x*x
$$ LANGUAGE SQL;

SELECT (square_n_cube(55)).*;

--FUNCTIONS WITH DEFAULT VALUES:
Syntax for parameter with default value
CREATE FUNCTION name(a int, b int DEFAULT2,cDEFAULT7)
must have defaults after first default.

--Redo new_price function with a default of 5%price increase.
CREATE OR REPLACE FUNCTION new_price(products,increase_percent numeric DEFAULT 105)
RETURNS double precision AS $$
	SELECT $1.unitprice * increase_percent/100
$$ LANGUAGE SQL;

SELECT productname,unitprice,new_price(products.*)
FROM products;

--Redo square_n_cube. Create a function that takes a single number and returns the square and cube of the number using OUT parameters.Give the input a default value of 10.
--Run function without any output
CREATE OR REPLACE FUNCTION square_n_cube(IN x int DEFAULT 10,OUT square int,OUT cube int)AS $$
	SELECT x*x,x*x*x
$$ LANGUAGE SQL;

SELECT (square_n_cube()).*;

--Using functions As Table Sources
--Select first name,last name and hiredate from newest_hire()
SELECT firstname,lastname,hiredate
FROM newest_hire();

--Use highest_inventory to pull back productname,supplier companyname (you will have to join function results)
SELECT productname,companyname
FROM highest_inventory() AS hi
JOIN suppliers ON hi.supplierid=suppliers.supplierid;

--Functions that return more than one row
--lets return all products that have total sales greater than some input value.
CREATE OR REPLACE FUNCTION sold_more_than(total_sales real)
RETURNS SETOF products AS $$
	SELECT * FROM products
	WHERE productid IN(
		SELECT productid FROM 
		(SELECT SUM(quantity*unitprice),productid
		FROM order_details
		GROUP BY productid
		HAVING SUM (quantity*unitprice)> total_sales
		)AS qualified_prducts
	)
$$ LANGUAGE SQL;

SELECT productname,productid,supplierid
FROM sold_more_than(2500);

--Create a function called next_birthday that return all employees next birthday,first and last name and hiredate.
CREATE OR REPLACE FUNCTION next_birthday()
RETURNS TABLE(birthday date,firstname varchar(10),lastname varchar(20),hiredate date)AS $$

	SELECT (birthdate + INTERVAL '1YEAR' * (EXTRACT(YEAR FROM age(birthdate))+1))::date,
	firstname,lastname,hiredate
	FROM employees
$$ LANGUAGE SQL;

SELECT * FROM next_birthday();

--Create a funtion that returns all suppliers that have produts that need to be ordered (units on hard plus units ordered is less than 
reorder level).use SETOF syntax
Call funtion:suppliers_to_reorder_from

CREATE OR REPLACE FUNCTION suppliers_to_reorder_from()
RETURNS SETOF suppliers AS $$
	SELECT * FROM suppliers
	WHERE supplierid IN (
		SELECT supplierid FROM products
		WHERE unitsinstock + unitsonorder < reorderlevel
	)
$$ LANGUAGE SQL;

SELECT * FROM suppliers_to_reorder_from();

--Create function that returns the excess inventory,productid and productname from products table based on an input parameter 
--of percent of inventory threshold.Use RETURNS TABLE syntax.
CREATE OR REPLACE FUNCTION excess_inventory_level(percent numeric)
RETURNS TABLE(excess int,productid smallint,productname varchar(40)) AS $$
	
	SELECT CEIL( (unitsinstock + unitsonorder) - (reorderlevel * percent/100))::int,
	productid,productname
	FROM products
	WHERE (unitsinstock + unitsonorder) - (reorderlevel * percent/100) >0
	
$$ LANGUAGE SQL;

SELECT * FROM excess_inventory_level(130);

--Proedures - functions that dont return anything
Syntax:
CREATE OR REPLACE PROCEDURE name( param list )AS $$
--statements
$$ LANGUAGE SQL 

CREATE OR REPLACE PROCEDURE add_em(x int, y int) AS $$
	SELECT x+y
$$ LANGUAGE SQL;

CALL add_em(5,10);

--Create a procedure change_supplier_prices that takes the supplierid and amount and increases all the unit prices in 
--produts table for the supplier
--Run procedure with supplierid 20 and raise prices by $0.50.
CREATE OR REPLACE PROCEDURE change_supplier_prices(supplierid smallint,amount real) AS $$
	UPDATE products
	SET unitprice = unitprice + amount
	WHERE supplierid = $1
$$ LANGUAGE SQL;

CALL change_supplier_prices(20::smallint,0.50)