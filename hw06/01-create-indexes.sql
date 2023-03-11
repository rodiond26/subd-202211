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
DROP INDEX IF EXISTS shop.idx_category_id;
DROP INDEX IF EXISTS shop.idx_product_code;
DROP INDEX IF EXISTS shop.idx_product_name_lower;

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
SELECT insert_synthetic_into_product(1000000);
/*
Результат:
Successfully run. Total query runtime: 2 min 46 secs.
1 rows affected.
*/

-- 1. Создать индекс по категории продуктов в таблице с продуктами
CREATE INDEX IF NOT EXISTS idx_category_id
    ON shop.products(category_id);

EXPLAIN (COSTS,
         VERBOSE,
         FORMAT JSON, ANALYZE)
SELECT *
  FROM shop.products AS p
  JOIN shop.categories AS c
    ON p.category_id = c.category_id
 WHERE c.parent_id = 1
   AND c.category_id > 10;

/*
Результат:
[
  {
    "Plan": {
      "Node Type": "Gather",
      "Parallel Aware": false,
      "Async Capable": false,
      "Startup Cost": 1023.18,
      "Total Cost": 22119.20,
      "Plan Rows": 1667,
      "Plan Width": 127,
      "Actual Startup Time": 2.253,
      "Actual Total Time": 138.840,
      "Actual Rows": 208377,
      "Actual Loops": 1,
      "Output": [
        "p.product_id",
        "p.product_name",
        "p.category_id",
        "p.description",
        "p.weight",
        "p.unit",
        "p.product_code",
        "c.category_id",
        "c.parent_id",
        "c.description"
      ],
      "Workers Planned": 2,
      "Workers Launched": 2,
      "Single Copy": false,
      "Plans": [
        {
          "Node Type": "Hash Join",
          "Parent Relationship": "Outer",
          "Parallel Aware": false,
          "Async Capable": false,
          "Join Type": "Inner",
          "Startup Cost": 23.18,
          "Total Cost": 20952.50,
          "Plan Rows": 695,
          "Plan Width": 127,
          "Actual Startup Time": 0.417,
          "Actual Total Time": 75.473,
          "Actual Rows": 69459,
          "Actual Loops": 3,
          "Output": [
            "p.product_id",
            "p.product_name",
            "p.category_id",
            "p.description",
            "p.weight",
            "p.unit",
            "p.product_code",
            "c.category_id",
            "c.parent_id",
            "c.description"
          ],
          "Inner Unique": true,
          "Hash Cond": "(p.category_id = c.category_id)",
          "Workers": [
            {
              "Worker Number": 0,
              "Actual Startup Time": 0.454,
              "Actual Total Time": 61.870,
              "Actual Rows": 58521,
              "Actual Loops": 1
            },
            {
              "Worker Number": 1,
              "Actual Startup Time": 0.417,
              "Actual Total Time": 57.621,
              "Actual Rows": 55916,
              "Actual Loops": 1
            }
          ],
          "Plans": [
            {
              "Node Type": "Seq Scan",
              "Parent Relationship": "Outer",
              "Parallel Aware": true,
              "Async Capable": false,
              "Relation Name": "products",
              "Schema": "shop",
              "Alias": "p",
              "Startup Cost": 0.00,
              "Total Cost": 19831.70,
              "Plan Rows": 416670,
              "Plan Width": 87,
              "Actual Startup Time": 0.218,
              "Actual Total Time": 43.204,
              "Actual Rows": 333336,
              "Actual Loops": 3,
              "Output": [
                "p.product_id",
                "p.product_name",
                "p.category_id",
                "p.description",
                "p.weight",
                "p.unit",
                "p.product_code"
              ],
              "Workers": [
                {
                  "Worker Number": 0,
                  "Actual Startup Time": 0.305,
                  "Actual Total Time": 36.134,
                  "Actual Rows": 281188,
                  "Actual Loops": 1
                },
                {
                  "Worker Number": 1,
                  "Actual Startup Time": 0.300,
                  "Actual Total Time": 33.516,
                  "Actual Rows": 268357,
                  "Actual Loops": 1
                }
              ]
            },
            {
              "Node Type": "Hash",
              "Parent Relationship": "Inner",
              "Parallel Aware": false,
              "Async Capable": false,
              "Startup Cost": 23.15,
              "Total Cost": 23.15,
              "Plan Rows": 2,
              "Plan Width": 40,
              "Actual Startup Time": 0.115,
              "Actual Total Time": 0.115,
              "Actual Rows": 3,
              "Actual Loops": 3,
              "Output": [
                "c.category_id",
                "c.parent_id",
                "c.description"
              ],
              "Hash Buckets": 1024,
              "Original Hash Buckets": 1024,
              "Hash Batches": 1,
              "Original Hash Batches": 1,
              "Peak Memory Usage": 9,
              "Workers": [
                {
                  "Worker Number": 0,
                  "Actual Startup Time": 0.016,
                  "Actual Total Time": 0.017,
                  "Actual Rows": 3,
                  "Actual Loops": 1
                },
                {
                  "Worker Number": 1,
                  "Actual Startup Time": 0.015,
                  "Actual Total Time": 0.015,
                  "Actual Rows": 3,
                  "Actual Loops": 1
                }
              ],
              "Plans": [
                {
                  "Node Type": "Bitmap Heap Scan",
                  "Parent Relationship": "Outer",
                  "Parallel Aware": false,
                  "Async Capable": false,
                  "Relation Name": "categories",
                  "Schema": "shop",
                  "Alias": "c",
                  "Startup Cost": 7.15,
                  "Total Cost": 23.15,
                  "Plan Rows": 2,
                  "Plan Width": 40,
                  "Actual Startup Time": 0.111,
                  "Actual Total Time": 0.112,
                  "Actual Rows": 3,
                  "Actual Loops": 3,
                  "Output": [
                    "c.category_id",
                    "c.parent_id",
                    "c.description"
                  ],
                  "Recheck Cond": "(c.category_id > 10)",
                  "Rows Removed by Index Recheck": 0,
                  "Filter": "(c.parent_id = 1)",
                  "Rows Removed by Filter": 0,
                  "Exact Heap Blocks": 1,
                  "Lossy Heap Blocks": 0,
                  "Workers": [
                    {
                      "Worker Number": 0,
                      "Actual Startup Time": 0.014,
                      "Actual Total Time": 0.015,
                      "Actual Rows": 3,
                      "Actual Loops": 1
                    },
                    {
                      "Worker Number": 1,
                      "Actual Startup Time": 0.013,
                      "Actual Total Time": 0.014,
                      "Actual Rows": 3,
                      "Actual Loops": 1
                    }
                  ],
                  "Plans": [
                    {
                      "Node Type": "Bitmap Index Scan",
                      "Parent Relationship": "Outer",
                      "Parallel Aware": false,
                      "Async Capable": false,
                      "Index Name": "categories_pk",
                      "Startup Cost": 0.00,
                      "Total Cost": 7.15,
                      "Plan Rows": 400,
                      "Plan Width": 0,
                      "Actual Startup Time": 0.106,
                      "Actual Total Time": 0.106,
                      "Actual Rows": 3,
                      "Actual Loops": 3,
                      "Index Cond": "(c.category_id > 10)",
                      "Workers": [
                        {
                          "Worker Number": 0,
                          "Actual Startup Time": 0.009,
                          "Actual Total Time": 0.009,
                          "Actual Rows": 3,
                          "Actual Loops": 1
                        },
                        {
                          "Worker Number": 1,
                          "Actual Startup Time": 0.009,
                          "Actual Total Time": 0.009,
                          "Actual Rows": 3,
                          "Actual Loops": 1
                        }
                      ]
                    }
                  ]
                }
              ]
            }
          ]
        }
      ]
    },
    "Planning Time": 0.148,
    "Triggers": [
    ],
    "Execution Time": 143.255
  }
]
*/

-- 2. Создать индекс для полнотекстового поиска
ALTER TABLE shop.products
  ADD COLUMN product_name_lexeme tsvector;

UPDATE shop.products
SET product_name_lexeme = TO_TSVECTOR(product_name);

CREATE INDEX IF NOT EXISTS idx_product_name_gin
    ON shop.products USING GIN (product_name_lexeme);

SELECT product_name,
       category_id,
       description,
       TO_TSVECTOR(product_name)@@TO_TSQUERY('3593e4')
  FROM shop.products
 WHERE TO_TSVECTOR(product_name)@@TO_TSQUERY('3593e4');
/*
Результат:
"product_name"  "category_id"  "description"  "?column?"
"3593e4be49bb0069d6bd79cf46212537"  2  "f352eb36bccd04d0a34332623449b55f"  true
*/

-- 3. Создать индекс на поле с функцией
CREATE INDEX IF NOT EXISTS idx_product_name_lower
    ON shop.products(lower(product_name));
CREATE INDEX IF NOT EXISTS idx_description_lower
    ON shop.products(lower(description));

-- 4. Создать индекс на несколько полей
CREATE INDEX IF NOT EXISTS idx_product_name_category_id
    ON shop.products(product_name, category_id);
