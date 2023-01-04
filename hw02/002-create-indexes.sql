CREATE INDEX idx_order_date ON orders(order_date);
CREATE INDEX idx_client_id ON orders(client_id);
CREATE INDEX idx_manager_id ON orders(manager_id);

CREATE INDEX idx_category_id ON products(category_id);
CREATE INDEX idx_product_code ON products(product_code);
CREATE INDEX idx_product_name_lower ON products(lower(product_name));

CREATE INDEX idx_shippers_name_inn ON shippers(shipper_name, inn);

CREATE INDEX idx_supplies_product_id ON supplies(product_id);
CREATE INDEX idx_supplies_supply_id_product_id ON supplies(supply_id, product_id);

CREATE INDEX idx_shippers_supplies_shipper_id ON shippers_supplies(shipper_id);
CREATE INDEX idx_shippers_supplies_supply_id ON shippers_supplies(supply_id);

CREATE INDEX idx_managers_name ON managers(manager_name);

CREATE INDEX idx_clients_name ON clients(client_name);
