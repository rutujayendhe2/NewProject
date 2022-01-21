----EXPRESSION INDEXES
EXPLAIN SELECT *
FROM production_product
WHERE name LIKE 'Flat%';

----EXPRESSION INDEXES
EXPLAIN SELECT *
FROM production.product
WHERE name LIKE 'Flat%';

CREATE INDEX idx_product_name
ON production.product (name);

EXPLAIN SELECT *
FROM production.product
WHERE UPPER(name) LIKE UPPER('Flat%');

CREATE INDEX idx_product_upper_name
ON production.product (UPPER(name));

CREATE INDEX idx_person_full_name
ON person.person ( (firstname ||''|| lastname) );

EXPLAIN SELECT *
FROM person.person
WHERE firstname ||''|| lastname ='Terri Duffy';



SIX TYPES INDEXES
-B-Tree:divides the information up into trees.
		kind of operation it works for 
		<,<=,=,>=,>
-Hash:Only handle equal operator 
-GIN:(Generalized Inverted Index)
	-Useful for data types that have multiple values in a column.
	-Arrays,Range types,JSONB,Hstore-key/value pairs.
	-@>and<@
	-&&
-Gist-(Generalize inverted search tree)
-BRIN-(Block Range Indexes)
-SP-GiST-(SP-Gist-Space Partitioned GiST)

CREATE EXTENSION pg_trgm;

CREATE INDEX trgm_idx_performance_test_location
ON performance_test USING gin
(location gin_trgm_ops);

CREATE INDEX idx_performance_test_name
ON performance_test (name);

EXPLAIN ANALYZE SELECT location
FROM performance_test
WHERE name LIKE '%dfe%';

EXPLAIN ANALYZE SELECT location
FROM performance_test
WHERE name LIKE 'dfe%';


EXPLAIN ANALYZE SELECT location
FROM performance_test
WHERE location LIKE '%dfe%';


