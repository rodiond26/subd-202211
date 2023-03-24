-- Создать таблицы
USE shop;

CREATE TABLE shop.orders (
    order_id         INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    order_date       DATETIME         NOT NULL,
    status           VARCHAR(16)      NOT NULL,
    cost_for_client  DECIMAL(11, 2)   NOT NULL,
    currency         CHAR(3)          NOT NULL DEFAULT 'RUB',
    manager_id       INTEGER UNSIGNED NOT NULL,
    client_id        INTEGER UNSIGNED NOT NULL,
    description      VARCHAR(255),
    delivery_id      INTEGER UNSIGNED NOT NULL
);

CREATE TABLE shop.products (
    product_id    INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    product_name  VARCHAR(255)     NOT NULL,
    category_id   INTEGER UNSIGNED NOT NULL,
    description   VARCHAR(255),
    weight        REAL(9, 3),
    unit          ENUM('кг', 'уп', 'коробка', 'г', 'пачка', 'мешок', 'шт', 'упаковка', 'бут', '-'),
    product_code  INTEGER UNSIGNED NOT NULL,
    attributes    JSON
);

CREATE TABLE shop.categories (
    category_id  INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    parent_id    INTEGER UNSIGNED NOT NULL,
    description  VARCHAR(255)
);

CREATE TABLE shop.orders_products (
    id          INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    order_id    INTEGER UNSIGNED NOT NULL,
    product_id  INTEGER UNSIGNED NOT NULL
);

CREATE TABLE shop.shippers (
    shipper_id    INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    shipper_name  VARCHAR(255) NOT NULL,
    inn           VARCHAR(16)  NOT NULL,
    address       VARCHAR(128) NOT NULL,
    phone         VARCHAR(32)  NOT NULL,
    is_active     BOOLEAN
);

CREATE TABLE shop.supplies (
    supply_id     INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    product_id    INTEGER UNSIGNED NOT NULL,
    product_cost  DECIMAL(13, 2)   NOT NULL
);

CREATE TABLE shop.shippers_supplies (
    id          INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    shipper_id  INTEGER UNSIGNED NOT NULL,
    supply_id   INTEGER UNSIGNED NOT NULL
);

CREATE TABLE shop.managers (
    manager_id    INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    manager_name  VARCHAR(128) NOT NULL,
    positions     VARCHAR(128) NOT NULL,
    contacts      VARCHAR(128) NOT NULL,
    is_active     BOOLEAN
);

CREATE TABLE shop.clients (
    client_id    INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    client_name  VARCHAR(128) NOT NULL,
    contacts     VARCHAR(128) NOT NULL,
    last_order   DATETIME,
    is_active    BOOLEAN
);

CREATE TABLE shop.deliveries (
    delivery_id    INTEGER UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    delivery_date  DATETIME       NOT NULL,
    weight         REAL(9, 3)     NOT NULL,
    cost           DECIMAL(11, 2) NOT NULL,
    status         VARCHAR(16)    NOT NULL,
    provider       VARCHAR(32)    NOT NULL
);
