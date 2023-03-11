-- Удалить индексы
DROP INDEX IF EXISTS shop.idx_category_id;
DROP INDEX IF EXISTS shop.idx_product_name_gin;
DROP INDEX IF EXISTS shop.idx_product_name_lower;
DROP INDEX IF EXISTS shop.idx_description_lower;
DROP INDEX IF EXISTS shop.idx_product_name_category_id;
