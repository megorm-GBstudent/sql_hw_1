-- задание 1. нужно написать запрос, который будет выводить столбцы в определенном порядке
-- создадим базу данных

create database hw_3;
use hw_3;
create table salespeople (
id int primary key auto_increment,
snum int,
sname varchar(20),
city varchar(20),
comm char(3)
);

-- занесем значения в базу данных
insert salespeople (snum, sname, city, comm)
values
('1001', 'Peel', 'London', '.12'),
('1002', 'Serres', 'San Jose', '.13'),
('1004', 'Motika', 'London', '.11'),
('1007', 'Rifkin', 'Barcelona', '.15'),
('1003', 'Axelrod', 'New York', '.10');

-- выполним проверку
select * from salespeople;

-- перейдем к выполнению задания

select city, sname, snum, comm
from salespeople;

-- первое задание выполнено)

-- второе задание. нужно сделать рейтинг по городу в жан хосе
-- создадим бд

create table customers (
id int primary key auto_increment,
cnum int,
cname varchar(20),
city varchar(20),
rating int,
snum int
);

-- заполним ее значениями

insert customers (cnum, cname, city, rating, snum)
values
('2001', 'Hoffman', 'London', '100', '1001'),
('2002', 'Giovanni', 'Rome', '200', '1003'),
('2003', 'Liu', 'SanJose', '200', '1002'),
('2004', 'Grass', 'Berlin', '300', '1002'),
('2006', 'Clemens', 'London', '100', '1001'),
('2008', 'Cisneros', 'SanJose', '300', '1007'),
('2007', 'Pereira', 'Rome', '100', '1004');

-- выполним проверку

select * from customers;

select cname, rating, id, city
from customers
where city = 'SanJose'
order by rating desc;

-- задание выполнено

-- задание 3. нужно вывести уникальные номера

select distinct snum, sname
from salespeople
order by snum desc;

-- они и так уникальные, но задание я сделал)

-- задание 4. нужно вывести имена, которые начинаются с g

select id, cname, city, rating
from customers
where cname like 'G%'
order by rating desc;

-- задание выполнено

-- задание 5. нужно вывести заказы с определенным фильтром по суммеalter
-- создадим таблицу

create table orders (
id int primary key auto_increment,
onum int,
amt decimal(6,2),
odate date,
cnum int,
snum int
);

-- внесем значения

insert orders (onum, amt, odate, cnum, snum)
values
('3001', '18.69', '1990-03-10', '2008', '1007'),
('3003', '767.19', '1990-03-10', '2001', '1001'),
('3002', '1900.10', '1990-03-10', '2007', '1004'),
('3005', '5160.45', '1990-03-10', '2003', '1002'),
('3006', '1098.16', '1990-03-10', '2008', '1007'),
('3009', '1713.23', '1990-04-10', '2002', '1003'),
('3007', '75.75', '1990-04-10', '2004', '1002'),
('3008', '4723.00', '1990-05-10', '2006', '1001'),
('3010', '1309.95', '1990-06-10', '2004', '1002'),
('3011', '9891.88', '1990-06-10', '2006', '1001');

-- выполним проверку

select * from orders;


-- выполним запрос: заказы выше 1000 долларов

select id, onum, amt
from orders
where amt > 1000
order by amt desc;



-- задание 6. наименьшая сумма заказа.

select min(amt)
from orders;


-- задание 7. рейтинг больше 100 и не в риме

select *
from customers
where city != 'Rome' and rating > 100
order by rating desc;



-- РАЗДЕЛ 2. я взял таблицу из семинара, так как она по структуре ничем не отличается

-- создадим таблицу
create table if not exists staff (
id int primary key auto_increment,
first_name varchar(45),
last_name varchar(45),
post varchar(45),
seniority int,
salary decimal(8,2),
age int
);

-- занесем данные
insert staff (first_name, last_name, post, seniority, salary, age)
values
('Вася', 'Петров', 'Начальник', 40, 100000, 60),
('Петр', 'Власов', 'Начальник', 8, 70000, 30),
('Катя', 'Катина', 'Инженер', 2, 70000, 25),
('Саша', 'Сасин', 'Инженер', 12, 50000, 35),
('Иван', 'Петров', 'Рабочий', 40, 30000, 59),
('Петр', 'Петров', 'Рабочий', 20, 55000, 60),
('Сидр', 'Сидоров', 'Рабочий', 10, 20000, 35),
('Антон', 'Антонов', 'Рабочий', 8, 19000, 28),
('Юрий', 'Юрков', 'Рабочий', 5, 15000, 25),
('Максим', 'Петров', 'Рабочий', 2, 11000, 19),
('Юрий', 'Петров', 'Рабочий', 3, 12000, 24),
('Людмила', 'Маркина', 'Уборщик', 10, 10000, 49),
('Петр', 'Петров', 'Главный инженер', 45, 125000, 65);

-- выполним проверку
select * from staff;

-- перейдем к заданиям
-- отсортируем по зп по возрастанию
select * from staff
order by salary;

-- отсортируем по зп по убыванию
select * from staff
order by salary desc;

/* задание 2. нужно было вывести 5 строк с наибольшей зп.
я хотел через подзапрос, но что-то не получилось */

select salary 
from staff
where salary = (select salary from staff order by salary desc limit 5);

-- но я выполнил эту задачу более простым способом, который работает в данном случае
select * 
from staff 
order by salary desc 
limit 5;


-- задание 3. группировка сотрудников, зп которых > 100000

select post,
sum(salary) as "суммарная зп"
from staff
group by post
having sum(salary) > 100000;

