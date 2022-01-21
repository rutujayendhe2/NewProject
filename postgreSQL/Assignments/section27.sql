
--Build your first PL/pgSQL Function
Similar to SQL Functions
CREATE FUNCTION name(parameters) RETURNS var type AS $$
BEGIN

...statements...
 END;
 $$ LANGUAGE plpgsql;
 
 --PL/pgSQL IS Block- Structured Language
 Each block is surrounded by:
 BEGIN
 END;
 
 USE RETURN to send value back
 Do:
 RETURN x+y
 Instead of:
 SELECT x+y
 
 --lets create our first function
 --lets redo max_price as a PL/pgSQL function
 DROP ROUTINE IF  EXISTS max_price();
 
 CREATE OR REPLACE FUNCTION max_price() RETURNS real AS $$
 BEGIN
 	RETURN MAX(unitprice)
	FROM products;
END;
$$ LANGUAGE plpgsql;

SELECT max_price();

--drop biggest_order and redo as a PL/pgSQL function.It returns the largest order amount.

 DROP ROUTINE IF  EXISTS biggest_order();
 
 CREATE OR REPLACE FUNCTION biggest_order() RETURNS double precision AS $$
 BEGIN
 	RETURN MAX(amount)
	FROM 
	(SELECT SUM(unitprice*quantity) AS amount,orderid
	FROM order_details
	GROUP BY orderid
	)AS totals;
END;
$$ LANGUAGE plpgsql;

SELECT biggest_order();

--Handling functions with output variables
Must Assign Variables:
two ways to assign
PL standard: variable:=value
PostgreSQL: variable:=value

Then put Empty Return
RETURN;

Example:-
lets rebuild sum_n_product as PL/pgSQL.It takes to integer and returns the sum and product
CREATE OR REPLACE FUNCTION sum_n_product(x int, y int,OUT sum int,OUT product int)AS $$
BEGIN 
	sum := x + y;
	product := x * y;
	RETURN;
END;
$$ LANGUAGE plpgsql;

SELECT (sum_n_product(5,20)).*;

--Replace square_n_cube with PL/pgSQL function.It takes a single integer and returns square and cube of the value.Use DROP ROUTINE if replace doesnt work.
CREATE OR REPLACE FUNCTION square_n_cube
(IN x int,OUT square int,OUT cube int) AS $$
BEGIN
	square := x*x;
	cube := x*x*x
END;
$$ LANGUAGE plpgsql

SELECT (square_n_cube(55)).*;

--Returning Query Results
use Setof and Return query
DECLARE FUNCTION name(...)RETURNS SETOF table_name AS $$
BEGIN
	RETURNS QUERY SELECT....
END;
$$ LANGUAGE plpgsql;

--Redo sold_more_than to PL/pgSQL. Returns all products that sold more than an input amount.
CREATE OR REPLACE FUNCTION sold_more_than(total_sales real)
RETURNS SETOF products AS $$
BEGIN
	RETURN QUERY SELECT * FROM products
	WHERE productid IN(
		SELECT productid FROM
		(SELECT SUM(quantity*unitprice),productid
		FROM order_details
		GROUP BY productid
		HAVING SUM(quantity*unitprice) > total_sales) as qualified_products 
	);
END;
$$ LANGUAGE plpgsql;

SELECT sold_more_than(25000);

SELECT (sold_more_than(25000)).*;

--Redo suppliers_to_reorder_from.It returns suppliers that have unitsinstock and unitsonorder that are less than reorderlevel.


CREATE OR REPLACE FUNCTION suppliers_to_reorder_from()
RETURNS SETOF suppliers AS $$
BEGIN
	RETURN QUERY SELECT * FROM suppliers
	WHERE supplierid IN(
		SELECT supplierid FROM products
		WHERE unitsinstock + unitsonorder < reorderlevel
	);
END;
$$ LANGUAGE plpgsql;

SELECT (suppliers_to_reorder_from()).*;

SELECT  * FROM suppliers_to_reorder_from();

--IF you need more variables
DECLARE
name varchar(50);
startdate timestamp := now();
BEGIN
....
END;

--can also rename parameters
CREATE OR FUNCTION (int,int)RETURNS int AS $$
DECLARE
	X ALIAS FOR $1
	Y ALIAS FOR $2
BEGIN

--assigning variable from query
SELECT expression INTO target FROM;
should only return single result.

Example:
--Find products between 75% and 1.25%of the average priced item
CREATE OR REPLACE  FUNCTION middle_priced() RETURNS SETOF products AS $$
DECLARE 
	average_price real;
	bottom_price real;
	top_price real;
