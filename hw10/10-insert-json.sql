-- Работа с json
INSERT INTO shop.products (
    product_name,
    category_id,
    description,
    weight,
    unit,
    product_code,
    attributes)
VALUES
('product name 1',
10,
'product description 1',
10.5,
'кг',
10005000,
'{"attr1": "value 1", "attr2": "value 2", "attr3": {"name": "name 1", "value": 2}}'
),
('product name 2',
20,
'product description 2',
33.5,
'коробка',
10105050,
'{"attr1": "value 2", "attr2": "value 22", "attr3": {"name": "name 2", "value": 42}}'
),
('product name 3',
33,
'product description 3',
511.5,
'г',
10606060,
'{"attr1": "value 3", "attr2": "value 3", "attr3": {"name": "name 3", "value": 3}}'
);

INSERT INTO shop.products (
    product_name,
    category_id,
    description,
    weight,
    unit,
    product_code,
    attributes)
VALUES
('product name 4',
44,
'product description 4',
44.4,
'кг',
4000,
JSON_OBJECT(
    "attr1", "value 4",
    "attr2", "value 4",
    "attr3", JSON_OBJECT("name", "name 4", "value", 4))
);
