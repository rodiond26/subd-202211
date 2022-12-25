CREATE TABLE IF NOT EXISTS products(
    product_id   INTEGER      NOT NULL,
    product_name VARCHAR(128) NOT NULL
);

INSERT INTO products (product_id, product_name)
VALUES (1, 'Milk'),
       (2, 'Bread'),
       (3, 'Orange');
