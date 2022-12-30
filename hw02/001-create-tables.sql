CREATE TABLE orders (
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
ALTER TABLE ONLY orders
    ADD CONSTRAINT orders_pk PRIMARY KEY (order_id);

CREATE TABLE products (
    product_id    SERIAL   NOT NULL,
    product_name  INTEGER  NOT NULL,
    category_id   INTEGER  NOT NULL,
    description   TEXT     NOT NULL,
    weight        REAL,
    unit          INTEGER,
    product_code  INTEGER
);
ALTER TABLE ONLY products
    ADD CONSTRAINT products_pk PRIMARY KEY (product_id);

CREATE TABLE categories (
    category_id  SERIAL   NOT NULL,
    parent_id    INTEGER  NOT NULL,
    description  TEXT     NOT NULL
);
ALTER TABLE ONLY categories
    ADD CONSTRAINT categories_pk PRIMARY KEY (category_id);

CREATE TABLE orders_products (
    id          SERIAL   NOT NULL,
    order_id    INTEGER  NOT NULL,
    product_id  INTEGER  NOT NULL
);
ALTER TABLE ONLY orders_products
    ADD CONSTRAINT orders_products_pk PRIMARY KEY (id);

CREATE TABLE shippers (
    shipper_id    SERIAL        NOT NULL,
    shipper_name  VARCHAR(32)   NOT NULL,
    inn           VARCHAR(32)   NOT NULL,
    address       VARCHAR(128)  NOT NULL,
    phone         VARCHAR(32)   NOT NULL,
    is_active     BOOLEAN       NOT NULL
);
ALTER TABLE ONLY shippers
    ADD CONSTRAINT shippers_pk PRIMARY KEY (shipper_id);

CREATE TABLE supplies (
    supply_id     SERIAL   NOT NULL,
    product_id    INTEGER  NOT NULL,
    product_cost  DECIMAL  NOT NULL
);
ALTER TABLE ONLY supplies
    ADD CONSTRAINT supplies_pk PRIMARY KEY (supply_id);

CREATE TABLE shippers_supplies (
    id          SERIAL   NOT NULL,
    shipper_id  INTEGER  NOT NULL,
    supply_id   INTEGER  NOT NULL
);
ALTER TABLE ONLY shippers_supplies
    ADD CONSTRAINT shippers_supplies_pk PRIMARY KEY (id);

CREATE TABLE managers (
    manager_id    SERIAL        NOT NULL,
    manager_name  TEXT          NOT NULL,
    positions     VARCHAR(128)  NOT NULL,
    contacts      VARCHAR(128)  NOT NULL,
    is_active     BOOLEAN       NOT NULL
);
ALTER TABLE ONLY managers
    ADD CONSTRAINT managers_pk PRIMARY KEY (manager_id);

CREATE TABLE clients (
    client_id    SERIAL        NOT NULL,
    client_name  TEXT          NOT NULL,
    contacts     VARCHAR(128)  NOT NULL,
    is_active    BOOLEAN       NOT NULL
);
ALTER TABLE ONLY managers
    ADD CONSTRAINT managers_pk PRIMARY KEY (manager_id);

CREATE TABLE deliveries (
    delivery_id    SERIAL       NOT NULL,
    delivery_date  DATE         NOT NULL,
    weight         REAL         NOT NULL,
    cost           DECIMAL      NOT NULL,
    status         VARCHAR(16)  NOT NULL,
    provider       VARCHAR(32)  NOT NULL
);
ALTER TABLE ONLY deliveries
    ADD CONSTRAINT deliveries_pk PRIMARY KEY (delivery_id);

ALTER TABLE orders
    ADD CONSTRAINT orders_fk0 FOREIGN KEY (order_id) REFERENCES orders_products(order_id);
ALTER TABLE products
    ADD CONSTRAINT products_fk0 FOREIGN KEY (product_id) REFERENCES orders_products(product_id);
ALTER TABLE categories
    ADD CONSTRAINT categories_fk0 FOREIGN KEY (category_id) REFERENCES products(category_id);
ALTER TABLE shippers
    ADD CONSTRAINT shippers_fk0 FOREIGN KEY (shipper_id) REFERENCES shippers_supplies(shipper_id);
ALTER TABLE supplies
    ADD CONSTRAINT supplies_fk0 FOREIGN KEY (product_id) REFERENCES products(product_id);
ALTER TABLE shippers_supplies
    ADD CONSTRAINT shippers_supplies_fk0 FOREIGN KEY (shipper_id) REFERENCES deliveries(shipper_id);
ALTER TABLE shippers_supplies
    ADD CONSTRAINT shippers_supplies_fk1 FOREIGN KEY (supply_id) REFERENCES supplies(supply_id);
ALTER TABLE managers
    ADD CONSTRAINT managers_fk0 FOREIGN KEY (manager_id) REFERENCES orders(manager_id);
ALTER TABLE clients
    ADD CONSTRAINT clients_fk0 FOREIGN KEY (client_id) REFERENCES orders(client_id);
ALTER TABLE deliveries
    ADD CONSTRAINT deliveries_fk0 FOREIGN KEY (delivery_id) REFERENCES orders(delivery_id);
