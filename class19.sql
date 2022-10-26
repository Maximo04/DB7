/*Create a user data_analyst
Grant permissions only to SELECT, UPDATE and DELETE to all sakila tables to it.
Login with this user and try to create a table. Show the result of that operation.
Try to update a title of a film. Write the update script.
With root or any admin user revoke the UPDATE permission. Write the command
Login again with data_analyst and try again the update done in step 4. Show the result.
*/
1-
CREATE USER data_analyst;
2-
GRANT SELECT, UPDATE, DELETE ON sakila.* TO 'data_analyst'@'%';
3-
CREATE TABLE t_test(
    id_t INT NOT NULL AUTO_INCREMENT
);  
-- ERROR 1142 (42000): CREATE command denied to user 'data_analyst'@'localhost' for table 't_test'
4-
SELECT * FROM film where film_id like '50';
--|      50 | BAKED CLEOPATRA | A Stunning Drama of a Forensic Psychologist And a Husband who must Overcome a Waitress in A Monastery |         2001 |           1 |                 NULL |               3 |        2.99 |    182 |            20.99 | G      | Commentaries,Behind the Scenes | 2022-09-28 08:49:30 |
UPDATE film SET title = 'The batman' WHERE film_id = 50;
--Query OK, 1 row affected (0.07 sec)
--Rows matched: 1  Changed: 1  Warnings: 0
SELECT * FROM film where film_id like '50';
--|      50 | The batman | A Stunning Drama of a Forensic Psychologist And a Husband who must Overcome a Waitress in A Monastery |         2001 |           1 |                 NULL |               3 |        2.99 |    182 |            20.99 | G      | Commentaries,Behind the Scenes | 2022-10-25 20:15:42 |
5
REVOKE UPDATE ON sakila.* FROM data_analyst;

SHOW GRANTS FOR 'data_analyst'@'%';
--| GRANT SELECT, DELETE ON `sakila`.* TO `data_analyst`@`%` |
6
SELECT * FROM film where film_id like '20';

UPDATE film SET title = 'Pelicula' WHERE film_id = 20;
-- ERROR 1142 (42000): UPDATE command denied to user 'data_analyst'@'localhost' for table 'film'
