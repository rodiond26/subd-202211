-- Работа с json
SELECT *
  FROM shop.products p
 WHERE p.category_id in (33, 44)
   AND JSON_EXTRACT(p.attributes , '$.attr3.value') BETWEEN 3 AND 5;
