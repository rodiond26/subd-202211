-- Домашнее задание 6
-- Добавить категории продуктов
INSERT INTO shop.categories
       (parent_id, description)
VALUES
(1, 'Рыба'),
(1, 'Орехи'),
(1, 'Орехи'),
(1, 'Крупы'),
(1, 'Соль'),
(1, 'Сахар'),
(1, 'Приправа');

-- Перечень категорий
SELECT category_id, parent_id, description
  FROM shop.categories;
/*
Результат:
"category_id" "parent_id" "description"
1  0  "Базовая категория товара"
2  1  "Овощи"
3  1  "Фрукты"
4  1  "Ягоды"
5  1  "Грибы"
6  1  "Мясо"
7  1  "Рыба"
8  1  "Орехи"
9  1  "Орехи"
10  1  "Крупы"
11  1  "Соль"
12  1  "Сахар"
13  1  "Приправа"
*/

-- Удалить существующие индексы
DROP INDEX IF EXISTS idx_category_id;
DROP INDEX IF EXISTS idx_product_code;
DROP INDEX IF EXISTS idx_product_name_lower;

-- Создать функцию для создания синтетики
CREATE OR REPLACE FUNCTION create_synthetic_product()
       RETURNS TABLE (product_name  TEXT,
                      category_id   INTEGER,
                      description   TEXT,
                      weight        REAL,
                      unit          CHARACTER VARYING(10),
                      product_code  INTEGER) AS $$
BEGIN
    RETURN QUERY

WITH
product_name AS (
    SELECT md5(random()::text) AS name
),
category_id AS (
    SELECT ((random()*12)::INT + 1)
),
description AS (
    SELECT md5(random()::text) AS descr
),
weight AS (
    SELECT (random()*1000)::REAL AS w
),
unit AS (
    SELECT *
      FROM (SELECT *
              FROM unnest(
                          '{"кг",
                          "уп",
                          "коробка",
                          "г",
                          "пачка",
                          "мешок",
                          "шт",
                          "упаковка",
                          "бут",
                          "-"}'::VARCHAR(5)[]
                   ) AS u
           ) AS unit
     ORDER BY random()
     LIMIT 1
),
product_code AS (
    SELECT ((random()*1000000)::INT + 1000000) AS code
)
SELECT (SELECT name   FROM product_name)  AS product_name,
       (SELECT *      FROM category_id)   AS category_id,
       (SELECT descr  FROM description)   AS description,
       (SELECT w      FROM weight)        AS weight,
       (SELECT u      FROM unit)          AS unit,
	   (SELECT code   FROM product_code)  AS code;

END;
$$LANGUAGE PLPGSQL;

-- Создать функцию для вставки синтетики
CREATE OR REPLACE FUNCTION insert_synthetic_into_product(n integer)
       RETURNS VOID AS $$
BEGIN
    FOR i IN 1..n LOOP
	    INSERT INTO shop.products(product_name,
                                  category_id,
                                  description,
                                  weight,
                                  unit,
                                  product_code)
        SELECT product_name,
               category_id,
               description,
               weight,
               unit,
               product_code
          FROM create_synthetic_product();
	END LOOP;
END;
$$LANGUAGE PLPGSQL;

-- Вставить синтетику в таблицу
select insert_synthetic_into_product(1000000);
/*
Результат:
Successfully run. Total query runtime: 2 min 46 secs.
1 rows affected.
*/

/*
Домашнее задание
Индексы PostgreSQL

Цель:
Знать и уметь применять основные виды индексов PostgreSQL
Построить и анализировать план выполнения запроса
Уметь оптимизировать запросы для с использованием индексов


Описание/Пошаговая инструкция выполнения домашнего задания:
Создать индексы на БД, которые ускорят доступ к данным.
В данном задании тренируются навыки:

определения узких мест
написания запросов для создания индекса
оптимизации
Необходимо:
Создать индекс к какой-либо из таблиц вашей БД
Прислать текстом результат команды explain,
в которой используется данный индекс
Реализовать индекс для полнотекстового поиска
Реализовать индекс на часть таблицы или индекс
на поле с функцией
Создать индекс на несколько полей
Написать комментарии к каждому из индексов
Описать что и как делали и с какими проблемами
столкнулись
*/

/*
Домашнее задание
1. Создать индекс к какой-либо из таблиц вашей БД
2. Прислать текстом результат команды explain, в которой используется данный
индекс
3. Реализовать индекс для полнотекстового поиска
4. Реализовать индекс на часть таблицы или индекс на поле с функцией
5. Создать индекс на несколько полей
6. Написать комментарии к каждому из индексов
7. Описать что и как делали и с какими проблемами столкнулись
*/