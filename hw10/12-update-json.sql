-- Работа с json
UPDATE shop.products p
   SET p.attributes = JSON_SET(p.attributes,
	   '$.attr2' , 'value 100')
 WHERE p.category_id > 30;
