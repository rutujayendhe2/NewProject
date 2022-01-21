JavaScript Object Notation=JSON
-text that is use to store and exchange data all over the web.
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

lets input some data:
INSERT INTO books(bookinfo)
VALUES ('{"title": "Introduction to Data Mining", "author": ["Pang-ning Tan","Michael Steinbach","Vipin Kumar"],
		"publisher": "Addison Wesley","date": 2006}');

--how to select data
->operator
SELECT bookinfo -> 'author'FROM books;
SELECT bookinfo FROM books;

--enter the following book:
Artificial Intelligence With Uncertainty by Deyi Li and Yi Du that was published in 2008 by Chapman and Hall
and select back the titles of all the books in table.

INSERT INTO books (bookinfo)
VALUES ('{"title": "Artificial Intelligence With Uncertainty", "author": ["Deyi Li","Yi Du"],
		"publisher": "Chapman and Hall", "date": 2008}');
		
SELECT bookinfo -> 'title' FROM books;


Use function jsonb_build_object()
syntax:
jsonb_build_object('field1',value1,'field2',value2,...)

Example:
lets create a simple version of airports into json

SELECT jsonb_build_object(
	'id', air.id,
	'ident', air.ident,
	'name', air.name,
	'latitude_deg', air.latitude_deg,
	'elevation_ft', air.elevation_ft,
	'iso_country', air.iso_country,
	'iso_region', air.iso_region,
	'airport_home_link', air.home_link,
	'airport_wikipedia_link', air.wikipedia_link,
	'municipality', air.municipality,
	'scheduled_service', air.scheduled_service,
	'gps_code', air.gps_code,
	'iata_code', air.iata_code,
	'airport_local_code', air.local_code
)

FROM airports AS air
LIMIT 5;


how to add array of keywords
STRING_TO_ARRAY(field,',')
And
TO_JSONB()

Example:
add the airport keywords field as an array.

SELECT jsonb_build_object(
	'airport_keywords', to_jsonb(string_to_array(air.keywords,',')),
	'id', air.id,
	'ident', air.ident,
	'name', air.name,
	'latitude_deg', air.latitude_deg,
	'elevation_ft', air.elevation_ft,
	'iso_country', air.iso_country,
	'iso_region', air.iso_region,
	'airport_home_link', air.home_link,
	'airport_wikipedia_link', air.wikipedia_link,
	'municipality', air.municipality,
	'scheduled_service', air.scheduled_service,
	'gps_code', air.gps_code,
	'iata_code', air.iata_code,
	'airport_local_code', air.local_code,
)

FROM airports AS air
WHERE air.keywords IS NOT NULL
LIMIT 5;

--Add to this query by joining countries and regions using iso_region and iso_country from airports table.pull back the name,
wikipedia_link and an array of keywords for both tables.
Use INNER JOIN.
SELECT jsonb_build_object(
	'airport_keywords', to_jsonb(string_to_array(air.keywords,',')),
	'id', air.id,
	'ident', air.ident,
	'name', air.name,
	'latitude_deg', air.latitude_deg,
	'elevation_ft', air.elevation_ft,
	'iso_country', air.iso_country,
	'iso_region', air.iso_region,
	'airport_home_link', air.home_link,
	'airport_wikipedia_link', air.wikipedia_link,
	'municipality', air.municipality,
	'scheduled_service', air.scheduled_service,
	'gps_code', air.gps_code,
	'iata_code', air.iata_code,
	'airport_local_code', air.local_code,
	'country_name', countries.name,
	'country_wikipedia_link', countries.wikipedia_link,
	'country_keywords', to_jsonB(string_to_array(air.keywords,',')),
	'region_name', regions.name,
	'region_wikipedia_link', regions.wikipedia_link,
	'region_keywords', to_jsonB(string_to_array(air.keywords,','))

)

FROM airports AS air
INNER JOIN regions ON air.iso_region=regions.code
INNER JOIN countries ON air.iso_country=countries.code
LIMIT 5;

How to get rid of nulls:
-use the function jsonb_strip_nulls()

SELECT jsonb_strip_nulls(jsonb_build_object(
	'airport_keywords', to_jsonb(string_to_array(air.keywords,',')),
	'id', air.id,
	'ident', air.ident,
	'name', air.name,
	'latitude_deg', air.latitude_deg,
	'elevation_ft', air.elevation_ft,
	'iso_country', air.iso_country,
	'iso_region', air.iso_region,
	'airport_home_link', air.home_link,
	'airport_wikipedia_link', air.wikipedia_link,
	'municipality', air.municipality,
	'scheduled_service', air.scheduled_service,
	'gps_code', air.gps_code,
	'iata_code', air.iata_code,
	'airport_local_code', air.local_code,
	'country_name', countries.name,
	'country_wikipedia_link', countries.wikipedia_link,
	'country_keywords', to_jsonB(string_to_array(air.keywords,',')),
	'region_name', regions.name,
	'region_wikipedia_link', regions.wikipedia_link,
	'region_keywords', to_jsonB(string_to_array(air.keywords,','))

))

