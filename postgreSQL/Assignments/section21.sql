--Date,Time and Timestamp Data Types
DATA TYPES
timestamp-both date and time
date-date only
time -time only

SHOW DateStyle;

SET DateStyle = 'ISO,DMY';

SHOW DateStyle;

SET DateStyle = 'ISO,MDY';

CREATE TABLE test_time(
	stardate  DATE,
	startstamp TIMESTAMP,
	starttime TIME
);

INSERT INTO test_time (stardate,startstamp,starttime)
VALUES ('epoch'::abstime, 'infinity'::abstime, 'allballs');

SELECT * FROM test_time;


INSERT INTO test_time (stardate,startstamp,starttime)
VALUES ('-infinity'::abstime, 'epoch'::abstime, 'allballs');

SELECT * FROM test_time;


INSERT INTO test_time (stardate,startstamp)
VALUES ('now'::abstime, 'today'::abstime);

SELECT * FROM test_time;

SELECT EXTRACT(EPOCH FROM TIMESTAMP '2016-12-31 13:30:15');

--TIME ZONES
How to see the available names:

SELECT * FROM pg_timezone_names;

SELECT * FROM pg_timezone_abbrevs;

--ADD some columns to test_time
ALTER TABLE test_time
ADD COLUMN endtime TIME WITH TIME ZONE;

ALTER TABLE test_time 
ADD COLUMN endstamp TIME WITH TIME ZONE;

ALTER TABLE test_time
ADD COLUMN endtime TIME WITH TIME ZONE;

ALTER TABLE test_time
ADD COLUMN endstamp TIME WITH TIME ZONE;


INSERT INTO test_time
(endstamp,endtime)
VALUES('01/20/2018 10:30:00 US/Pacific','10:30:00+5');

INSERT INTO test_time
(endstamp,endtime)
VALUES('06/20/2018 10:30:00 US/Pacific','10:30:00+5');

SELECT * FROM test_time;

--see/set time zone for session

SHOW TIME ZONE;

//notice the offset of time
SELECT * FROM test_time;

SET TIME ZONE 'US/Pacific'

//notice the offset changed
SELECT * FROM test_time;

--Interval data type
SYNTAX
Basic:
interval
Advanced:
interval[fields](precision)

SQL Standard Format:
'4 32:12:10'='4 days 32 hours 12 minutes 10 seconds'
'200-10'='200 years 10 months'
'1-2'='1 year 2 months'

Add Interval type to test_sql:

ALTER TABLE test_time
ADD COLUMN span interval;

DELETE FROM test_time;

INSERT INTO test_time (span)
VALUES('5 DECADES 3 YEARS 6 MONTHS 3 DAYS');

SELECT span FROM test_time;

INSERT INTO test_time (span)
VALUES('5 DECADES 3 YEARS 6 MONTHS 3 DAYS AGO');

--Input SQL Format
Do 2 inputs:
4 days 32 hours 12 minutes 10 seconds
1 year 2 months

INSERT INTO test_time (span)
VALUES('1-2');

SELECT span FROM test_time;

INSERT INTO test_time (span)
VALUES('4 32:12:10');



INSERT INTO test_time (span)
VALUES('P5Y3MT7H3M');

SELECT span FROM test_time;

INSERT INTO test_time (span)
VALUES('P25-2-30T17:33:10');


SHOW intervalstyle;

SET intervalstyle='postgres';
SELECT span FROM test_time;

SET intervalstyle='sql_standard';
SELECT span FROM test_time;

SET intervalstyle='ISO_8601';

--Date Arithmetic
SELECT DATE '2018-09-28' + INTERVAL '5 days 1 hour';

SELECT TIME '5:30:10' + INTERVAL '70 minutes 80 seconds';

SELECT TIMESTAMP '1917-06-20 12:30:10.222' + INTERVAL '30 year 6 months 7 days 3 hours 3 seconds';

SELECT INTERVAL '5 hours 30 minutes 2 seconds'+INTERVAL '5 days 3hours 13 minutes';

SELECT DATE '2017-04-05' + INTEGER '7';

SELECT DATE '2018-09-28' - INTERVAL '5 days 1 hour';

SELECT TIME '5:30:10' - INTERVAL '70 minutes 80 seconds';

SELECT TIMESTAMP '1917-06-20 12:30:10.222' - INTERVAL '30 year 6 months 7 days 3 hours 3 seconds';

SELECT INTERVAL '5 hours 30 minutes 2 seconds'-INTERVAL '5 days 3hours 13 minutes';

SELECT DATE '2016-12-30' - INTEGER '300';

//MULTIPLICATION AND DIVISION 

SELECT 5*INTERVAL '7 hours 5 minutes';
SELECT INTERVAL '30 days 20 minutes'/2;

//Age function

SELECT age (TIMESTAMP'2015-10-03',TIMESTAMP'1999-10-03');
SELECT age (TIMESTAMMP'1969-04-20');

//Pulling out parts of Dates and Times
TWO FUNCTIONS:
1.EXTRACT
2.date_part

--how many years old are the employees
SELECT EXTRACT (YEAR FROM age(birthdate)),firstname,lastname
FROM employees;

--Using date_part
date_part('field',source);

--Example:Find the day part of the ship date on all orders
SELECT date_part('day',shippeddate)
FROM orders;

--find how many decads old each employee is using both syntaxes
SELECT EXTRACT (DECADE FROM age(birthdate)),firstname,lastname
FROM employees;

//Converting One Data Type Into Another
--Two ways to do type conversion
CAST(value AS type)
value::type

--Cast hiredate as an timestamp
select hiredate::TIMESTAMP
FROM employees;

select CAST(hiredate AS TIMESTAMP)
FROM employees;

SELECT ceil(unitprice*quantity)::text  || 'dollars spent'
FROM order_details;

--converting the string '2015-10-03' to a dtae and 375 to text. Use CAST for first one and:: syntax for the second
SELECT CAST('2015-10-03' AS DATE),375::TEXT;