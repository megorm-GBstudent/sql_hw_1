-- задание 1.
-- создадим базу данных hw_2
create database hw_2;

use hw_2;
-- создадим таблицу sales по заданным параметрам
create table sales
(
id int primary key auto_increment,
order_date date,
count_product int
);

-- занесем в таблицу заданные значения
insert sales (order_date, count_product)
values
("2022-01-01", "156"),
("2022-01-02", "180"),
("2022-01-03", "21"),
("2022-01-04", "124"),
("2022-01-05", "341");

-- проверим, что все добавилось 
select * from sales;
-- первое задание выполнено 

-- задание 2. необходимо указать тип заказа в зависимости от количества

select count_product,
case 
when count_product < 100 then 'маленький заказ'
when count_product between 100 and 300 then 'средний заказ'
else 'большой заказ'
end as 'тип заказа'
from sales;

-- код работает

-- задание 3. нужно создать таблицу и заполнить ее значениями.
create table orders 
(
id int primary key auto_increment,
employee_id char(3),
amount decimal,
order_status varchar(20)
);

-- занесем в таблицу заданные значения
insert orders (employee_id, amount, order_status)
values
("e03", "15.00", "open"),
("e01", "25.50", "open"),
("e05", "100.70", "closed"),
("e02", "22.18", "open"),
("e04", "9.50", "cancelled");

-- сделаем проверку. все работает
select * from orders;

-- продолжаем выполнять задание

select order_status,
case
when order_status = 'open' then 'order is in open state'
when order_status = 'close' then 'order is closed' 
else 'order is cancelled'
end as 'full_order_status'
from orders;

-- все работает

-- задание 4. нужно объяснить, чем 0 отличается от null
/* как я понимаю:
0 - это такое же значение, как и 1, 3, 5. То есть цифра,
которая показывает нам определенный результат
null - это пустое значение. Значит, в базе данных нет данных под 
эту конкретную ячейку