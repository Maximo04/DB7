/*1- Insert a new employee to , but with an null email. Explain what happens.

2- Run the first the query

UPDATE employees SET employeeNumber = employeeNumber - 20
What did happen? Explain. Then run this other
UPDATE employees SET employeeNumber = employeeNumber - 20
    -> ;
Query OK, 0 rows affected (0.03 sec)
Rows matched: 0  Changed: 0  Warnings: 0
Nothing happend

UPDATE employees SET employeeNumber = employeeNumber + 20
Explain this case also.

 UPDATE employees SET employeeNumber = employeeNumber + 20
    ->
    -> ;
Query OK, 0 rows affected (0.00 sec)
Rows matched: 0  Changed: 0  Warnings: 0

same here


3- Add a age column to the table employee where and it can only accept values from 16 up to 70 years old.

4- Describe the referential integrity between tables film, actor and film_actor in sakila db.

film actor contains all the ids from actors and film being a mediumspace where u can query which actor acted in a movie and viceversa 
5- Create a new column called lastUpdate to table employee and use trigger(s) to keep the date-time updated on inserts and updates operations. Bonus: add a column lastUpdateUser and the respective trigger(s) to specify who was the last MySQL user that changed the row (assume multiple users, other than root, can connect to MySQL and change this table).

6- Find all the triggers in sakila db related to loading film_text table. What do they do? Explain each of them using its source code for the explanation.

-1*/ 
INSERT INTO employees (employeeNumber,lastName,firstName,extension,email,officeCode,reportsTo,jobTitle)
VALUES (1111,'Rivero','Martin','unz294',NULL,'1',NULL,'Engineer');
/*This cant be null, its defined like that and its not gonna accept nulls*/

-2 solved in the assign
-3
ALTER TABLE employees 
ADD age TINYINT,
ADD CONSTRAINT ageCheck CHECK(age >= 16 and age <= 70);
4- solved in the assign
5-

ALTER TABLE employees
ADD lastUpdateUser VARCHAR(30) and ADD lastUpdate DATETIME;;

CREATE TRIGGER employees_before_update
	BEFORE UPDATE ON employees
	FOR EACH ROW
BEGIN
	SET NEW.lastUpdate = NOW();
	SET NEW.lastUpdateUser = SESSION_USER();
END;

-6
CREATE DEFINER=`user`@`%` TRIGGER `ins_film` AFTER INSERT ON `film` FOR EACH ROW BEGIN
    INSERT INTO film_text (film_id, title, description)
        VALUES (new.film_id, new.title, new.description);
  END
/*when a film is added it adds to filmtext too */

CREATE DEFINER=`user`@`%` TRIGGER `del_film` AFTER DELETE ON `film` FOR EACH ROW BEGIN
    DELETE FROM film_text WHERE film_id = old.film_id;
  END
/*when a film is deleted it deletes from filmtext too */
