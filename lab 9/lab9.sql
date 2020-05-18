create table actor(act_id int,
act_name varchar(20),
act_gender varchar(1),
primary key(act_id));

create table director(
dir_id int,
dir_name varchar(20),
dir_phone varchar(10),
primary key(dir_id));

create table movies(
mov_id int,
mov_title varchar(20),
mov_year varchar(5),
mov_lang varchar(20),
dir_id int,
primary key(mov_id),
foreign key(dir_id) references director(dir_id));

create table movie_cast(
act_id int,
mov_id int,
role varchar(20),
foreign key(act_id) references actor(act_id),
foreign key(mov_id) references movies(mov_id));

create table rating(
mov_id int,
rev_stars int,
foreign key(mov_id) references movies(mov_id));

insert into actor values('&act_id','&act_name','&act_gender');
select * from actor;

insert into rating values('&mov_id','&rev_stars');
select * from rating;

insert into movies values('&mov_id','&mov_title','&mov_year','&mov_lang','&dir_id');
select * from movies;

insert into director values('&dir_id','&dir_name','&dir_phone');
select * from director;

insert into movie_cast values('&act_id','&mov_id','&role');
select * from movie_cast;


select mov_title from movies
where dir_id in (select dir_id from director
where dir_name='Hitchcock');

select mov_title from movies m, movie_cast mv
where m.mov_id=mv.mov_id and act_id in( select act_id
from movie_cast group by act_id
having count( act_id)>1)
group by mov_title having count(*)>1;

select act_name from actor a
join movie_cast c on
a.act_id=c.act_id
join movies m on
c.mov_id=m.mov_id
where m.mov_year not between 2000 and 2015;

select mov_title ,max(rev_stars) from movies
inner join rating using(mov_id)
group by mov_title having max(rev_stars)>0
order by mov_title;

update rating
set rev_stars=5 where mov_id
in(select mov_id from movies where dir_id
in(select dir_id from director where dir_name='Steven Spielberg'));
select * from rating;