FROM airports AS air
INNER JOIN regions ON air.iso_region=regions.code
INNER JOIN countries ON air.iso_country=countries.code

LIMIT 5;

--Aggregation JSON field:
first must convert to JSON:
Use a combination of to_json with subquery that pull back the records to group
SELECT to_json(subquery)FROM(
...subquery...
)AS subquery

Ex:
lets pull back the runways that belong to airport JRA (9 in total)

SELECT to_jsonb(runway_json) FROM 
(
	SELECT le_ident, he_ident, length_ft, width_ft, surface, lighted AS is_lighted, closed AS is_closed,
	he_latitude_deg, he_longitude_deg, he_elevation_ft, he_heading_degt, he_displaced_threshold_ft,
	le_latitude_deg, le_longitude_deg, le_elevation_ft, le_heading_degt, le_displaced_threshold_ft
	FROM runways
	WHERE airport_ident='JRA'
)AS runway_json

how to aggregate rows into array
JSONB_AGG() function

SELECT JSONB_AGG(to_jsonb(runway_json)) FROM 
(
	SELECT le_ident, he_ident, length_ft, width_ft, surface, lighted AS is_lighted, closed AS is_closed,
	he_latitude_deg, he_longitude_deg, he_elevation_ft, he_heading_degt, he_displaced_threshold_ft,
	le_latitude_deg, le_longitude_deg, le_elevation_ft, le_heading_degt, le_displaced_threshold_ft
	FROM runways
	WHERE airport_ident='JRA'
)AS runway_json

--Do the same aggregation for the navaids table for airport_ident_JRA
where associated_airport='CYYZ' 

SELECT JSONB_AGG(to_jsonb(nav))FROM
(
	SELECT name,filename,ident,type,frequency_khz,
	latitude_deg, longitude_deg, elevation_ft, dme_frequency_khz,
	dme_channel, dme_latitude_deg, dme_longitude_deg, dme_elevation_ft,
	slaved_variation_deg, magnetic_variation_deg, usagetype, power
	FROM navaids
	WHERE associated_airport = 'CYYZ'
)AS nav


--Building airports_json table:
combine information from all  tables
we will use a combination of JSON_BUILD_OBJECT and JSONB_AGG with subqueries to build an airports_json table

EX:
1.grab the json_build_oject from create JSON from table lecture.
2.make sure to rename jsonb_strip_null as airports
3.insert the navaids and runways subqueries from previous lecture.
4.change the specific airport in WHERE to air.ident for both
5.build a subquery for frequencies
6.test using a limit field
7.build a table based on query(takes a long time to run)


CREATE TABLE airports_json AS(
SELECT jsonb_build_object(
	'airport_keywords', to_jsonb(string_to_array(air.keywords,',')),
	'id', air.id,
	'ident', air.ident,
	'name', air.name,
	'latitude_deg', air.latitude_deg,
	'elevation_ft', air.elevation_ft,
	'iso_country', air.iso_country,
	'iso_region', air.iso_region,
	'airport_home_link', air.home_link,
	'airport_wikipedia_link', air.wikipedia_link,
	'municipality', air.municipality,
	'scheduled_service', air.scheduled_service,
	'gps_code', air.gps_code,
	'iata_code', air.iata_code,
	'airport_local_code', air.local_code,
	'country_name', countries.name,
	'country_wikipedia_link', countries.wikipedia_link,
	'country_keywords', to_jsonB(string_to_array(air.keywords,',')),
	'region_name', regions.name,
	'region_wikipedia_link', regions.wikipedia_link,
	'region_keywords', to_jsonB(string_to_array(air.keywords,',')),
	'runways',(SELECT JSONB_AGG(to_jsonb(runway_json)) FROM 
			  (SELECT le_ident, he_ident, length_ft, width_ft, surface, lighted AS is_lighted, closed AS is_closed,
				he_latitude_deg, he_longitude_deg, he_elevation_ft, he_heading_degt, he_displaced_threshold_ft,
				le_latitude_deg, le_longitude_deg, le_elevation_ft, le_heading_degt, le_displaced_threshold_ft
			  FROM runways
			  WHERE airport_ident=air.ident) AS runway_json),
	'navaids',(SELECT JSONB_AGG(to_jsonb(nav))FROM
				(SELECT name,filename,ident,type,frequency_khz,
					latitude_deg, longitude_deg, elevation_ft, dme_frequency_khz,
					dme_channel, dme_latitude_deg, dme_longitude_deg, dme_elevation_ft,
					slaved_variation_deg, magnetic_variation_deg, usagetype, power
				FROM navaids
				WHERE associated_airport =air.ident) AS nav),
	'frequencies',(SELECT JSONB_AGG(to_jsonb(nav))FROM 
				  (SELECT type, description, frequency_mhz
				  FROM airport_frequencies
				  WHERE airport_ident =air.ident) AS nav)

)
AS airports
FROM airports AS air
INNER JOIN regions ON air.iso_region=regions.code
INNER JOIN countries ON air.iso_country=countries.code
);
	
