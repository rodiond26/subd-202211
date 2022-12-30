CREATE INDEX idx_order_date ON orders(order_date);
CREATE INDEX idx_client_id ON orders(client_id);
CREATE INDEX idx_manager_id ON orders(manager_id);

CREATE INDEX idx_category_id ON products(category_id);
CREATE INDEX idx_product_code ON products(product_code);
CREATE INDEX idx_product_name_lower ON products(LOWER(product_name));

-- shippers
CREATE INDEX idx_orders_products_order_id ON orders_products(order_id);
CREATE INDEX idx_orders_products_product_id ON orders_products(product_id);

CREATE INDEX idx_manager_name_lower ON managers(LOWER(manager_name));
CREATE INDEX idx_client_name_lower ON clients(LOWER(client_name));

CREATE INDEX idx_delivery_date ON deliveries(delivery_date);



