/*1-Create a view named list_of_customers, it should contain the following columns:
customer id
customer full name,
address
zip code
phone
city
country
status (when active column is 1 show it as 'active', otherwise is 'inactive')
store id

2-Create a view named film_details, it should contain the following columns: film id, title, description, category, price, length, rating, actors - as a string of all the actors separated by comma. Hint use GROUP_CONCAT

3-Create view sales_by_film_category, it should return 'category' and 'total_rental' columns.

4-Create a view called actor_information where it should return, actor id, first name, last name and the amount of films he/she acted on.

5-Analyze view actor_info, explain the entire query and specially how the sub query works. Be very specific, take some time and decompose each part and give an explanation for each.

6-Materialized views, write a description, why they are used, alternatives, DBMS were they exist, etc.*/

1-
CREATE VIEW list_of_customers AS
  SELECT c.customer_id, CONCAT(c.first_name, ' ', c.last_name), a.address, a.postal_code, a.phone, c2.city, c3.country,
  	CASE
  		WHEN c.active = 1 THEN 'ACTIVE'
  		ELSE 'INACTIVE'
  	END AS status
  FROM customer c
  	INNER JOIN address a USING(address_id)
  	INNER JOIN city c2 USING(city_id)
  	INNER JOIN country c3 USING(country_id);

2-
CREATE VIEW film_details AS
	SELECT f.film_id, f.title, f.description, f.rental_rate, f.`length`, f.rating, GROUP_CONCAT(CONCAT_WS(" ", a.first_name, a.last_name) SEPARATOR ",") AS actors 
	FROM film f 
		INNER JOIN film_category fc USING(film_id)
		INNER JOIN category c USING(category_id)
		INNER JOIN film_actor fa USING(film_id)
		INNER JOIN actor a USING(actor_id)
	GROUP BY film_id;
3-
CREATE OR REPLACE VIEW sales_by_films_category AS
	SELECT DISTINCT c.name, SUM(p.amount) as total_rental
	FROM category c
		INNER JOIN film_category fc USING(category_id)
		INNER JOIN film f USING(film_id)
		INNER JOIN inventory i USING(film_id)
		INNER JOIN rental r USING(inventory_id)
		INNER JOIN payment p USING(rental_id)
	GROUP BY c.name;
4-
CREATE OR REPLACE VIEW actor_information AS
	SELECT a.actor_id, CONCAT_WS(" ", a.first_name, a.last_name) AS 'full name',
	(SELECT COUNT(f.film_id)
		FROM film f
			INNER JOIN film_actor fa USING(film_id)
			INNER JOIN actor a2 USING(actor_id)
		WHERE a2.actor_id = a.actor_id) AS 'amount of films he/she acted on'
	FROM actor a;
5-
SELECT VIEW_DEFINITION
FROM INFORMATION_SCHEMA.VIEWS
WHERE TABLE_NAME = 'actor_info';

