Q1.Select all fields, and all records from actor table
SELECT * FROM actor;

Q2.Select all fields and records from film table
SELECT * FROM film;

Q3.Select all fields and records from the staff table
SELECT * FROM staff;

Q4.Select address and district columns from address table
SELECT * FROM address;
SELECT DISTINCT address_id FROM address;

Q5.Select title and description from film table
SELECT title, description FROM film;

Q6.Select city and country_id from city table
SELECT city, country_id FROM city;

Q7.Select all the distinct last names from customer table
SELECT DISTINCT last_name FROM customer;

Q8.Select all the distinct first names from the actor table
SELECT DISTINCT first_name FROM actor;

Q9.Select all the distinct inventory_id values from rental table
SELECT DISTINCT inventory_id FROM rental;

Q10.Find the number of films ( COUNT ).
SELECT COUNT (*) FROM film;

Q11.Find the number of categories.
SELECT COUNT (*) FROM category;

Q12.Find the number of distinct first names in actor table
SELECT COUNT (DISTINCT first_name) FROM actor;

Q13.Select rental_id and the difference between return_date and rental_date in rental table
SELECT rental_id, return_date-rental_date From rental;

