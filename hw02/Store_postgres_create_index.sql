CREATE INDEX idx_manager_id ON managers(manager_id);
CREATE INDEX idx_manager_name_lower ON managers(LOWER(manager_name));

CREATE INDEX idx_client_id ON clients(client_id);
CREATE INDEX idx_client_name_lower ON clients(LOWER(client_name));

CREATE INDEX idx_delivery_id ON deliveries(delivery_id);
CREATE INDEX idx_delivery_date ON deliveries(delivery_date);

CREATE INDEX idx_orders_products_id ON orders_products(id);
CREATE INDEX idx_orders_products_order_id ON orders_products(order_id);
CREATE INDEX idx_orders_products_product_id ON orders_products(product_id);

