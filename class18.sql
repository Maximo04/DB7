/*1--
Write a function that returns the amount of copies of a film in a store in sakila-db. Pass either the film id or the film name and the store id.
2--
Write a stored procedure with an output parameter that contains a list of customer first and last names separated by ";", that live in a certain country.
You pass the country it gives you the list of people living there. USE A CURSOR, do not use any aggregation function (ike CONTCAT_WS.
3--
Review the function inventory_in_stock and the procedure film_in_stock explain the code, write usage examples.*/


1--

DELIMITER $ /*It refers to a delimiter for our SQL queries, it allows you to tell MySQL that everything before a delimiter is part of a single block of code, you can choose any delimiter.*/

CREATE FUNCTION film_amount(film_id INT, st_id INT) RETURNS 
INT DETERMINISTIC /*directly related to:*/
BEGIN  /*The section between BEGIN and END is called the body of the stored procedure. You put the declarative SQL statements in the body to handle business logic. In this stored procedure, we use a simple SELECT statement to query data from the products table.*/
	DECLARE inte INT;
	SELECT
	    COUNT(i.inventory_id) INTO inte
	FROM film f
	    INNER JOIN inventory i USING(film_id)
	    INNER JOIN store st USING(store_id)
	WHERE
	    f.film_id = film_id
	    AND st.store_id = st_id;
	RETURN (inte);
END $ 

DELIMITER ;

SELECT film_amount(44,2);
/*+-------------------+
| film_amount(44,2) |
+-------------------+
|                 3 |
+-------------------+*/
2-- /*haciendo este ejercicio miti miti español ingles me di cuenta porque todo se hace en ingles, pero no quiero cambiarlo porque anda*/
DELIMITER $

DROP PROCEDURE IF EXISTS customer_list $

CREATE PROCEDURE customer_list(
	IN p_name VARCHAR(250), 
	OUT proced VARCHAR(500)
	) 
BEGIN 
	DECLARE finished INT DEFAULT 0;
	DECLARE nombre VARCHAR(250) DEFAULT ''; 
	DECLARE apellido VARCHAR(250) DEFAULT '';
	DECLARE pais VARCHAR(250) DEFAULT '';

	DECLARE cursList CURSOR FOR
	SELECT
	    co.country,
	    c.first_name,
	    c.last_name
	FROM customer c
	    INNER JOIN address USING(address_id)
	    INNER JOIN city USING(city_id)
	    INNER JOIN country co USING(country_id);
	
	DECLARE CONTINUE HANDLER FOR NOT FOUND SET finished = 1;

	OPEN cursList;

	looplabel: LOOP
		FETCH cursList INTO pais, nombre, apellido;
		IF finished = 1 THEN
			LEAVE looplabel;
		END IF;

		IF pais = p_name THEN
			SET proced = CONCAT(nombre,';',apellido);
		END IF;
		
		
	END LOOP looplabel;
	CLOSE cursList;
	

END $
DELIMITER ;

CALL customer_list('Brasil',@proced);

SELECT @proced;
/*@proced es una variable local
+---------+
| @proced |
+---------+
| NULL    |
+---------+
'Peru'
+----------------+
| @proced        |
+----------------+
| FREDDIE;DUGGAN |
+----------------+
*/
3--



-- INVENTORY_IN_STOCK
SHOW CREATE FUNCTION inventory_in_stock;
/*        | character_set_client | collation_connection | Database Collation |
+--------------------+----------------------------------------------------------------------------------------------------------------------------------+-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+----------------------+----------------------+--------------------+
| inventory_in_stock | STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_ENGINE_SUBSTITUTION | CREATE DEFINER=`maxim`@`%` FUNCTION `inventory_in_stock`(p_inventory_id INT) RETURNS tinyint(1)
    READS SQL DATA
BEGIN
    DECLARE v_rentals INT;
    DECLARE v_out     INT;

    #AN ITEM IS IN-STOCK IF THERE ARE EITHER NO ROWS IN THE rental TABLE
    #FOR THE ITEM OR ALL ROWS HAVE return_date POPULATED

    SELECT COUNT(*) INTO v_rentals
    FROM rental
    WHERE inventory_id = p_inventory_id;

    IF v_rentals = 0 THEN
      RETURN TRUE;
    END IF;

    SELECT COUNT(rental_id) INTO v_out
    FROM inventory LEFT JOIN rental USING(inventory_id)
    WHERE inventory.inventory_id = p_inventory_id
    AND rental.return_date IS NULL;

    IF v_out > 0 THEN
      RETURN FALSE;
    ELSE
      RETURN TRUE;
    END IF;
END | utf8mb4              | utf8mb4_0900_ai_ci   | utf8mb4_0900_ai_ci |
+--------------------+------------------------------------------------------------------*/
/*
Explaining of the code:
It returns a boolean using rentals and v_out wich are queris of inventory_id
*/

-- Examples of usage
SELECT inventory_in_stock(3333);
+--------------------------+
| inventory_in_stock(3333) |
+--------------------------+
|                        1 |
+--------------------------+ true

-- FILM_IN_STOCK
SHOW CREATE PROCEDURE film_in_stock;
/*-----+----------------------+----------------------+--------------------+
| film_in_stock | STRICT_TRANS_TABLES,STRICT_ALL_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,TRADITIONAL,NO_ENGINE_SUBSTITUTION | CREATE DEFINER=`maxim`@`%` PROCEDURE `film_in_stock`(IN p_film_id INT, IN p_store_id INT, OUT p_film_count INT)
    READS SQL DATA
BEGIN
     SELECT inventory_id
     FROM inventory
     WHERE film_id = p_film_id
     AND store_id = p_store_id
     AND inventory_in_stock(inventory_id);

     SELECT FOUND_ROWS() INTO p_film_count;
END | utf8mb4              | utf8mb4_0900_ai_ci   | utf8mb4_0900_ai_ci |*/

/*2 queris in one. 
1 shows different inventory_id, matching the film_id and store_id with its respective filters.
2 returns the total using your parameters. 
*/
-- Example of usage

mysql> CALL film_in_stock(10,10,@f);
Empty set (0.00 sec)

Query OK, 1 row affected (0.00 sec)

mysql> SELECT @f;
+------+
| @f   |
+------+
|    0 |
+------+ false
1 row in set (0.00 sec)



