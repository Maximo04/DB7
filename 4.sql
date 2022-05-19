/*1Show title and special_features of films that are PG-13
2Get a list of all the different films duration.
3Show title, rental_rate and replacement_cost of films that have replacement_cost from 20.00 up to 24.00
4Show title, category and rating of films that have 'Behind the Scenes' as special_features
5Show first name and last name of actors that acted in 'ZOOLANDER FICTION'
6Show the address, city and country of the store with id 1
7Show pair of film titles and rating of films that have the same rating.
8Get all the films that are available in store id 2 and the manager first/last name of this store (the manager will appear in all the rows).*/

#1
SELECT title, special_features, rating FROM film WHERE rating = 'PG-13';
#2
SELECT title, length FROM film order by title;
#3
SELECT title, rental_rate, replacement_cost FROM film WHERE replacement_cost BETWEEN '20' AND '24' ORDER BY replacement_cost;
#4 
SELECT f.title, c.name, f.rating, f.special_features FROM film f, category c WHERE special_features = 'Behind the Scenes';
#5
SELECT f.title, a.first_name, a.last_name FROM film_actor fa JOIN film f ON fa.film_id = f.film_id JOIN actor a ON fa.actor_id = a.actor_id WHERE f.title = 'ZOOLANDER FICTION'
#6
SELECT s.store_id, a.address, c.city, co.country FROM store s JOIN address a ON s.address_id = a.address_id JOIN city c ON a.city_id = c.city_id JOIN country co ON c.country_id = co.country_id WHERE s.store_id = 1;
#7
SELECT f1.title, f2.title, f1.rating FROM film f1, film f2 WHERE f1.rating = f2.rating;
#8
SELECT DISTINCT s.store_id, sf.first_name, sf.last_name, (f.title) FROM store s JOIN sfaff sf ON s.manager_staff_id = sf.staff_id JOIN inventory i ON s.store_id = i.store_id JOIN film f ON i.film_id = f.film_id WHERE s.store_id IN (2);

