-- Домашнее задание 5
-- Добавить категории продуктов
INSERT INTO shop.categories
       (parent_id, description)
VALUES
(0, 'Базовая категория товара'),
(1, 'Овощи'),
(1, 'Фрукты'),
(1, 'Ягоды'),
(1, 'Грибы')
(1, 'Мясо');

/*
Результат:
"category_id" "parent_id" "description"
1  0  "Базовая категория товара"
2  1  "Овощи"
3  1  "Фрукты"
4  1  "Ягоды"
5  1  "Грибы"
6  1  "Мясо"
*/

-- Добавить товары
INSERT INTO shop.products
       (product_name, category_id, description, weight, unit, product_code)
VALUES
('Картофель', 1, 'Свежий картофель', 1.5, 'кг', 1010001),
('Лук', 1, 'Свежий лук', 1.0, 'кг', 1010002),
('Репа', 1, 'Свежая репа', 5.0, 'кг', 1010003),
('Яблоки', 2, 'Красное яблоко', 1.0, 'кг', 1020001),
('Вишня', 2, 'Замороженная вишня', 1.0, 'уп', 1020002),
('Банан', 2, 'Желтый банан', 1.0, 'коробка', 1020003),
('Малина', 3, 'Малина', 1.0, 'кг', 1030001),
('Опята', 4, 'Опята', 1.0, 'кг', 1040001);
/*
Результат:
"product_id" "product_name" "category_id" "description" "weight" "unit" "product_code"
1  "Картофель"  1  "Свежий картофель"    1.5  "кг"       1010001
2  "Лук"        1  "Свежий лук"          1    "кг"       1010002
3  "Репа"       1  "Свежая репа"         5    "кг"       1010003
4  "Яблоки"     2  "Красное яблоко"      1    "кг"       1020001
5  "Вишня"      2  "Замороженная вишня"  1    "уп"       1020002
6  "Банан"      2  "Желтый банан"        1    "коробка"  1020003
7  "Малина"     3  "Малина"              1    "кг"       1030001
8  "Опята"      4  "Опята"               1    "кг"       1040001
*/

-- 1. Напишите запрос по своей базе с регулярным выражением, добавьте пояснение, что вы хотите найти.
-- Поиск товаров с описанием, начинающимся на 'С'
SELECT product_id,
       product_name,
       category_id,
       description,
       weight,
       unit,
       product_code
  FROM shop.products
 WHERE description ~ '^С';
/*
Результат:
"product_id" "product_name" "category_id" "description" "weight" "unit" "product_code"
1  "Картофель"  1  "Свежий картофель"    1.5  "кг"       1010001
2  "Лук"        1  "Свежий лук"          1    "кг"       1010002
3  "Репа"       1  "Свежая репа"         5    "кг"       1010003
*/

-- 2. Напишите запрос по своей базе с использованием LEFT JOIN и INNER JOIN, как
-- порядок соединений в FROM влияет на результат? Почему?
SELECT c.category_id,
       c.parent_id,
       c.description,
       p.product_id,
       p.product_name,
       p.description,
       p.weight,
       p.unit
  FROM shop.categories c
  LEFT JOIN shop.products p
    ON c.category_id = p.category_id
 ORDER BY c.category_id, c.parent_id;
/*
Результат (LEFT JOIN) - к таблице с категориями, которая левее, присоединяется таблица с товарами, которая правее:
"category_id"  "parent_id"  "description"  "product_id"  "product_name"  "description-2"  "weight"  "unit"
1  0  "Базовая категория товара"  2     "Лук"        "Свежий лук"          1     "кг"
1  0  "Базовая категория товара"  3     "Репа"       "Свежая репа"         5     "кг"
1  0  "Базовая категория товара"  1     "Картофель"  "Свежий картофель"    1.5   "кг"
2  1  "Овощи"                     6     "Банан"      "Желтый банан"        1     "коробка"
2  1  "Овощи"                     4     "Яблоки"     "Красное яблоко"      1     "кг"
2  1  "Овощи"                     5     "Вишня"      "Замороженная вишня"  1     "уп"
3  1  "Фрукты"                    7     "Малина"     "Малина"              1     "кг"
4  1  "Ягоды"                     8     "Опята"      "Опята"               1     "кг"
5  1  "Грибы"                     null  null         null                  null  null
6  1  "Мясо"                      null  null         null                  null  null
*/
SELECT c.category_id,
       c.parent_id,
       c.description,
       p.product_id,
       p.product_name,
       p.description,
       p.weight,
       p.unit
  FROM shop.categories c
 INNER JOIN shop.products p
    ON c.category_id = p.category_id
 ORDER BY c.category_id, c.parent_id;
 /*
Результат (INNER JOIN):
"category_id"  "parent_id"  "description"  "product_id"  "product_name"  "description-2"  "weight"  "unit"
1  0  "Базовая категория товара"  1  "Картофель"  "Свежий картофель"    1.5  "кг"
1  0  "Базовая категория товара"  2  "Лук"        "Свежий лук"          1    "кг"
1  0  "Базовая категория товара"  3  "Репа"       "Свежая репа"         5    "кг"
2  1  "Овощи"                     4  "Яблоки"     "Красное яблоко"      1    "кг"
2  1  "Овощи"                     5  "Вишня"      "Замороженная вишня"  1    "уп"
2  1  "Овощи"                     6  "Банан"      "Желтый банан"        1    "коробка"
3  1  "Фрукты"                    7  "Малина"     "Малина"              1    "кг"
4  1  "Ягоды"                     8  "Опята"      "Опята"               1    "кг"
*/

-- 3. Напишите запрос на добавление данных с выводом информации о добавленных
-- строках.
INSERT INTO shop.products
       (product_name, category_id, description, weight, unit, product_code)
VALUES
('Мясо курицы', 6, 'Филе куры', 250, 'г', 1060001),
('Мясо свиньи', 6, 'Свиная шея', 400, 'г', 1060002);
/*
Вывод:
"product_id"  "product_name"  "category_id"
9   "Мясо курицы"  6
10  "Мясо свиньи"  6
*/

-- 4. Напишите запрос с обновлением данные используя UPDATE FROM.
UPDATE shop.products p
   SET category_id = 5
  FROM shop.categories c
 WHERE c.description LIKE ('Я%')
   AND p.category_id = c.category_id
   AND p.product_name IN ('Опята');

-- 5. Напишите запрос для удаления данных с оператором DELETE используя join с
-- другой таблицей с помощью using.
DELETE
  FROM shop.products p
 USING shop.categories c
 WHERE p.category_id = c.category_id
   AND c.category_id in (1,2)
   AND p.weight > 2
   AND p.unit in('кг')
RETURNING product_id, product_name;
/*
Вывод:
"product_id"  "product_name"
3  "Репа"
*/

-- 6.* Приведите пример использования утилиты COPY (по желанию)
  COPY shop.products
    TO 'E:\\scripts\\products.csv' -- for windows
  WITH DELIMITER '|'
       CSV HEADER
       ENCODING 'UTF8';

  COPY shop.categories
    TO 'E:\\scripts\\categories.csv' -- for windows
  WITH DELIMITER '|'
       CSV HEADER
       ENCODING 'UTF8';
