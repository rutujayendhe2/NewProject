Basic Import/Export with copy
Copy data from database:
\COPY table TO 'file\location'

Ex:
Copy the customers table to hard drive
 northwind-# \copy customers TO 'customers.txt'
 
 Options for copy:
 \h copy
 FORMAT
 HEADER
 QUOTE
 DELIMITER
 FORCE_QUOTE
 
 Ex:
 lets save with CSV format,header and different text delimiter.then add forced text delimiter
 \copy customers TO 'customers.csv' WITH (HEADER, FORMAT CSV, QUOTE '"');
 head customers.csv;
 \copy customers TO 'customers.csv' WITH (HEADER, FORMAT CSV, QUOTE '"',FORCE_QUOTE(companyname, contactname, contacttitle, 
 address, city, region, country));
  head customers.csv;

  --How to save results of query:
  \COPY (SELECT....)TO 'file/location'
  
  Ex:
  Save orders from 1996
  \COPY (SELECT * FROM orders WHERE orderdate BETWEEN '01-01-1996' AND '12-31-1996')TO'orders1996.csv'WITH(FORMAT csv,HEADER)
  head orders1996.csv;
  
  --Loading saved data:
  COPY table FROM 'file/location'
  Appends data to existing file.
  
  Ex:
  download all the order details for productid 11 into a CSV format with header.
 \COPY(SELECT * FROM order_details WHERE productid=11)TO 'queso_order_details.csv'WITH(FORMAT CSV,HEADER);  
  head queso_order_details.csv;
  
  
  --Basic pg_dump and Restore
  Syntax:
  pg_dump database_name>/file/location
  
 Ex:
 lets dump northwind database
 pg_dump northwind > northwind.sql
 head northwind.sql
 
 Restoration:
 first create a database to put data
 createdb name
 then run file through psql
 psql name< /file/location
 
 Ex:
 --lets create northwind_bak and load the dump into it.
 createdb northwind_bak
 psql northwind_bak < northwind.sql

 --Make a backup of the usda database and restore to usda_bak
 pg_dump usda>usda.sql
 createdb usda_bak
 psql usda_bak < usda.sql

 --Custom Format Dumps
 Advantage
 Compress the data and allows partial restore
 Syntax:
 pg_dump -Fc database>/file/location
 
 EX:
 Do a custom format dump of northwind
 pg_dump -Fc northwind > northwind.fc
 ls -l northwind.*
 
--How to see whats in file
pg_restore --list/file/location

pg_restore --list northwind.fc

 --Restoring Custom Format
 pg_restore -j 2 -d some_name/file/location
 
 Ex:
 --Restore northwind to northwind_bak
 dropdb northwind_bak
 createdb northwind_bak
 pg_restore -j 4 -d northwind_bak northwind.fc
 
 --Partial Restore
 -t table_name
 
 Ex:
-- Drop usstates table and do a partial restore
  pg_restore -j 2 -d northwind -t usstates northwind.fc

--Make a custom format backup of usda and do a partial restore of table weight to original database.Be sure to drop weight in db.
pg_dump -Fc usda > usda.fc
pg_restore -j 4 -d usda -t weight usda.fc