BEGIN
 	SELECT AVG(unitprice) INTO average_price
 	FROM products;
	
	bottom_price := average_price * 0.75;
	top_price := average_price * 1.25;
	
	RETURN QUERY SELECT * FROM products
	WHERE unitprice BETWEEN bottom_price AND top_price;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM middle_priced();
	
--Build a function that determines the average order siza and returns all orders (not_order_details)that are between 75% and 130% of that order.
CREATE OR REPLACE FUNCTION normal_order() RETURNS SETOF orders AS $$
DECLARE
	average_order_amount real;
	bottom_order_amount real;
	top_order_amount real;
BEGIN
	SELECT AVG(amount_ordered)INTO average_order_amount FROM (
		SELECT SUM(unitprice*quantity) AS amount_ordered,orderid
		FROM order_details
		GROUP BY orderid)AS order_details;
		
	bottom_order_amount := average_order_amount * 0.75;
	top_order_amount := average_order_amount * 1.30;
	
	RETURN QUERY SELECT * FROM orders
	WHERE orderid IN (
		SELECT orderid FROM(
			SELECT SUM(unitprice*quantity)AS amount_ordered,orderid
			FROM order_details
			GROUP BY orderid
			HAVING SUM(unitprice*quantity)BETWEEN bottom_order_amount AND top_order_amount
		)	AS order_amount
	);
END;
$$ LANGUAGE plpgsql;
	
--Looping through query results:
Syntax:
FOR target IN query LOOP
...statements...
END LOOP;

Example:
Build an array of reports to information from employee table using a recursive query.
CREATE FUNCTION reports_to(IN eid smallint,OUT employeeid smallint,OUT reportsto smallint)
RETURNS SETOF record AS $$

WITH RECURSIVE reports_to(employeeid,reportsto)AS(
	SELECT employeeid,reportsto FROM employees
	WHERE employeeid = eid
	UNION ALL
	SELECT manager.employeeid,manager.reportsto
	FROM employees AS manager
	JOIN reports_to ON reports_to.reportsto = manager.employeeid
)
SELECT * FROM reports_to;
$$ LANGUAGE SQL;


SELECT * FROM reports_to(218);


CREATE OR REPLACE FUNCTION report_to_array(eid smallint)RETURNS smallint[]AS $$
DECLARE
	report_array smallint[];
	manager record;
BEGIN
	FOR manager IN SELECT reportsto FROM reports_to(eid)LOOP
		report_array := array_append(report_array,manger.reportsto);
	END LOOP;
	
	RETURN report_array;
END;
$$ LANGUAGE plpgsql;

SELECT report_to_array(218::smallint);

SELECT firstname,lastname,employeeid,report_to_array(employeeid)
FROM employees;

--Build a function that returns the average of the square of products unitprices
CREATE OR REPLACE FUNCTION average_of_square() RETURNS double precision AS $$
DECLARE
	square_total int := 0;
	total_count int := 0;
	product record;
BEGIN
	FOR product IN SELECT * FROM products LOOP
		total_count := total_count + 1;
		square_total := square_total + (product.unitprice*product.unitprice);
	END LOOP;
	RETURN square_total/ total_count;
END;
$$ LANGUAGE plpgsql;

SELECT average_of_square();

--Using If-then statements:
syntax:
IF boolean-expression THEN
	...statements...
END IF;

Syntax for IF-THEN-ELSE:

 IF boolean-expression THEN
	...statements...
ELSE
		...statements...

END IF;

Syntax for IF-THEN-ELSIF:

 IF boolean-expression THEN
	...statements...
ELSIF boolean-expression THEN
	...statements...
ELSE
		...statements...
END IF;

Example:
lets categorize our products by price range bargain,middle class and luxury
CREATE OR REPLACE FUNCTION product_price_category(price real) RETURNS text AS $$
BEGIN
	IF price >50.0 THEN
		RETURN 'Luxury';
	ELSIF price >25.0 THEN
		RETURN 'Consumer';
	ELSE 
		RETURN 'Bargain';
	END IF;
END;
$$ LANGUAGE plpgsql;

SELECT product_price_category(unitprice),*
FROM products;

--Build a function called time_of_year to return Spring for dates between March and May,summer for june to august,fall for september to november
--and winter for december through february.use a single parameter timestamp
 CREATE OR REPLACE FUNCTION time_of_year(date_to_check timestamp) RETURNS text AS $$
DECLARE
	month_of_year int := EXTRACT(MONTH FROM date_to_check);
BEGIN
	IF month_of_year >=3 AND month_of_year <=5 THEN
		RETURN 'Spring';
	ELSIF  month_of_year >=6 AND month_of_year <=8  THEN
		RETURN 'Summer';
	ELSIF  month_of_year >=9 AND month_of_year <=11  THEN
		RETURN 'Fall';
	ELSE 
		RETURN 'Winter';
	END IF;
