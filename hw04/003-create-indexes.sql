CREATE INDEX idx_order_date ON shop.orders(order_date);
CREATE INDEX idx_client_id ON shop.orders(client_id);
CREATE INDEX idx_manager_id ON shop.orders(manager_id);

CREATE INDEX idx_category_id ON shop.products(category_id);
CREATE INDEX idx_product_code ON shop.products(product_code);
CREATE INDEX idx_product_name_lower ON shop.products(lower(product_name));

CREATE INDEX idx_shippers_name_inn ON shop.shippers(shipper_name, inn);

CREATE INDEX idx_supplies_product_id ON shop.supplies(product_id);
CREATE INDEX idx_supplies_supply_id_product_id ON shop.supplies(supply_id, product_id);

CREATE INDEX idx_shippers_supplies_shipper_id ON shop.shippers_supplies(shipper_id);
CREATE INDEX idx_shippers_supplies_supply_id ON shop.shippers_supplies(supply_id);

CREATE INDEX idx_managers_name ON shop.managers(manager_name);

CREATE INDEX idx_clients_name ON shop.clients(client_name);
