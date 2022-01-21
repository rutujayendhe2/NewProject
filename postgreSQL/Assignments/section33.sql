Overview of Roles and Users
Everything is actuallya role:
-users are roles with passwords
-groups have become an alias for roles

Roles belong to database instance:
-Not individual db,so not backed up with db

Roles can be nested:
-Every role can contain or be contained by other roles.
-This allows you to add permissions to users or other roles.

Proper way to set up
-create roles that cant login and are named for generic jobs:like hr or accounting
-create users (roles with logins) and add them to roles they need to get their job done

6 Layers of Security:
1.Instance level(covers all db),handles can you login,create db,roles,etc.
2.Database level-can you connect to db and create roles
3.Schema level - can you create or use particular schemas
4.Table level - what operation can you perform on a table
5.Column level - what operation can you perform on specific column
6.Row level - which rows in db can you perform operations on

Instance level security:
Controls the following:
1.SUPERUSER - can do anything
2.CREATEDB - make db
3.CREATEROLE - make more roles
4.LOGIN - can login into db
5.REPLICATION - can be used for replication
Every permission can reversed with a NO in front
SUPERUSER => NOSUPERUSER   

Permissions are permissive
CREATEDB - gives you the permission to create a db
NOCREATEDB - is the absence of permission not a prohibition

Lets create some Roles:
lets create two roles: accounting and hr

CREATE ROLE accounting NOCREATEDB NOLOGIN NOSUPERUSER;
CREATE ROLE hr NOCREATEDB NOLOGIN NOSUPERUSER;

Lets make users 2 ways:
CREATE ROLE with LOGIN
or
CREATE USER

CREATE ROLE suzy NOCREATEDB LOGIN NOSUPERUSER PASSWORD 'pass123';
CREATE ROLE bobby NOCREATEDB LOGIN NOSUPERUSER PASSWORD 'pass123';

-Must reovke public on northwind
REVOKE ALL ON DATABASE northwind FROM public;

-Add users to roles:
GRANT accounting TO suzy;
GRANT hr TO bobby;

Ex:
Create a role for sales that cant login on creatdb and a user jill that you add to role sales.
CREATE ROLE sales NOCREATEDB LOGIN NOSUPERUSER ;
CREATE ROLE jill NOCREATEDB LOGIN NOSUPERUSER PASSWORD 'pass123';
GRANT sales TO jill;

--Database level Security:
controls the following
1.CREATE  - make new schemas
2.CONNECT - connect to database
3.TEMP/TEMPORARY - create temp tables

--Lets add permission for connection
GRANT CONNECT ON DATABASE northwind TO accounting;
GRANT CONNECT ON DATABASE northwind TO hr;

Ex:
give your sales role the ability to connect to northwind and create schemas.
GRANT CONNECT ON DATABASE northwind TO sales;
GRANT CREATE ON DATABASE northwind TO sales;

--Schema level security:
controls the following:
1.CREATE - put objects like tables into the schema
2.USAGE - look in the schema and see what is present

--Another loophole:
-as bobby try and create a table
-it goes into public

Ex:
REVOKE ALL ON SCHEMA public FROM public;
DROP TABLE can_i

Ex:
--lets add given accounting CREATE and USAGE and hr USAGE of public schema
GRANT CREATE ON SCHEMA public TO accounting;
GRANT USAGE ON SCHEMA public TO accounting;
GRANT USAGE ON SCHEMA public TO hr;

--grant USAGE to sales for public schema
GRANT USAGE ON SCHEMA public TO sakles;

--Table level security:
control the following:
1.SELECT -read rows in table
2.INSERT - write data to table
3.UPDATE - change data in table
4.DELETE - delete data
5.TRUNCATE - remove all data at once
6.REFERENCE -allows user to create foreign key constraints
7.TRIGGER - create triggers on table

Ex:
lets give:
accounting SELECT all tables
hr SELECT,UPDATE,and INSERT to emp table

GRANT SELECT ON ALL TABLES IN SCHEMA public TO accounting;
GRANT INSERT ON TABLE employees TO hr;
GRANT SELECT ON TABLE employees TO hr;
GRANT UPDATE ON TABLE employees TO hr;

--grant sales the ability to see customers table,and see and insert into orders and orderdetails table

GRANT SELECT ON ALL TABLES customers  TO sales;

GRANT SELECT ON TABLE orders TO sales;
GRANT SELECT ON TABLE order_details TO sales;

GRANT INSERT ON TABLE orders TO sales;
GRANT INSERT ON TABLE order_details TO sales;

Column level security:
controls the following:
1.SELECT - read the column
2. INSERT - insert data into column
3.UPDATE - update data into column
4.REFERENCES - permission to refer to a column in foreign keys

Ex:
Currently accounting can see everything about employees.
We want accounting to be able to see employees table,but hide some sensitive data like homephone address information, and birthdate.
Remember we granted SELECT ALL 

GRANT SELECT(employeeid, lastname, firstname, title, titleofcourtesy, hiredate, country, extension, photo, photopath)
ON employees
TO accounting;

REVOKE SELECT ON ALL TABLES IN SCHEMA public FROM accounting;

--You want sales people to be able to update customers but only the contactname, contacttitle,phone fields
GRANT UPDATE (contactname, contacttitle, phone)
ON customers
TO sales;

-ROW Level Security:
GRANT SELECT
ON TABLE orders
TO accounting;

ALTER TABLE orders
ENABLE ROW LEVEL SECURITY;

--Controlled by policy:
CREATE POLICY name
ON table_name
FOR SELECT|INSERT|UPDATE|DELETE
TO role
USING (expression)

Ex:
lets make a policy that lets accounting see all order that are later than Jan 01,1998
CREATE POLICY accounting_orders ON orders
FOR SELECT
TO accounting
USING (orderdate >= '1998-01-01');

What happens if more than one policy:
- Default is more data is added
- Conditions are combined with OR
- called permissive

Ex:
lets add a policy for accountants to see data for 1996:

CREATE POLICY accounting_orders_older ON orders
FOR SELECT
TO accounting
USING (orderdate <= '1996-12-31');

-Now can make restrictive
clause
AS RESTRICTIVE
 
 this will combine policies with AND
 
 Ex:
 DROP POLICY accounting_orders_older ON orders;
 
  CREATE POLICY accounting_orders_older ON orders
  AS RESTRICTIVE
  FOR SELECT TO accounting
  USING (customerid LIKE 'A%');
  
  --Add a policy for sales to be able to only updates sales that havent shipped.
  I.E. shippeddate is null
  
  CREATE POLICY sales_orders ON orders
  FOR UPDATE
  TO sales
  USING (shippeddate IS NULL);