END;
$$ LANGUAGE plpgsql;

SELECT time_of_year(orderdate),*
FROM orders;




CREATE OR REPLACE FUNCTION sold_more_than(total_sales real)
RETURNS SETOF products AS $$
BEGIN
	RETURN QUERY SELECT * FROM products
		WHERE productid IN(
			SELECT productid FROM(
				SELECT SUM(quantity*unitprice),productid
				FROM order_details
				GROUP BY productid
				HAVING SUM (quantity*unitprice) > total_sales
			)AS qualified_products
		);
		
		IF NOT FOUND THEN
			RAISE EXCEPTION 'No products had sales higher than %.',total_sales;
		END IF;
END;
$$ LANGUAGE plpgsql;

SELECT productname,productid,supplierid
FROM sold_more_than(15000);

--Lets create variable pricing for after christmas sale
CREATE OR REPLACE FUNCTION after_christmas_sale() RETURNS SETOF products AS $$
DECLARE
	product record;
BEGIN
	FOR product IN
		SELECT * FROM products
	LOOP
		IF product.categoryid IN(1,4,8) THEN
			product.unitprice = product.unitprice * 0.80;
		ELSIF product.categoryid IN(2,3,7) THEN
			product.unitprice = product.unitprice * 0.75;
		ELSE 
			product.unitprice = product.unitprice * 0.10;
		END IF;
		RETURN NEXT product;
	END LOOP;
	
	RETURN;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM after_christmas_sale();

--Loop and While Loop
Syntax:
LOOP
END LOOP;

--leaving loop
EXIT;
or
EXIT WHEN conditional;

--Skipping ahead
CONTINUE;
or
CONTINUE WHEN conditional;

--while version
WHILE expression LOOP
--statements
END LOOP

Example:
--lets write a function to calculate the factorial of number.
Example:5!=5*4*3*2*1

CREATE OR REPLACE FUNCTION factorial(x float) RETURNS float  AS $$
DECLARE
	current_x float := x ;
	running_multiplication float :=1;
BEGIN
	LOOP 
		running_multiplication :=running_multiplication * current_x;
		
		current_x := current_x -1;
		EXIT WHEN current_x <= 0;
	END LOOP;
	RETURN running_multiplication;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM factorial(5::float);

--Rewrite the factorial using WHILE LOOP syntax

CREATE OR REPLACE FUNCTION factorial(x float) RETURNS float  AS $$
DECLARE
	current_x float := x ;
	running_multiplication float :=1;
BEGIN
	 WHILE current_x >= 1 
 	LOOP
		running_multiplication :=running_multiplication * current_x;
		
		current_x := current_x -1;

		END LOOP;
	RETURN running_multiplication;
END;
$$ LANGUAGE plpgsql;

SELECT * FROM factorial(5::float);

--Looping over array:
syntax:
FOREACH target IN ARRAY expression LOOP
---statements
END LOOP;

Example:
-user had two columns:path which has a default url and additional which is an array field with values like sm:/url2,md:/url3,etc
wants to return url from additional if the specific url is available otherwise return path.
this is perfect to create a PL/pgSQL function for using array looping

CREATE OR REPLACE FUNCTION select_url(path_to_search_for text,additional text[],default_path text)
RETURNS text AS $$
DECLARE 
	additional_element text;
	additional_url text;
BEGIN
	FOREACH additional_element IN ARRAY additional LOOP
		IF left(additional_element,length(path_to_search_for)) = path_to_search_for THEN
			additional_url = right(additional_element, length(additional_element)-length(path_to_search_for)-1);
			RETURN trim(additional_url);
		END IF;
	END LOOP;
	
	RETURN default_path;
END;
$$ LANGUAGE plpgsql;

SELECT select_url('sm',ARRAY['sm: /url2','md: /url3'],'/url1');

SELECT select_url('md',ARRAY['sm: /url2','md: /url3'],'/url1')

--build a function that takes an array of numbers and a single number that is the divisor. return the first no that divides evenly 
in the list.call the function first_multiple

Hint:modulo operator %, returns the remainder of division .you are looking for a modula of zero.

CREATE OR REPLACE FUNCTION first_multiple(x int[],y int)RETURNS int AS $$
DECLARE
	test_number int;
BEGIN
	FOREACH test_number IN ARRAY x LOOP
		IF test_number % y = 0 THEN
			RETURN test_number;
		END IF;
	END LOOP;
	RETURN NULL;
END;
$$ LANGUAGE plpgsql;

SELECT first_multiple(ARRAY[13,12,64,10],2);
