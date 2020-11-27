use lab4;

create table if not exists categories(
    id          INT UNSIGNED AUTO_INCREMENT,
    slug        VARCHAR(64) NOT NULL UNIQUE,
    name        VARCHAR(128) NOT NULL,
    sort_order  INT DEFAULT 0,
    created_at  TIMESTAMP DEFAULT NOW(),
    PRIMARY KEY (id)
);

create table if not exists products(
    id          INT UNSIGNED AUTO_INCREMENT,
    sku         VARCHAR(6) NOT NULL UNIQUE,
    name        VARCHAR(255) NOT NULL,
    description VARCHAR(1024) NOT NULL,
    brand       VARCHAR(255) NOT NULL,
    category_id INT UNSIGNED,
    price       DOUBLE NOT NULL,
    sale_price  DOUBLE DEFAULT NULL,
    in_stock    BOOLEAN DEFAULT TRUE,
    featured    BOOLEAN DEFAULT FALSE,
    views       INT DEFAULT 0,
    created_at  TIMESTAMP DEFAULT NOW(),
    PRIMARY KEY (id),
    FOREIGN KEY (category_id) REFERENCES categories(id)
);

create table if not exists orders(
    id          INT UNSIGNED AUTO_INCREMENT,
    fullname    VARCHAR(128) NOT NULL,
    phone       VARCHAR(13) NOT NULL,
    subtotal    DOUBLE NOT NULL,
    delivery    DOUBLE NOT NULL,
    total       DOUBLE NOT NULL,
    status      VARCHAR(32) DEFAULT 'active',
    created_at  TIMESTAMP DEFAULT NOW(),
    PRIMARY KEY (id)
);


CREATE TABLE if not exists order_products (
    order_id INT UNSIGNED NOT NULL,
    product_id INT UNSIGNED NOT NULL,
    quantity INT NOT NULL,
    PRIMARY KEY (order_id, product_id),
    FOREIGN KEY (order_id) REFERENCES orders (id),
    FOREIGN KEY (product_id) REFERENCES products (id)
);



INSERT INTO categories (slug, name) VALUES ('pc', 'Calculatoare');
INSERT INTO categories (slug, name) VALUES ('laptops', 'Laptopuri');
INSERT INTO categories (slug, name) VALUES ('servers', 'Servere');
DELETE FROM categories WHERE slug='servers';
SELECT * from categories;

INSERT INTO products (sku, name, description, brand, category_id, price)
VALUES ('ll5', 'Lenovo Legion 5', 'Nice laptop', 'Lenovo', 2, 27000);
INSERT INTO products (sku, name, description, brand, category_id, price)
VALUES ('asd2', 'Asus Zen 10', 'Business laptop', 'Asus', 2, 24000);
INSERT INTO products (sku, name, description, brand, category_id, price)
VALUES ('axm50', 'Asus XM50', 'Accessible laptop', 'Asus', 2, 10000);
SELECT * FROM products WHERE brand='ASUS';
SELECT * FROM products WHERE category_id=2 AND price < 15000;
DELETE FROM products WHERE price BETWEEN 20000 AND 25000;

INSERT INTO orders (fullname, phone, subtotal, delivery, total)
VALUES ('Denis', '+37379754XXX', 10000, 0, 10000);
INSERT INTO order_products (order_id, product_id, quantity) VALUES (1, 3, 1);
INSERT INTO orders (fullname, phone, subtotal, delivery, total)
VALUES ('Denis', '+37379754XXX', 27000, 0, 27000);
INSERT INTO order_products (order_id, product_id, quantity) VALUES (2, 1, 1);
UPDATE orders SET status='completed' WHERE id='1';
SELECT * from orders;

SELECT *
FROM products
INNER JOIN categories
ON products.category_id = categories.id;

SELECT *
FROM order_products
INNER JOIN orders
ON order_products.order_id = orders.id
INNER JOIN products
ON order_products.product_id = products.id;

SELECT *
FROM products
LEFT JOIN categories
ON products.category_id = categories.id;

SELECT *
FROM order_products
LEFT JOIN orders
ON order_products.order_id = orders.id
LEFT JOIN products
ON order_products.product_id = products.id;

SELECT *
FROM products
RIGHT JOIN categories
ON products.category_id = categories.id;

SELECT *
FROM order_products
RIGHT JOIN orders
ON order_products.order_id = orders.id
RIGHT JOIN products
ON order_products.product_id = products.id;

SELECT *
FROM products
LEFT JOIN categories
ON products.category_id = categories.id
UNION
SELECT *
FROM products
RIGHT JOIN categories
ON products.category_id = categories.id
UNION
SELECT *
FROM products
INNER JOIN categories
ON products.category_id = categories.id;


SELECT *
FROM order_products
RIGHT JOIN orders
ON order_products.order_id = orders.id
RIGHT JOIN products
ON order_products.product_id = products.id
UNION
SELECT *
FROM order_products
LEFT JOIN orders
ON order_products.order_id = orders.id
LEFT JOIN products
ON order_products.product_id = products.id
UNION
SELECT *
FROM order_products
INNER JOIN orders
ON order_products.order_id = orders.id
INNER JOIN products
ON order_products.product_id = products.id;



