--Find the films with less duration, show the title and rating.
SELECT title, rating, length FROM film f1 WHERE `length`=(SELECT MIN(`length`) FROM film f2);
--Write a query that returns the tiltle of the film which duration is the lowest. If there are more than one film with the lowest durtation, the query returns an empty resultset.
SELECT title, length FROM film f1 WHERE `length`< ALL(SELECT length FROM film f2);
--Generate a report with list of customers showing the lowest payments done by each of them. Show customer information, the address and the lowest amount, provide both solution using ALL and/or ANY and MIN.
SELECT first_name, last_name, address, (SELECT MIN(amount) FROM payment p WHERE c.customer_id =p.customer_id) AS lowest_payment FROM customer c JOIN address a ON c.address_id =a.address_id; 
--Generate a report that shows the customer's information with the highest payment and the lowest payment in the same row.
SELECT first_name, last_name, address, (SELECT MIN(amount) FROM payment p WHERE c.customer_id =p.customer_id) AS lowest_payment,(SELECT MAX(amount) FROM payment p WHERE c.customer_id =p.customer_id) AS highest_payment  FROM customer c JOIN address a ON c.address_id =a.address_id; 