SELECT * FROM airports_json
LIMIT 3;
	
Selecting Information Out Of JSON fields:
Syntax for selecting JSON from JSON
operator ->
select based on key
-> text
select based on array index
-> number

--These can be chained
because they are returning JSON,they can be chained
airports -> 'runways'->2

Ex:
lets select first runway of each record and country name.
SELECT airports -> 'runways'->0, airports->'country_name'
FROM airports_json

--switch previous command to pull text instead of JSON
SELECT airports -> 'runways'->>0, airports->'country_name'
FROM airports_json

Select based on path:
#> - return JSON object at path
#>> - returns text of object at path

Ex:
SELECT'{"a":{"b":[3,2,1]}}'::jsonb #>'{a,b}' 
SELECT'{"a":{"b":[3,2,1],"c": {"d": 5}}}'::jsonb #>'{a,c,d}' 

--Return the 2nd feb of each airport as JSON and the region_name as text from the airports_json table, order by frequencies asc tomove nulls to bottom 
SELECT airports->'frequencies'->1, airports->>'region_name'
FROM airports_json
ORDER BY airports->'frequencies'->1 ASC;

Searching JSON Data:
first level attributes:
Containment operator : is the value on right contained in left hand side
field@>'{"iso_country":"BR"}
OR
Grab the field, will only returns rows that have field.
Field->>'iso_country'='BR'

Ex:
find all the airports in brazil and the count.
SELECT COUNT(*) FROM airports_json
WHERE airports @> '{"iso_country":"BR"}'

SELECT COUNT(*) FROM airports_json
WHERE airports ->>'iso_country' = 'BR'

--How many airports are in Arkansas in US:iso_region is US-AR
SELECT COUNT(*) FROM airports_json
WHERE airports @> '{"iso_region":"US-AR"}'

SELECT COUNT(*) FROM airports_json
WHERE airports ->>'iso_region' = 'US-AR'
	
Select based on nested attitude
column->'field'-->'field2'="value"
OR
column @>'{"field1":{"field2":"value"}}'

Ex:
--find no.of airports with the first runway being 2000 feet long
SELECT COUNT(*) FROM airports_json
WHERE airports->'runways'-> 0 @> '{"length_ft":2000}'

--find the no.of airports in which the 2nd navaid has a frequency of 400(remember array indexes start at 0)
SELECT COUNT(*) FROM airports_json
WHERE airports->'navaids'-> 1 @> '{"frequency_khz":400}'

Updating and deleting information inside JSON fields:	
--Updating Existing JSON
use the concatenation operator ||
this will add field or replace existing value of field.

UPDATE airports_json
SET airports = airports || '{"nearby_lakes": ["Lake Chicot","Lake Providence"]}'
WHERE airports->>'iso_region'='US-AR'
AND airports->>'municipality'='Lake Village';


SELECT airports->'nearby_lakes'
FROM airports_json
WHERE airports->>'iso_region'='US-AR'
AND airports->>'municipality'='Lake Village';

--Removing fields
2 operators:
1.-delete key/value pairs
2.#--delete based on path

Ex:
lets delete the fields we just created

UPDATE airports_json
SET airports = airports #- '{"nearby_lakes",1}'
WHERE airports->>'iso_region'='US-AR'
AND airports->>'municipality'='Lake Village';


SELECT airports->'nearby_lakes'
FROM airports_json
WHERE airports->>'iso_region'='US-AR'
AND airports->>'municipality'='Lake Village';

--Add a new field good_restaurants that is an array of 'La Terraza' and 'Mc Donalds' to the airport with id 20426.
then remove McDonalds from the array.

UPDATE airports_json
SET airports = airports || '{"good_restaurants":["La Terraza","McDonalds"]}'
WHERE airports->>'id'='20426';


SELECT airports->'good_restaurants'
FROM airports_json
WHERE airports->>'id'='20426';


UPDATE airports_json
SET airports = airports #- '{"good_restaurants",1}'
WHERE airports->>'id'='20426';

	
	
	
	
	
	
	
	
