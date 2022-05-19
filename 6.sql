
SELECT first_name, last_name FROM actor a1 WHERE EXISTS (SELECT * FROM actor a2 WHERE a1.last_name = a2.last_name AND a1.actor_id != a2.actor_id) ORDER BY last_name;
