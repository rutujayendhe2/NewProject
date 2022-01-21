
--ALTER TABLE
--ALTER TABLE table_name RENAME column_oldname TO column_newname;
ALTER TABLE subscribers 
RENAME firstname TO first_name;

ALTER TABLE returns
RENAME datereturned TO return_date;

ALTER TABLE subscribers
RENAME to email_subscribers;

ALTER TABLE returns
RENAME to bad_orders;

--ADD FIELD 
--ALTER TABLE table_name ADD column datatype;
ALTER TABLE email_subscribers  ADD column last_visit_date timestamp;

ALTER TABLE bad_orders  ADD column reason text;

--DROP FIELD
--ALTER TABLE table_name DROP COLUMN column;
ALTER TABLE email_subscribers DROP COLUMN last_visit_date;

ALTER TABLE bad_orders DROP COLUMN reason;

--change datatype
--ALTER TABLE table_name ALTER COLUMN column SET DATA TYPE datatype;
ALTER TABLE email_subscribers ALTER COLUMN email SET DATA TYPE varchar(225);

ALTER TABLE bad_orders ALTER COLUMN quantity SET DATA TYPE int;

--DROP TABLE
DROP TABLE email_subscribers;

DROP TABLE bad_orders;







