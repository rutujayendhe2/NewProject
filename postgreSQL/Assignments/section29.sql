--Import CSV file:
copy command syntax:
COPY table(field1,field2,...)
FROM 'path\to\file'DELIMITER','CSVHEADER;

Example:
CREATE DATABASE airport;

create table airports (
	id int NOT NULL,
	ident varchar(10),
	type text,
	name text,
	latitude_deg float,
	longitude_deg float,
	elevation_ft int,
	continent text,
	iso_country varchar(10),
	iso_region varchar(10),
	municipality text,
	scheduled_service text,
	gps_code varchar(10),
	iata_code varchar(20),
	local_code varchar(20),
	home_link text,
	wikipedia_link text,
	keywords text
);

\copy airports (id,ident,type,name,latitude_deg,longitude_deg,elevation_ft,continent,iso_country,iso_region,municipality,scheduled_service,gps_code,iata_code,local_code,home_link,wikipedia_link,keywords)
FROM 'C:\Users\rutuja15274\Downloads\airports.csv' DELIMITER ',' CSV HEADER;
COPY 70225

--your turn

create table airport_frequencies (
	id int,
	airport_ref int,
	airport_ident varchar(10),
	type varchar(20),
	description text,
	frequency_mhz float
);

\copy airport_frequencies (id,airport_ref,airport_ident,type,description,frequency_mhz)FROM 'C:\Users\rutuja15274\Downloads\airport-frequencies.csv' DELIMITER ',' CSV HEADER;
COPY 28981

ASSignment:
1.create table in aiport for navaids and import the CSV file you downloaded.

CREATE TABLE navaids (
	id int,
	filename text,
	ident varchar(10),
	name text,
	type varchar(10),
	frequency_khz float,
	latitude_deg float,
	longitude_deg float,
	elevation_ft int,
	iso_country varchar(10),
	dme_frequency_khz float,
	dme_channel varchar(10),
	dme_latitude_deg float,
	dme_longitude_deg float,
	dme_elevation_ft int,
	slaved_variation_deg float,
	magnetic_variation_deg float,
	usageType char(10),
	power char(10),
	associated_airport varchar(10)
)

\copy navaids (id,filename, ident, name, type, frequency_khz, latitude_deg, longitude_deg, elevation_ft, iso_country, dme_frequency_khz, dme_channel, dme_latitude_deg, dme_longitude_deg, dme_elevation_ft, slaved_variation_deg,magnetic_variation_deg, usageType, power, associated_airport) FROM 'C:\Users\rutuja15274\Downloads\navaids.csv' DELIMITER ',' CSV HEADER;
COPY 11018

--2
CREATE TABLE regions (
	id int,
	code varchar(10),
	local_code varchar(10),
	name text,
	continent char(2),
	iso_country varchar(10),
	wikipedia_link text,
	keywords text
)

\copy regions (id,code, local_code, name, continent, iso_country, wikipedia_link, keywords) FROM 'C:\Users\rutuja15274\Downloads\regions.csv' DELIMITER ',' CSV HEADER;
COPY 3912
--3 country

CREATE TABLE countries (
	id int,
	code varchar(10),
	name text,
	continent char(2),
	wikipedia_link text,
	keywords text
)

\copy countries ( id,code, name, continent, wikipedia_link, keywords) FROM 'C:\Users\rutuja15274\Downloads\countries.csv' DELIMITER ',' CSV HEADER;
COPY 248

--4
CREATE TABLE runways (
	id int,
	airport_ref int,
	airport_ident varchar(10),
	length_ft int,
	width_ft int,
	surface text,
	lighted boolean,
	closed boolean,
	le_ident varchar(10),
	le_latitude_deg float,
	le_longitude_deg float,
	le_elevation_ft int,
	le_heading_degT float,
	le_displaced_threshold_ft int,
	he_ident varchar(10),
	he_latitude_deg float,
	he_longitude_deg float,
	he_elevation_ft int,
	he_heading_degT float,
	he_displaced_threshold_ft int
)

\copy runways ( id,airport_ref, airport_ident, length_ft, width_ft, surface, lighted, closed ,le_ident, le_latitude_deg, le_longitude_deg, le_elevation_ft, le_heading_degT, le_displaced_threshold_ft, he_ident, he_latitude_deg, he_longitude_deg, he_elevation_ft, he_heading_degT, he_displaced_threshold_ft)  FROM 'C:\Users\rutuja15274\Downloads\runways.csv' DELIMITER ',' CSV HEADER;
COPY 43145
