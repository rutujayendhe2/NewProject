ACID Transactions

DATABASE TRANSACTION:
a group of database statements that are performed together

--Simple transaction control
Syntax:
START TRANSACTION;
--statement1
--statement2
--etc
COMMIT;

alternative -postgresql extension
BEGIN TRANSACTION;
--statement1
--statement2
--etc
END TRANSACTION;

--Lets update the reorder level and find the count of items that need reordering in one transaction.
START TRANSACTION;

	UPDATE products
	SET reorderlevel = reorderlevel - 5;
	
	SELECT COUNT(*)
	FROM products
	WHERE unitsinstock + unitsonorder < reorderlevel;
COMMIT;

--Create a single transaction to increase the requireddate in orders by one day for december 2017 and decrease it by one day for november 2017.
START TRANSACTION;

	UPDATE orders
	SET requireddate = requireddate + INTERVAL '1 DAY'
	WHERE orderdate BETWEEN '1997-12-01' AND '1997-12-31';	
	
	UPDATE orders
	SET requireddate = requireddate - INTERVAL '1 DAY'
	WHERE orderdate BETWEEN '1997-11-01' AND '1997-11-30';	

COMMIT;
	
--Rollack usage:
aborts all changes in the current transaction.
ROLLBACK;
Useful more PL/pgSQL programming where you have if/then statements

Example:
Start to update orders and rollback;
	START TRANSACTION;

	UPDATE orders
	SET orderdate = orderdate + INTERVAL '1 YEAR';

ROLLBACK;

--Savepoint Usage:
allows you to do a partial rollback
SAVEPOINT name;

Example:
Start a transaction,insert a new employee,create a savepoint,update hiredate and rollback to savepoint.
START TRANSACTION;

INSERT INTO  employees (employeeid,lastname,firstname,title,birthdate,hiredate)
VALUES (501,'Sue','Jones','Operations Assistant','1997-05-23','2017-06-13');

SAVEPOINT inserted_employee;

UPDATE employees
SET birthdate='2025-07-11';

ROLLBACK TO inserted_employee;

UPDATE employees
SET birthdate='1998-05-23'
WHERE employeeid=501;

COMMIT;

--SQL Transaction Isolation
--PostgreSQL Transaction Isolation
--How To Request Isolation Level

at beginning of transaction:
START TRANSACTION ISOLATION LEVEL level_desired

after start of transaction:
SET TRANSACTION ISOLATION LEVEL level_desired
