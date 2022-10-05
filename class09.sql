/*Get the amount of cities per country in the database. Sort them by country, country_id.*/

SELECT c2.country,COUNT(c.city) AS quantity_cities FROM city c JOIN country c2 ON c2.country_id = c.country_id GROUP BY c2.country, c2.country_id ORDER BY c2.country_id;

/*Get the amount of cities per country in the database. Show only the countries with more than 10 cities, order from the highest amount of cities to the lowest */

SELECT c2.country,COUNT(c.city) AS quantity_cities FROM city c JOIN country c2 ON c2.country_id = c.country_id GROUP BY c2.country, c2.country_id HAVING COUNT(c.city)>10 ORDER BY quantity_cities DESC;

/*Generate a report with customer (first, last) name, address, total films rented and the total money spent renting films.*/

SELECT c.first_name,c.last_name,a.address,(SELECT COUNT(*) FROM rental r WHERE c.customer_id = r.customer_id) AS total_rented, (SELECT SUM(p.amount) FROM payment p WHERE c.customer_id = p.customer_id) AS total_spent FROM customer c JOIN address a ON a.address_id = c.address_id ORDER BY total_spent DESC;

/*Show the ones who spent more money first .
Which film categories have the larger film duration (comparing average)?*/

SELECT c.name,AVG(f.`length`) AS average_lenght_category FROM film f JOIN film_category fc ON fc.film_id = f.film_id JOIN category c ON fc.category_id = c.category_id GROUP BY c.name ORDER BY AVG(f.`length`) DESC;

/*Order by average in descending order
Show sales per film rating*/
SELECT f.rating, COUNT(p.payment_id) FROM film f JOIN inventory i ON i.film_id = f.film_id JOIN rental r ON r.inventory_id = i.inventory_id JOIN payment p ON p.rental_id = r.rental_id  GROUP BY rating;





























CREATE TABLE abs_detail(id_name not null ,mail varchar(50),abs float, justified boolean primary key(id_name));
