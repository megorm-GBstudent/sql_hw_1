-- Задание 1. Создать таблицу с мобильными телефонами, используя графический интерфейс
SELECT * FROM hw_1.mobile_phone;

-- Задание 2. Выведите название, производителя, цену, количество которых превышает 2
SELECT ProductName, Manufacturer, Price
FROM hw_1.mobile_phone
WHERE ProductCount >  2;

-- Задание 3. Выведите весь ассортимент товаров марки самсунг
SELECT * FROM hw_1.mobile_phone
WHERE Manufacturer = 'Samsung';

-- Задание 4. С помощью регулярных выражений найти:
-- 4.1. Товары, в которых есть упоминание Iphone
SELECT * FROM hw_1.mobile_phone
WHERE ProductName LIKE 'Iphone %';

-- 4.2. Samsung. Не понял, чем задание отличается от 3 номера
SELECT * FROM hw_1.mobile_phone
WHERE Manufacturer = 'Samsung';

-- 4.3. Товары, в которых есть цифры. Этот запрос почему-то не работает. 
SELECT * FROM hw_1.mobile_phone
WHERE ProductName LIKE '%[^0-9]%';

-- 4.4. Товары, в которых есть цифра 8
SELECT * FROM hw_1.mobile_phone
WHERE ProductName LIKE '%8%';