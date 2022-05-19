create new database imdb

'Create tables: film (film_id, title, description, release_year); actor (actor_id, first_name, last_name) , film_actor (actor_id, film_id)'
'Use autoincrement id'
'Create PKs'

create table film (film_id int not null auto_increment, title varchar(30),  descripcion varchar(40),  release_yea
r date,  primary key(film_id));


create table actor ( actor_id int not null auto_increment, first_name varchar(20), last_name varchar(30),  primary key(actor_id) );

create table ids (film_id int not null, actor_id int not null );

'Alter table add column last_update to film and actor'

alter table film add column last_update timestamp default current_timestamp on update current_timestamp ;

alter table actor add column last_update timestamp default current_timestamp on update current_timestamp ;


'Alter table add foreign keys to film_actor table'

	
alter table ids	add foreign key (film_id) references film(film_id),add foreign key (actor_id)references actor(actor_id);

'Insert some actors, films and who acted in each film'


insert into film (title, descripcion, release_year) values ('Baby: el aprendiz del crimen', 'Descripcion de Baby', '2017-01-01'), ('The Batman', 'Descripcion de The batman', '2022-04-03');

insert into actor (first_name, last_name) values  ('Harrison', 'Ford'), ('Sean', 'Connery'), ('Tom', 'Cruise'), ('Henry', 'Cravil');


