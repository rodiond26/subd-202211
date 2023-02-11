-- Create tables with primary keys
CREATE TABLE shop.orders (
    order_id         SERIAL       NOT NULL,
    order_date       DATE         NOT NULL,
    status           VARCHAR(16)  NOT NULL,
    cost_for_client  DECIMAL      NOT NULL,
    currency         VARCHAR(8)   NOT NULL,
    manager_id       INTEGER      NOT NULL,
    client_id        INTEGER      NOT NULL,
    description      TEXT         NOT NULL,
    delivery_id      INTEGER      NOT NULL
);
ALTER TABLE ONLY shop.orders
    ADD CONSTRAINT orders_pk PRIMARY KEY (order_id);

CREATE TABLE shop.products (
    product_id    SERIAL   NOT NULL,
    product_name  TEXT     NOT NULL,
    category_id   INTEGER  NOT NULL,
    description   TEXT     NOT NULL,
    weight        REAL,
    unit          INTEGER,
    product_code  INTEGER
);
ALTER TABLE ONLY shop.products
    ADD CONSTRAINT products_pk PRIMARY KEY (product_id);

CREATE TABLE shop.categories (
    category_id  SERIAL   NOT NULL,
    parent_id    INTEGER  NOT NULL,
    description  TEXT     NOT NULL
);
ALTER TABLE ONLY shop.categories
    ADD CONSTRAINT categories_pk PRIMARY KEY (category_id);

CREATE TABLE shop.orders_products (
    id          SERIAL   NOT NULL,
    order_id    INTEGER  NOT NULL,
    product_id  INTEGER  NOT NULL
);
ALTER TABLE ONLY shop.orders_products
    ADD CONSTRAINT orders_products_pk PRIMARY KEY (id);

CREATE TABLE shop.shippers (
    shipper_id    SERIAL        NOT NULL,
    shipper_name  VARCHAR(32)   NOT NULL,
    inn           VARCHAR(32)   NOT NULL,
    address       VARCHAR(128)  NOT NULL,
    phone         VARCHAR(32)   NOT NULL,
    is_active     BOOLEAN       NOT NULL
);
ALTER TABLE ONLY shop.shippers
    ADD CONSTRAINT shippers_pk PRIMARY KEY (shipper_id);

CREATE TABLE shop.supplies (
    supply_id     SERIAL   NOT NULL,
    product_id    INTEGER  NOT NULL,
    product_cost  DECIMAL  NOT NULL
);
ALTER TABLE ONLY shop.supplies
    ADD CONSTRAINT supplies_pk PRIMARY KEY (supply_id);

CREATE TABLE shop.shippers_supplies (
    id          SERIAL   NOT NULL,
    shipper_id  INTEGER  NOT NULL,
    supply_id   INTEGER  NOT NULL
);
ALTER TABLE ONLY shop.shippers_supplies
    ADD CONSTRAINT shippers_supplies_pk PRIMARY KEY (id);

CREATE TABLE shop.managers (
    manager_id    SERIAL        NOT NULL,
    manager_name  TEXT          NOT NULL,
    positions     VARCHAR(128)  NOT NULL,
    contacts      VARCHAR(128)  NOT NULL,
    is_active     BOOLEAN       NOT NULL
);
ALTER TABLE ONLY shop.managers
    ADD CONSTRAINT managers_pk PRIMARY KEY (manager_id);

CREATE TABLE shop.clients (
    client_id    SERIAL        NOT NULL,
    client_name  TEXT          NOT NULL,
    contacts     VARCHAR(128)  NOT NULL,
    is_active    BOOLEAN       NOT NULL
);
ALTER TABLE ONLY shop.clients
    ADD CONSTRAINT clients_pk PRIMARY KEY (client_id);

CREATE TABLE shop.deliveries (
    delivery_id    SERIAL       NOT NULL,
    delivery_date  DATE         NOT NULL,
    weight         REAL         NOT NULL,
    cost           DECIMAL      NOT NULL,
    status         VARCHAR(16)  NOT NULL,
    provider       VARCHAR(32)  NOT NULL
);
ALTER TABLE ONLY shop.deliveries
    ADD CONSTRAINT deliveries_pk PRIMARY KEY (delivery_id);

-- Create foreign keys
ALTER TABLE shop.orders
    ADD CONSTRAINT fk_orders_manager_id FOREIGN KEY (manager_id) REFERENCES shop.managers(manager_id);
ALTER TABLE shop.orders
    ADD CONSTRAINT fk_orders_client_id FOREIGN KEY (client_id) REFERENCES shop.clients(client_id);
ALTER TABLE shop.orders
    ADD CONSTRAINT fk_orders_delivery_id FOREIGN KEY (delivery_id) REFERENCES shop.deliveries(delivery_id);
ALTER TABLE shop.orders_products
    ADD CONSTRAINT fk_orders_products_order_id FOREIGN KEY (order_id) REFERENCES shop.orders(order_id);
ALTER TABLE shop.orders_products
    ADD CONSTRAINT fk_orders_products_product_id FOREIGN KEY (product_id) REFERENCES shop.products(product_id);
ALTER TABLE shop.products
    ADD CONSTRAINT fk_products_category_id FOREIGN KEY (category_id) REFERENCES shop.categories(category_id);
ALTER TABLE shop.supplies
    ADD CONSTRAINT fk_supplies_product_id FOREIGN KEY (product_id) REFERENCES shop.products(product_id);
ALTER TABLE shop.shippers_supplies
    ADD CONSTRAINT fk_shippers_supplies_supply_id FOREIGN KEY (supply_id) REFERENCES shop.supplies(supply_id);
ALTER TABLE shop.shippers_supplies
    ADD CONSTRAINT fk_shippers_supplies_shipper_id FOREIGN KEY (shipper_id) REFERENCES shop.shippers(shipper_id);
