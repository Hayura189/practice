use TH3
--1
create table studio(
id int primary key,
name nvarchar(40));

create table aired_type(
id int primary key,
name nvarchar(40));

create table genre(
id int primary key,
name nvarchar(40));

create table source_type(
id int primary key,
name nvarchar(40));

create table anime(
id int primary key,
name nvarchar(40),
source_type_id int, foreign key(source_type_id) references source_type(id),
eps int,
eps_length int,
score float,
aired_type_id int, foreign key(aired_type_id) references aired_type(id),
aired_from date,
aired_to date);

create table anime_genre(
id int primary key,
anime_id int, foreign key(anime_id) references anime(id),
genre_id int, foreign key(genre_id) references genre(id));

create table anime_studio(
id int primary key,
anime_id int, foreign key(anime_id) references anime(id),
studio_id int, foreign key(studio_id) references studio(id));

--2
insert into source_type(id,name)
values (1,'Card game'),(2,'Book'),
(3,'Original'),(4,'Digital manga'),
(5,'Novel'),(6,'Radio'),(7,'Game'),
(8,'Manga'),(9,'Web manga'),(10,'Picture book'),
(11,'Other'),(12,'4-koma manga'),(13,'Visual novel'),
(14,'Light novel'),(15,'Music');

insert into aired_type(id,name)
values (1,'Movie'),(2,'ONA'),(3,'TV'),
(4,'Special'),(5,'OVA'),(6,'Music');

--3
--3.1
select count(id) from studio
--3.2
select count(id) from anime
--3.3
select count(id) from genre
--3.4
select name from anime
where (year(aired_from)=2008 or year(aired_to)=2008) or (year(aired_from)<2008 and year(aired_to)>2008)
--3.5
select name from anime
where name like 'O%'
--3.6
select name from anime where name like '%Doraemon%'
--3.7
select name from anime where name like '%Conan%' and aired_type_id=1
--3.8
select top(10) name from anime
order by score desc
--3.9
select top(20) * from anime
order by eps_length*eps desc
--3.10
select name from anime
where DATEDIFF(day,aired_from,isnull(aired_to,'2019-12-31'))>=5*365
order by score desc
--3.11
select top(25) name from anime order by eps desc
--3.12
select top(10) * from anime
where aired_from is not null
order by aired_from asc
--3.13
select studio.name, count(anime.id) from anime_studio
join studio on anime_studio.studio_id=studio.id
join anime on anime_studio.anime_id=anime.id
group by studio.name
order by count(anime.id) desc
--3.14
select top 1 studio.name,avg(score) as average_score from anime_studio
join studio on anime_studio.studio_id=studio.id
join anime on anime_studio.anime_id=anime.id
group by studio.name
order by avg(score) desc
--3.15
select top(5) genre.name from anime_genre
join anime on anime_genre.anime_id=anime.id
join genre on anime_genre.genre_id=genre.id
group by genre.name
order by count(anime.name) desc
--3.16
select anime_genre.genre_id,genre.name,avg(anime.score) as average_score from anime_genre
join anime on anime_genre.anime_id=anime.id
join genre on anime_genre.genre_id=genre.id
group by genre.name,anime_genre.genre_id
--3.17
select top(1) genre.name from anime_genre
join anime on anime_genre.anime_id=anime.id
join genre on anime_genre.genre_id=genre.id
where (year(anime.aired_from) between 2010 and 2014 and year(anime.aired_to) between 2010 and 2014)
or (year(anime.aired_from) <2010 and year(anime.aired_to) <=2014) 
or (year(anime.aired_from)>=2010 and year(anime.aired_from)<2014 and year(anime.aired_to)>2014)
group by genre.name
--3.18
select (year(aired_from)/10),count(id) from anime
group by (year(aired_from)/10)
--3.19
select anime.name from anime_studio
join anime on anime_studio.anime_id=anime.id
join studio on anime_studio.studio_id=studio.id
where studio.name='Studio Ghibli'
order by score desc
--3.20
select genre.name, count(anime.id) as [count] from anime_genre
join anime on anime_genre.anime_id=anime.id
join genre on genre.id=anime_genre.genre_id
join anime_studio on anime_studio.anime_id=anime.id
join studio on anime_studio.studio_id=studio.id
where studio.name = 'A-1 Pictures'
group by genre.name
--3.21
select anime.id,anime.name,anime_genre.genre_id from anime_genre
join anime on anime_genre.anime_id=anime.id
where anime_genre.genre_id is null
--3.22
select source_type.name, count(anime.source_type_id) from anime
join source_type on anime.source_type_id=source_type.id
group by source_type.name
--3.23
select count(anime.id) from source_type
join anime on anime.source_type_id=source_type.id
where year(anime.aired_from) >=2010
group by source_type.name
--3.24
select aired_type.name,sum(anime.eps*anime.eps_length) as [time] from aired_type
join anime on aired_type.id=anime.aired_type_id
group by aired_type.name
order by sum(anime.eps*anime.eps_length) desc
--3.25
select top(10) studio.name from anime_studio
join studio on anime_studio.studio_id=studio.id
join anime on anime_studio.anime_id=anime.id
join aired_type on aired_type.id=anime.aired_type_id
where aired_type.name='Movie'
group by studio.name
order by sum(anime.eps_length*anime.eps) desc









