-- Drop indexes
DROP INDEX IF EXISTS idx_order_date;
DROP INDEX IF EXISTS idx_client_id;
DROP INDEX IF EXISTS idx_manager_id;

DROP INDEX IF EXISTS idx_category_id;
DROP INDEX IF EXISTS idx_product_code;
DROP INDEX IF EXISTS idx_product_name_lower;

DROP INDEX IF EXISTS idx_shippers_name_inn;
DROP INDEX IF EXISTS idx_supplies_product_id;
DROP INDEX IF EXISTS idx_supplies_supply_id_product_id;

DROP INDEX IF EXISTS idx_shippers_supplies_shipper_id;
DROP INDEX IF EXISTS idx_shippers_supplies_supply_id;

DROP INDEX IF EXISTS idx_managers_name;
DROP INDEX IF EXISTS idx_clients_name;
