/*1Create two or three queries using address table in sakila db:

°include postal_code in where (try with in/not it operator)
°eventually join the table with city/country tables.
°measure execution time.
°Then create an index for postal_code on address table.
°measure execution time again and compare with the previous ones.
°Explain the results
2Run queries using actor table, searching for first and last name columns independently. Explain the differences and why is that happening?

3Compare results finding text in the description on table film with LIKE and in the film_text using MATCH ... AGAINST. Explain the results.*/


1-
SELECT postal_code
FROM 'address'
WHERE 20000 < postal_code AND postal_code < 80000
ORDER BY postal_code ASC;
#365 rows in set (0.06 sec)

SELECT *
FROM address a
JOIN city cty ON a.city_id = cty.city_id
JOIN country c ON cty.country_id = c.country_id
WHERE postal_code % 2 = 0
ORDER BY c.country_id;

#315 rows in set (0.04 sec)

CREATE INDEX postalCode ON address(postal_code);
#Query OK, 0 rows affected (0.26 sec)

#DESPUES INDEX:
#0.000
#0.000

2-
SELECT first_name
FROM actor
WHERE first_name LIKE "%ll%"
ORDER BY first_name;
#11 rows in set (0.01 sec)

SELECT last_name
FROM actor
WHERE last_name LIKE "%ll%"
ORDER BY last_name;
#19 rows in set (0.00 sec)

3-

SELECT `description`
FROM film
WHERE `description` LIKE "%epic%";
#42 rows in set (0.02 sec)

/*ADD FULLTEXT(description);*/

SELECT `description`
FROM film_text
WHERE MATCH(description) AGAINST("epic");
