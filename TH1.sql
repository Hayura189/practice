use THCSDL
--1
CREATE TABLE Customer(
id char primary key,
username char,
pwd char,
displayname char);
CREATE TABLE Vendor(
id char primary key,
vendor_name char,
ventor_website char);
CREATE TABLE Item(
id char primary key,
item_name char,
price real,
vendor char,
foreign key(vendor) REFERENCES Vendor(id),
item_description char);
CREATE TABLE Purchase_Hist(
id char primary key,
customer char,
foreign key (customer) REFERENCES Customer(id),
item char,
foreign key (item) REFERENCES Item(id),
vendor char,
foreign key(vendor) REFERENCES Vendor(id),
purchase_date time);
CREATE TABLE Reviews(
id char primary key,
customer char,
foreign key(customer) REFERENCES Customer(id),
item char,
foreign key(item) REFERENCES Item(id),
purchase_id char,
foreign key(purchase_id) REFERENCES Purchase_Hist(id),
rating real,
review char);


--2
CREATE TABLE Country(
id char primary key,
country_name char);
CREATE TABLE City(
id char primary key,
city char,
country char,
foreign key (country) REFERENCES Country(id));
CREATE TABLE Stadium(
id char primary key,
stadium char,
city char,
foreign key(city) REFERENCES City (id),
capacity int);
CREATE TABLE Team(
id char primary key,
team char,
home_stadium char,
foreign key(home_stadium) REFERENCES Stadium(id),
home_city char,
foreign key(home_city) REFERENCES City(id),
size real);
CREATE TABLE Player(
id char primary key,
team char,
foreign key(team) REFERENCES Team(id),
home_country char,
foreign key(home_country) REFERENCES Country(id),
match_num int,
cards_received int);
CREATE TABLE Matches(
id char primary key,
stadium char,
foreign key(stadium) REFERENCES Stadium(id),
team1 char,
foreign key (team1) REFERENCES Team(id),
team2 char,
foreign key (team2) REFERENCES Team(id),
match_time time,
result char,
score_team1 int,
score_team2 int);