-- Drop foreign keys
ALTER TABLE orders
    DROP CONSTRAINT IF EXISTS fk_orders_manager_id;
ALTER TABLE orders
    DROP CONSTRAINT IF EXISTS fk_orders_client_id;
ALTER TABLE orders
    DROP CONSTRAINT IF EXISTS fk_orders_delivery_id;
ALTER TABLE orders_products
    DROP CONSTRAINT IF EXISTS fk_orders_products_order_id;
ALTER TABLE orders_products
    DROP CONSTRAINT IF EXISTS fk_orders_products_product_id;
ALTER TABLE products
    DROP CONSTRAINT IF EXISTS fk_products_category_id;
ALTER TABLE supplies
    DROP CONSTRAINT IF EXISTS fk_supplies_product_id;
ALTER TABLE shippers_supplies
    DROP CONSTRAINT IF EXISTS fk_shippers_supplies_supply_id;
ALTER TABLE shippers_supplies
    DROP CONSTRAINT IF EXISTS fk_shippers_supplies_shipper_id;

-- Drop primary keys
ALTER TABLE orders
    DROP CONSTRAINT IF EXISTS orders_pk;
ALTER TABLE products
    DROP CONSTRAINT IF EXISTS products_pk;
ALTER TABLE categories
    DROP CONSTRAINT IF EXISTS categories_pk;
ALTER TABLE orders_products
    DROP CONSTRAINT IF EXISTS orders_products_pk;
ALTER TABLE shippers
    DROP CONSTRAINT IF EXISTS shippers_pk;
ALTER TABLE supplies
    DROP CONSTRAINT IF EXISTS supplies_pk;
ALTER TABLE shippers_supplies
    DROP CONSTRAINT IF EXISTS shippers_supplies_pk;
ALTER TABLE managers
    DROP CONSTRAINT IF EXISTS managers_pk;
ALTER TABLE clients
    DROP CONSTRAINT IF EXISTS clients_pk;
ALTER TABLE deliveries
    DROP CONSTRAINT IF EXISTS deliveries_pk;

-- Drop tables
DROP TABLE IF EXISTS orders;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS categories;
DROP TABLE IF EXISTS orders_products;
DROP TABLE IF EXISTS shippers;
DROP TABLE IF EXISTS supplies;
DROP TABLE IF EXISTS shippers_supplies;
DROP TABLE IF EXISTS managers;
DROP TABLE IF EXISTS clients;
DROP TABLE IF EXISTS deliveries;
