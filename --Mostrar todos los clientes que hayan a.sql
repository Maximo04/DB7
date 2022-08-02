--Mostrar todos los clientes que hayan alquilado una pelicula pero que todavia no fueron devueltas
SELECT c.first_name, c.last_name, r.return_date FROM rental r JOIN customer c ON r.customer_id=c.customer_id WHERE rental_date LIKE NULL;
--Obtener todos los rental cuyo precio de alquiler este entre 2 y 7
SELECT r.rental_id, p.amount r.customer_id FROM rental r JOIN payment p ON r.rental_id = p.rental_id WHERE p.amount BETWEEN 2 AND 7;
--Mostrar el pago mayor y menor de cada cliente, resolver con subqueries. En una columna separada, listar sus pagos separados por comas
SELECT c.customer_id,c.first_name,c.last_name,(SELECT MIN(amount) FROM payment p WHERE c.customer_id =p.customer_id) AS lowest_payment ,(SELECT MAX(amount) FROM payment p WHERE c.customer_id =p.customer_id) AS highest_payment ,(SELECT GROUP_CONCAT(p.amount) FROM payment p WHERE p.customer_id = c.customer_id) FROM customer c;
--Mostrar el mayor y menor precio de las pelis, si se repite no mostrar
SELECT payment_id FROM rental r WHERE (SELECT MIN(amount) FROM payment p WHERE r.rental_id =p.custome_id)
--Obtener los pares de clientes que comparten el mismo nombre
SELECT first_name, last_name FROM customer c1 WHERE EXISTS (SELECT * FROM customer c2 WHERE c1.first_name = c2.first_name AND c1.customer_id <> c2.customer_id) order by first_name; 
--Listar todos los actores que actuaron en 'BETRAYED REAR' y 'CATCH AMISTAD' pero no en 'ACE GOLDFINGER'
SELECT first_name, last_name FROM actor a WHERE a.actor_id IN (SELECT actor_id FROM film_actor fa WHERE fa.film_id IN (SELECT f.film_id FROM film f WHERE f.title LIKE 'BETRAYED REAR' AND f.title LIKE 'CATCH AMISTAD' AND f.title NOT LIKE 'ACE GOLDFINGER'));
--Mostrar las peliculas que tienen mas de 4 actores
SELECT f.film_id, a.first_name,f.title FROM film f, actor a WHERE 4<(SELECT COUNT(*) FROM film WHERE film_id IN(SELECT film_id FROM film_actor));