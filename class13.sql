/*Add a new customer
1
To store 1
For address use an existing address. The one that has the biggest address_id in 'United States'
Add a rental
2
Make easy to select any film title. I.e. I should be able to put 'film tile' in the where, and not the id.
Do not check if the film is already rented, just use any from the inventory, e.g. the one with highest id.
Select any staff_id from Store 2.
3
Update film year based on the rating
For example if rating is 'G' release date will be '2001'
You can choose the mapping between rating and year.
Write as many statements are needed.
4
Return a film
Write the necessary statements and queries for the following steps.
Find a film that was not yet returned. And use that rental id. Pick the latest that was rented for example.
Use the id to return the film.
5
Try to delete a film
Check what happens, describe what to do.
Write all the necessary delete statements to entirely remove the film from the DB.
6
Rent a film
Find an inventory id that is available for rent (available in store) pick any movie. Save this id somewhere.
Add a rental entry
Add a payment entry
Use sub-queries for everything, except for the inventory id that can be used directly in the queries.
Once you're done. Restore the database data using the populate script from class 3.*/


/*1*/
insert into customer(store_id,first_name,last_name,email,address_id,active)
select
1,'Martin','Rivero','maximorivero0410@gmail.com',max(a.address_id),1
from address a
inner join city ci using(city_id)
inner join country co on ci.country_id = co.country_id
where co.country = 'United States';

select * from customer where first_name = 'Martin';


/*2*/
select * from rental;

insert into rental (rental_date,inventory_id,customer_id,return_date,staff_id)
select CURRENT_TIMESTAMP, (select MAX(i.inventory_id) from inventory i inner join film f using(film_id) where f.title like 'ZHIVAGO CORE'),600, NULL, (select manager_staff_id from store where store_id = 2 order by RAND()LIMIT 1);
select * from rental where customer_id = 600;

/*3*/
select distinct rating
from film;

update film  set release_year = 2000  where rating = 'PG';
update film set  release_year = 2001 where  rating ='G';
update film set release_year = 2002 where rating ='PG-13';
update film set release_year = 2003 where rating ='R';
update film set release_year = 2004 where rating = 'NC-17';

select * from film where rating = 'PG';
/*4*/
select r.rental_id
from film f
    inner join inventory i using(film_id)
    inner join rental r using(inventory_id)
where r.return_date is NULL
order by r.rental_date DESC
LIMIT 1;
/*16050*/
/*5*/
select *
from film
order by film_id ASC
LIMIT 1;

delete from film where title = 'ACADEMY DINOSAUR';
/*ERROR 1451 (23000): Cannot delete or update a parent row: a foreign key constraint fails (`sakila`.`film_actor`, CONSTRAINT `fk_film_actor_film` FOREIGN KEY (`film_id`) REFERENCES `film` (`film_id`) ON DELETE RESTRICT ON UPDATE CASCADE)*/
set FOREIGN_KEY_CHECKS = 0;
delete from film where title = 'ACADEMY DINOSAUR';
set FOREIGN_KEY_CHECKS = 1;

/*6*/
select inventory_id, film_id
from inventory
where inventory_id not in (select inventory_id from inventory inner join rental using (inventory_id)where return_date is NULL);
insert into rental (rental_date, inventory_id, customer_id, staff_id)
	values(CURRENT_DATE(), 10,(select customer_id from customer order by customer_id DESC LIMIT 1),(select staff_id from staff where store_id = (select store_id from inventory where inventory_id = 10)));
insert into payment (customer_id, staff_id, rental_id, amount, payment_date)
	values((select customer_id from customer order by customer_id DESC LIMIT 1),(select staff_id from staff LIMIT 1),(select rental_id from rental order by rental_id DESC LIMIT 1) ,(select rental_rate from film where film_id = 2),CURRENT_DATE());
    
