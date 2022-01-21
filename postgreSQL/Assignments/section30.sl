JavaScript Object Notation=JSON
-text that is used to store and exchange data all over the web.
-written with JavaScript object notation

Ex:
{"title":"Deep Learning with Python","author":"Francois Chollet","publisher":"Manning"} 

TWO WAYS TO STORE IN POSTGRES
1.json datatype - stores exact copy of input text.
2.jsonb datatype - decomposed binary format that is parsed
json is faster to input since it is not processed,
jsonb is faster on function and operators since it is already parsed.also supports indexing.

EX:

CREATE TABLE books(
	id serial,
	bookinfo jsonb
)

