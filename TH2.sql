use TH2
--1
create table users(
id char primary key,
username char,
pwd int,
email char,
is_confirmed_email char);
create table reaction_types(
id char primary key,
name char,
icon_link char);
create table posts(
id char primary key,
created_by char,
foreign key(created_by) references users(id),
created_time time,
content char,
shared_post_id char,
foreign key(shared_post_id) references posts(id));
create table friendships(
id char primary key,
user_id_1 char,
foreign key(user_id_1) references users(id),
user_id_2 char,
foreign key(user_id_2) references users(id),
created_time time);
create table post_reaction(
id char primary key,
[user_id] char,
foreign key([user_id]) references users(id),
post_id char,
foreign key(post_id) references posts(id),
reaction_type_id char,
foreign key(reaction_type_id) references reaction_types(id),
created_time time);
create table comments(
id char primary key,
[user_id] char,
foreign key([user_id]) references users(id),
post_id char,
foreign key(post_id) references posts(id),
content char,
created_time time);

--2
create table teams(
id nvarchar(3) primary key,
team_name nvarchar(20),
coach nvarchar(40));

create table stadiums(
id int primary key identity,
stadium_name nvarchar(40));

create table games(
id int primary key identity(1001,1),
stadium_id int,
foreign key(stadium_id) references stadiums(id),
[date] date,
home_team_id nvarchar(3),
foreign key(home_team_id) references teams(id),
away_team_id nvarchar(3),
foreign key(away_team_id) references teams(id));

create table goals(
id int primary key identity,
game_id int,
foreign key(game_id) references games(id),
team_id nvarchar(3),
foreign key(team_id) references teams(id),
player nvarchar(50),
goal_time int);

SET IDENTITY_INSERT [dbo].[stadiums] ON 
GO
insert [dbo].[stadiums] (id,stadium_name)
values (1,N'Arena Lviv'),
(2,N'Donbass Arena'),(3,N'Metalist Stadium'),
(4,N'National Stadium, Warsaw'),
(5,N'Olimpiyskiy National Sports Complex'),(6,N'PGE Arena Gdansk'),
(7,N'Stadion Miejski (Poznan)'),
(8,N'Stadion Miejski (Wroclaw)');
SET IDENTITY_INSERT [dbo].[stadiums] OFF


insert into [teams] (id,team_name,coach)
values(N'CRO',N'Croatia',N'Slaven Bilic'),
(N'CZE',N'Czech Republic',N'Michal Bílek'),
(N'DEN',N'Denmark',N'Morten Olsen'),
(N'ENG',N'England',N'Roy Hodgson'),
(N'ESP',N'Spain',N'Vicente del Bosque'),
(N'FRA',N'France',N'Laurent Blanc'),
(N'GER',N'Germany',N'Joachim Löw'),
(N'GRE',N'Greece',N'Fernando Santos'),
(N'IRL',N'Republic of Ireland',N'Giovanni Trapattoni'),
(N'ITA',N'Italy',N'Cesare Prandelli'),
(N'NED',N'Netherlands',N'Bert van Marwijk'),
(N'POL',N'Poland',N'Franciszek Smuda'),
(N'POR',N'Portugal',N'Paulo Bento'),
(N'RUS',N'Russia',N'Dick Advocaat'),
(N'SWE',N'Sweden',N'Erik Hamrén'),
(N'UKR',N'Ukraine',N'Oleh Blokhin');
select * from games
select * from goals
--phan 2
select * from goals
where game_id=1031

select * from games
where [date] between '2012-06-12' and '2012-06-19'

alter table games
add [round] char(2)
update games
set [round]='QF'
where id between 1025 and 1028
update games
set [round]='SF' where id=1029 or id=1030
update games
set [round]='FI' where id=1031
update games
set [round]='RO' where round is null

select * from games
where [round]='SF'

alter table teams
add [group] char(1)
update teams
set [group]='A' where id='CZE' or id='GRE' or id='RUS' or id='POL'
update teams
set [group]='B' where id='GER' or id='POR' or id='DEN' or id='NED'
update teams
set [group]='C' where id='ESP' or id='ITA' or id='IRL' or id='CRO'
update teams
set [group]='D' where id='ENG' or id='FRA' or id='SWE' or id='UKR'

select [date] from games
where home_team_id='FRA' or away_team_id='FRA'

select player,game_id from goals
where team_id='GER'

select team_name,stadium_name from games
join stadiums on stadiums.id=games.stadium_id
join teams on teams.id=games.away_team_id or teams.id=games.home_team_id
where games.id=1012

select games.id from stadiums
join games on stadiums.id=games.stadium_id
	where stadiums.stadium_name='Arena Lviv'

select [date] from stadiums
join games on games.stadium_id=stadiums.id
where stadiums.stadium_name='Stadion Miejski (Poznan)'

select stadium_name,[date],player from goals
join games on games.id=goals.game_id
join stadiums on stadiums.id=games.stadium_id
where goals.team_id='ESP'

select teams.id from goals
join games on games.id=goals.game_id
join teams on teams.id=games.away_team_id or teams.id=games.home_team_id
where goals.player like '%Mario%'

select player,team_name,coach,goal_time from goals
join teams on teams.id=goals.team_id
where goal_time<=10

select games.id,[date] from teams
join games on games.home_team_id=teams.id
where teams.coach='Fernando Santos '

select distinct goals.player from games
join goals on goals.game_id=games.id
join stadiums on games.stadium_id=stadiums.id
where stadiums.stadium_name='National Stadium, Warsaw'

select distinct player from games
join goals on goals.game_id=games.id
where games.home_team_id='GER' or games.away_team_id='GER' 
and goals.team_id !='GER'

select distinct player from games
join goals on goals.game_id=games.id
where games.[round]='FI'

select stadium_name from games
join stadiums on stadiums.id=games.stadium_id
where games.[round]='QF'
