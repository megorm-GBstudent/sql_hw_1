create database pets;
show databases;
use pets;

create table cat (
id int primary key auto_increment,
age int,
name varchar(30)
);

insert into cat (age, name)
values
('12', 'Bob'),
('3', 'Tom'),
('1', 'Denis');

select * from cat;

select * from cat
order by age desc, name;

select * from cat
where name = 'Tom' and age = '5';


create database lesson_5;
show databases;
use lesson_5;

DROP TABLE IF EXISTS `T`;
CREATE TABLE `T` (
  `TB` varchar(1) NOT NULL,
  `ID_CLIENT` int unsigned NOT NULL,
  `ID_DOG` int unsigned NOT NULL,
  `OSZ` int unsigned NOT NULL,
  `PROCENT_RATE` int unsigned NOT NULL,
  `RATING` int unsigned NOT NULL,
  `SEGMENT` varchar(45) NOT NULL,
  UNIQUE KEY `ID_DOG_UNIQUE` (`ID_DOG`)
);

INSERT INTO `T` VALUES ('A',1,111,100,6,10,'SREDN'),('A',1,222,150,6,10,'SREDN'),('A',2,333,50,9,15,'MMB'),('B',1,444,200,7,10,'SREDN'),('B',3,555,1000,5,16,'CIB'),('B',4,666,500,10,20,'CIB'),('B',4,777,10,12,17,'MMB'),('C',5,888,20,11,21,'MMB'),('C',5,999,200,9,13,'SREDN');

select * from T;


SELECT DISTINCT
  TB,
  SEGMENT,
  MAX(OSZ) OVER (PARTITION BY TB) AS "Максимальная задолженность в разбивке по банкам",
  AVG(PROCENT_RATE) OVER (PARTITION BY TB, SEGMENT) AS "Средняя процентная ставка в разрезе банка и сегмента",
  COUNT(1) OVER() AS "Всего договоров во всех банках",
  COUNT(1) OVER (PARTITION BY TB) AS "Всего договоров в разбивке по банкам"
FROM T;

DROP TABLE IF EXISTS `Table_Rev`;
CREATE TABLE `Table_Rev` (
  `ID` int unsigned NOT NULL AUTO_INCREMENT, 
  `TB` varchar(1) NOT NULL, # Код банка
  `DEP` varchar(45) NOT NULL, # Код отдела
  `Count_Revisions` int unsigned NOT NULL,  # Количество ревизий
  PRIMARY KEY (`ID`),
  UNIQUE KEY `ID_UNIQUE` (`ID`)
);

iNSERT INTO `Table_Rev` VALUES (1,'A','Corp',100),(2,'A','Rozn',47),(3,'A','IT',86),
(4,'B','Corp',70),(5,'B','Rozn',65),(6,'B','IT',58),(7,'C','Corp',42),(8,'C','Rozn',40),
(9,'C','IT',63),(10,'D','Corp',95),(11,'D','Rozn',120),(12,'D','IT',85),(13,'E','Corp',70),
(14,'E','Rozn',72),(15,'E','IT',80),(16,'F','Corp',66),(17,'F','Rozn',111),(18,'F','IT',33);

SELECT * FROM Table_Rev;

SELECT *, 
  ROW_NUMBER() OVER (ORDER BY Count_Revisions DESC) AS ROW_NUMBER_REV,
  RANK() OVER (ORDER BY Count_Revisions DESC) AS RANK_REV,
  DENSE_RANK() OVER (ORDER BY Count_Revisions DESC) AS DENSE_RANK_REV,
  NTILE(7) OVER (ORDER BY Count_Revisions DESC) AS NTILE_REV
FROM Table_Rev;

SELECT * FROM Table_Rev;

select tb, dep,
max(Count_Revisions) over (partition by tb, dep)
from Table_Rev;

select * from Table_Rev
where Count_Revisions != (select max(Count_Revisions) from Table_Rev)
order by Count_Revisions desc;

select *,
dense_rank() over(partition by tb order by count_revisions desc) ds
from Table_Rev;

select *,
dense_rank() over(partition by tb order by count_revisions desc) ds
from Table_Rev;

with t_r as
 (
 select *,
dense_rank() over(partition by tb order by count_revisions desc) ds
from Table_Rev
)
select tb, dep,count_revisions, ds
from t_r
where ds = 2;


DROP TABLE IF EXISTS `Table_Task`;
CREATE TABLE `Table_Task` (
  `id` int unsigned NOT NULL AUTO_INCREMENT,
  `id_task` int unsigned NOT NULL,
  `event` varchar(45) NOT NULL,
  `date_event` date NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `id_UNIQUE` (`id`)
);

INSERT INTO `Table_Task` VALUES (1,1,'Open','2020-02-01'),(2,1,'To_1_Line','2020-02-02'),(3,1,'To_2_Line','2020-02-03'),(4,1,'Successful','2020-02-04'),(5,1,'Close','2020-02-05'),(6,2,'Open','2020-03-01'),(7,2,'To_1_Line','2020-03-02'),(8,2,'Denied','2020-03-03'),(9,3,'Open','2020-04-01'),(10,3,'To_1_Line','2020-04-02'),(11,3,'To_2_Line','2020-04-03');

SELECT * FROM Table_Task;

-- дз 5. создадим базу данных

create database hw_5;
use hw_5;

-- создадим таблицу

CREATE TABLE cars
(
	id INT NOT NULL PRIMARY KEY,
    name VARCHAR(45),
    cost INT
);

-- внесем значения

INSERT cars
VALUES
	(1, "Audi", 52642),
    (2, "Mercedes", 57127 ),
    (3, "Skoda", 9000 ),
    (4, "Volvo", 29000),
	(5, "Bentley", 350000),
    (6, "Citroen ", 21000 ), 
    (7, "Hummer", 41400), 
    (8, "Volkswagen ", 21600);
   
-- выполним проверку
   
SELECT *
FROM cars;

-- создадим представление для машин, стоимость которых ниже 25000

create view cars_view
as
select id, name, cost
from cars
where cost < 25000 
order by cost desc;

-- проверим решение

select * from cars_view;

-- изменим условие (стоимость меньше 30000)

alter view cars_view as
select id, name, cost
from cars
where cost < 30000 
order by cost desc;

-- проверим решение

select * from cars_view;

-- нужно вывести те строки, где название шкода или ауди
-- я ошибся в запросе, поэтому сразу сделал с ALTER

alter view name_view as
select id, name, cost
from cars
where name = 'Skoda' or name = 'Audi'
order by cost desc;

-- выполним проверку

select * from name_view;

-- задание 2. создадим базу данных

drop table if exists train;
create table train (
id int primary key auto_increment,
train_id int unsigned not null,
station varchar(45),
station_time time
);

-- внесем данные

insert into train (train_id, station, station_time)
values
('110', 'San Francisco', '10:00:00'),
('110', 'Redwood City', '10:54:00'),
('110', 'Palo Alto', '11:02:00'),
('110', 'San Jose', '12:35:00'),
('120', 'San Francisco', '11:00:00'),
('120', 'Palo Alto', '12:49:00'),
('120', 'San Jose', '13:30:00');

-- выполним проверку

select * from train;

/* приступим к заданию. нам нужно добавить новый столбец 
"время до следующей станции"
используя функцию lead */

select *,
lead (station_time, 1, '00:00:00') over (partition by train_id order by station_time) as time_end,
timestampdiff('minute','time_end', 'time_station') as time_process
from train;
