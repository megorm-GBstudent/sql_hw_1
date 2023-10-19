create database hw_4;
use hw_4;

/* задание 1. Вывести на экран, сколько машин каждого 
цвета для машин марок BMW и LADA */

-- создадим таблицу

CREATE TABLE  AUTO 
(       
	REGNUM VARCHAR(10) PRIMARY KEY, 
	MARK VARCHAR(10), 
	COLOR VARCHAR(15),
	RELEASEDT DATE, 
	PHONENUM VARCHAR(15)
    );
 
 -- заполним ее данными
 
    INSERT INTO AUTO (REGNUM, MARK,	COLOR, RELEASEDT, PHONENUM )
VALUES(111114,'LADA', 'КРАСНЫЙ', date'2008-01-01', '9152222221');


INSERT INTO AUTO (REGNUM, MARK,	COLOR, RELEASEDT, PHONENUM )
VALUES(111115,'VOLVO', 'КРАСНЫЙ', date'2013-01-01', '9173333334');


INSERT INTO AUTO (REGNUM, MARK,	COLOR, RELEASEDT, PHONENUM )
VALUES(111116,'BMW', 'СИНИЙ', date'2015-01-01', '9173333334');


INSERT INTO AUTO (REGNUM, MARK,	COLOR, RELEASEDT, PHONENUM )
VALUES(111121,'AUDI', 'СИНИЙ', date'2009-01-01', '9173333332');


INSERT INTO AUTO (REGNUM, MARK,	COLOR, RELEASEDT, PHONENUM )
VALUES(111122,'AUDI', 'СИНИЙ', date'2011-01-01', '9213333336');


INSERT INTO AUTO (REGNUM, MARK,	COLOR, RELEASEDT, PHONENUM )
VALUES(111113,'BMW', 'ЗЕЛЕНЫЙ', date'2007-01-01', '9214444444');


INSERT INTO AUTO (REGNUM, MARK,	COLOR, RELEASEDT, PHONENUM )
VALUES(111126,'LADA', 'ЗЕЛЕНЫЙ', date'2005-01-01', null);


INSERT INTO AUTO (REGNUM, MARK,	COLOR, RELEASEDT, PHONENUM )
VALUES(111117,'BMW', 'СИНИЙ', date'2005-01-01', null);


INSERT INTO AUTO (REGNUM, MARK,	COLOR, RELEASEDT, PHONENUM )
VALUES(111119,'LADA', 'СИНИЙ', date'2017-01-01', 9213333331);

-- выполним проверку

select * from auto;

-- приступим к заданию

select count(color), color, mark
from auto
where mark = "BMW" or mark = "LADA"
group by color, mark;

-- первое задание выполнено

/* задание 2. Вывести на экран марку авто(количество) и количество авто не этой 
марки */
-- first variant
select count(mark) as 'количество машин этой марки', mark, 
(select count(mark) from auto 
where mark = sum(mark) - count(mark)) as ' количество машин не этой марки'
from auto
group by mark;

-- second variant

select count(mark) as 'количество машин этой марки', mark, 
(select count(mark) from auto 
where mark != 'количество машин этой марки')
as ' количество машин не этой марки'
from auto
group by mark;

-- third variant 

select count(mark) as 'количество машин этой марки', mark, 
(select count(mark) from auto 
where mark != 'количество машин этой марки' - 
(select count(mark) from auto group by mark))
as ' количество машин не этой марки'
from auto
group by mark;

/* у меня не получается это сделать. 
я даже сумму как-то странно нашел. по идее нужно только вычесть, но я 
не знаю как. я даже пробовал апдейт через добавление нового столбца,
но выдает ошибку */



/* задание 3. Напишите запрос, который вернет строки из таблицы test_a, 
id которых нет в таблице test_b, НЕ используя ключевого слова NOT */

-- создадим 2 таблицы

create table test_a (
id INT, 
test varchar(10)
);

create table test_b (
id INT
);

-- добавим данные в 2 таблицы

insert into test_a (id, test) 
values
(10, 'A'),
(20, 'A'),
(30, 'F'),
(40, 'D'),
(50, 'C');

insert into test_b (id) 
values
(10),
(30),
(50);

-- произведем проверку

select * from test_a;
select * from test_b;

-- приступим к заданию
select a.id, test
from test_a a
left join test_b b
on a.id = b.id
where b.id is null;

-- задание выполнено


