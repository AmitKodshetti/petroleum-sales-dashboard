CREATE DATABASE petroleum_dashboard;
USE petroleum_dashboard;
CREATE TABLE dealers (
    dealer_id INT PRIMARY KEY AUTO_INCREMENT,
    dealer_name VARCHAR(100),
    city VARCHAR(50),
    region VARCHAR(50),
    join_date DATE
);
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(50),
    category VARCHAR(50),
    price_per_unit DECIMAL(10,2)
);
SHOW TABLES;
DROP TABLE IF EXISTS products;
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(50),
    category VARCHAR(50),
    price_per_unit DECIMAL(10,2)
);
CREATE TABLE routes (
    route_id INT PRIMARY KEY AUTO_INCREMENT,
    route_name VARCHAR(100),
    distance_km DECIMAL(10,2),
    region VARCHAR(50)
);
CREATE TABLE invoices (
    invoice_id INT PRIMARY KEY AUTO_INCREMENT,
    dealer_id INT,
    product_id INT,
    route_id INT,
    invoice_date DATE,
    quantity DECIMAL(10,2),
    revenue DECIMAL(12,2),
    delivery_time INT,
    promised_time INT,

    FOREIGN KEY (dealer_id) REFERENCES dealers(dealer_id),
    FOREIGN KEY (product_id) REFERENCES products(product_id),
    FOREIGN KEY (route_id) REFERENCES routes(route_id)
);
CREATE TABLE targets (
    target_id INT PRIMARY KEY AUTO_INCREMENT,
    dealer_id INT,
    month DATE,
    target_revenue DECIMAL(12,2),

    FOREIGN KEY (dealer_id) REFERENCES dealers(dealer_id)
);
INSERT INTO dealers (dealer_name, city, region, join_date) VALUES
('ABC Fuels', 'Nagpur', 'West', '2023-01-15'),
('Sharma Petroleum', 'Pune', 'West', '2023-02-10'),
('Metro Fuel Hub', 'Mumbai', 'West', '2023-03-05'),
('Sai Service Station', 'Hyderabad', 'South', '2023-01-20'),
('Elite Petro', 'Bangalore', 'South', '2023-04-12');
SELECT * FROM dealers;
INSERT INTO products (product_name, category, price_per_unit) VALUES
('Petrol', 'Fuel', 105.50),
('Diesel', 'Fuel', 92.30),
('Premium Petrol', 'Fuel', 112.75),
('Engine Oil', 'Lubricant', 450.00),
('Grease', 'Lubricant', 320.00);
SELECT * FROM products;
INSERT INTO routes (route_name, distance_km, region) VALUES
('Nagpur North', 25.50, 'West'),
('Nagpur South', 18.20, 'West'),
('Pune Central', 12.75, 'West'),
('Hyderabad Outer', 30.40, 'South'),
('Bangalore East', 22.90, 'South');
SELECT * FROM routes;
INSERT INTO invoices 
(dealer_id, product_id, route_id, invoice_date, quantity, revenue, delivery_time, promised_time)
VALUES
(1, 1, 1, '2026-01-05', 500, 52750, 4, 5),
(2, 2, 3, '2026-01-06', 700, 64610, 6, 5),
(3, 1, 2, '2026-01-07', 400, 42200, 3, 5),
(4, 3, 4, '2026-01-08', 350, 39462.5, 7, 6),
(5, 4, 5, '2026-01-09', 100, 45000, 2, 3);
SELECT * FROM invoices;
INSERT INTO targets (dealer_id, month, target_revenue) VALUES
(1, '2026-01-01', 60000),
(2, '2026-01-01', 70000),
(3, '2026-01-01', 50000),
(4, '2026-01-01', 45000),
(5, '2026-01-01', 55000);
select * from targets;
SELECT 
    d.dealer_name,
    SUM(i.revenue) AS total_revenue
FROM invoices i
JOIN dealers d 
    ON i.dealer_id = d.dealer_id
GROUP BY d.dealer_name;
select
p.product_name,
sum(i.quantity) as total_Quantity_Sold
from Invoices i
join products p
on i.product_id = p.product_id
group by p.product_name;
SELECT 
    COUNT(*) AS total_invoices,
    SUM(
        CASE 
            WHEN delivery_time > promised_time THEN 1
            ELSE 0
        END
    ) AS breached_invoices,
    
    ROUND(
        SUM(
            CASE 
                WHEN delivery_time > promised_time THEN 1
                ELSE 0
            END
        ) * 100.0 / COUNT(*),
        2
    ) AS breach_percentage
FROM invoices;
SELECT 
    d.dealer_name,
    t.target_revenue,
    SUM(i.revenue) AS actual_revenue,
    
    ROUND(
        SUM(i.revenue) * 100.0 / t.target_revenue,
        2
    ) AS achievement_percentage

FROM dealers d
JOIN targets t 
    ON d.dealer_id = t.dealer_id
JOIN invoices i 
    ON d.dealer_id = i.dealer_id

GROUP BY 
    d.dealer_name,
    t.target_revenue;
    INSERT INTO dealers (dealer_name, city, region, join_date) VALUES
('Nagpur Fuel Hub', 'Nagpur', 'West', '2023-05-01'),
('Pune Energy Point', 'Pune', 'West', '2023-05-03'),
('Mumbai Petroleum', 'Mumbai', 'West', '2023-05-04'),
('Nashik Fuel Station', 'Nashik', 'West', '2023-05-06'),
('Surat Diesel Point', 'Surat', 'West', '2023-05-08'),
('Indore Fuel Hub', 'Indore', 'Central', '2023-05-10'),
('Bhopal Petro', 'Bhopal', 'Central', '2023-05-12'),
('Raipur Energy', 'Raipur', 'Central', '2023-05-14'),
('Hyderabad Prime Fuel', 'Hyderabad', 'South', '2023-05-16'),
('Vizag Fuel Hub', 'Vizag', 'South', '2023-05-18'),
('Chennai Diesel Depot', 'Chennai', 'South', '2023-05-20'),
('Bangalore Fuel Point', 'Bangalore', 'South', '2023-05-22'),
('Delhi Petroleum', 'Delhi', 'North', '2023-05-24'),
('Noida Fuel Station', 'Noida', 'North', '2023-05-26'),
('Lucknow Energy Hub', 'Lucknow', 'North', '2023-05-28'),
('Jaipur Fuel Point', 'Jaipur', 'North', '2023-05-30'),
('Kolkata Petroleum', 'Kolkata', 'East', '2023-06-01'),
('Patna Fuel Hub', 'Patna', 'East', '2023-06-03'),
('Bhubaneswar Petro', 'Bhubaneswar', 'East', '2023-06-05'),
('Guwahati Fuel Point', 'Guwahati', 'East', '2023-06-07');

SELECT COUNT(*) FROM dealers;

INSERT INTO products (product_name, category, price_per_unit) VALUES
('High Speed Diesel', 'Fuel', 94.50),
('Industrial Diesel', 'Fuel', 89.75),
('Aviation Fuel', 'Fuel', 128.00),
('CNG', 'Gas', 78.40),
('LPG Cylinder', 'Gas', 950.00),
('Brake Oil', 'Lubricant', 380.00),
('Hydraulic Oil', 'Lubricant', 520.00),
('Gear Oil', 'Lubricant', 610.00);
SELECT COUNT(*) FROM products;
INSERT INTO invoices (
    dealer_id,
    product_id,
    route_id,
    invoice_date,
    quantity,
    revenue,
    delivery_time,
    promised_time
)
SELECT
    FLOOR(1 + RAND() * 25) AS dealer_id,
    FLOOR(1 + RAND() * 13) AS product_id,
    FLOOR(1 + RAND() * 20) AS route_id,
    DATE_ADD('2026-01-01', INTERVAL FLOOR(RAND() * 90) DAY) AS invoice_date,
    ROUND(100 + RAND() * 900, 2) AS quantity,
    ROUND((100 + RAND() * 900) * (80 + RAND() * 500), 2) AS revenue,
    FLOOR(2 + RAND() * 8) AS delivery_time,
    FLOOR(4 + RAND() * 4) AS promised_time
FROM
    information_schema.tables
LIMIT 500;
SELECT COUNT(*) FROM invoices;
SELECT 
    (SELECT COUNT(*) FROM dealers) AS dealer_count,
    (SELECT COUNT(*) FROM products) AS product_count,
    (SELECT COUNT(*) FROM routes) AS route_count;
    INSERT INTO invoices (
    dealer_id,
    product_id,
    route_id,
    invoice_date,
    quantity,
    revenue,
    delivery_time,
    promised_time
)
SELECT
    FLOOR(1 + RAND() * 25) AS dealer_id,
    FLOOR(1 + RAND() * 13) AS product_id,
    FLOOR(1 + RAND() * 10) AS route_id,
    DATE_ADD('2026-01-01', INTERVAL FLOOR(RAND() * 90) DAY) AS invoice_date,
    ROUND(100 + RAND() * 900, 2) AS quantity,
    ROUND((100 + RAND() * 900) * (80 + RAND() * 500), 2) AS revenue,
    FLOOR(2 + RAND() * 8) AS delivery_time,
    FLOOR(4 + RAND() * 4) AS promised_time
FROM information_schema.tables
LIMIT 500;
SELECT COUNT(*) FROM invoices;
DELETE FROM invoices;
SELECT COUNT(*) FROM invoices;
SET SQL_SAFE_UPDATES = 0;
DELETE FROM invoices;
SELECT COUNT(*) FROM invoices;
SET SQL_SAFE_UPDATES = 1;
SELECT 
    i.invoice_id,
    p.product_name,
    p.price_per_unit,
    i.quantity,
    i.revenue,
    
    ROUND(i.quantity * p.price_per_unit, 2) AS expected_revenue

FROM invoices i
JOIN products p 
    ON i.product_id = p.product_id

LIMIT 10;
INSERT INTO invoices (
    dealer_id,
    product_id,
    route_id,
    invoice_date,
    quantity,
    revenue,
    delivery_time,
    promised_time
)
SELECT
    FLOOR(1 + RAND() * 25) AS dealer_id,
    p.product_id,
    FLOOR(1 + RAND() * 10) AS route_id,
    DATE_ADD('2026-01-01', INTERVAL FLOOR(RAND() * 90) DAY) AS invoice_date,
    ROUND(100 + RAND() * 900, 2) AS quantity,
    ROUND((100 + RAND() * 900) * p.price_per_unit, 2) AS revenue,
    FLOOR(2 + RAND() * 8) AS delivery_time,
    FLOOR(4 + RAND() * 4) AS promised_time
FROM products p
CROSS JOIN information_schema.tables
LIMIT 500;
SELECT COUNT(*) FROM invoices;
SELECT 
    i.invoice_id,
    p.product_name,
    p.price_per_unit,
    i.quantity,
    i.revenue,
    ROUND(i.quantity * p.price_per_unit, 2) AS expected_revenue
FROM invoices i
JOIN products p ON i.product_id = p.product_id
LIMIT 10;
SET SQL_SAFE_UPDATES = 0;
DELETE FROM invoices;
SET SQL_SAFE_UPDATES = 1;
INSERT INTO invoices (
    dealer_id,
    product_id,
    route_id,
    invoice_date,
    quantity,
    revenue,
    delivery_time,
    promised_time
)
SELECT
    base.dealer_id,
    base.product_id,
    base.route_id,
    base.invoice_date,
    base.quantity,
    
    ROUND(base.quantity * p.price_per_unit, 2) AS revenue,
    
    base.delivery_time,
    base.promised_time

FROM (
    SELECT
        FLOOR(1 + RAND() * 25) AS dealer_id,
        FLOOR(1 + RAND() * 13) AS product_id,
        FLOOR(1 + RAND() * 10) AS route_id,
        DATE_ADD('2026-01-01', INTERVAL FLOOR(RAND() * 90) DAY) AS invoice_date,
        ROUND(100 + RAND() * 900, 2) AS quantity,
        FLOOR(2 + RAND() * 8) AS delivery_time,
        FLOOR(4 + RAND() * 4) AS promised_time
    FROM information_schema.tables
    LIMIT 500
) base
JOIN products p
    ON base.product_id = p.product_id;
    SELECT 
    i.invoice_id,
    p.product_name,
    p.price_per_unit,
    i.quantity,
    i.revenue,
    ROUND(i.quantity * p.price_per_unit, 2) AS expected_revenue
FROM invoices i
JOIN products p ON i.product_id = p.product_id
LIMIT 10;
SET SQL_SAFE_UPDATES = 0;
DELETE FROM invoices;
SET SQL_SAFE_UPDATES = 1;
SELECT COUNT(*) FROM invoices;
INSERT INTO invoices (
    dealer_id,
    product_id,
    route_id,
    invoice_date,
    quantity,
    revenue,
    delivery_time,
    promised_time
)
SELECT
    x.dealer_id,
    x.product_id,
    x.route_id,
    x.invoice_date,
    x.quantity,
    ROUND(x.quantity * p.price_per_unit, 2) AS revenue,
    x.delivery_time,
    x.promised_time
FROM (
    SELECT
        FLOOR(1 + RAND() * 25) AS dealer_id,
        FLOOR(1 + RAND() * 13) AS product_id,
        FLOOR(1 + RAND() * 10) AS route_id,
        DATE_ADD('2026-01-01', INTERVAL FLOOR(RAND() * 90) DAY) AS invoice_date,
        ROUND(100 + RAND() * 900, 2) AS quantity,
        FLOOR(2 + RAND() * 8) AS delivery_time,
        FLOOR(4 + RAND() * 4) AS promised_time
    FROM information_schema.tables a
    CROSS JOIN information_schema.tables b
    LIMIT 500
) x
JOIN products p
    ON x.product_id = p.product_id;
    SELECT 
    i.invoice_id,
    p.product_name,
    p.price_per_unit,
    i.quantity,
    i.revenue,
    ROUND(i.quantity * p.price_per_unit, 2) AS expected_revenue
FROM invoices i
JOIN products p ON i.product_id = p.product_id
LIMIT 10;
SET SQL_SAFE_UPDATES = 0;
DELETE FROM invoices;
SET SQL_SAFE_UPDATES = 1;
INSERT INTO invoices (
    dealer_id,
    product_id,
    route_id,
    invoice_date,
    quantity,
    revenue,
    delivery_time,
    promised_time
)
SELECT
    x.dealer_id,
    x.product_id,
    x.route_id,
    x.invoice_date,
    x.quantity,
    ROUND(x.quantity * p.price_per_unit, 2) AS revenue,

    CASE
        WHEN r.distance_km <= 20 THEN FLOOR(2 + RAND() * 3)
        WHEN r.distance_km <= 40 THEN FLOOR(4 + RAND() * 3)
        ELSE FLOOR(6 + RAND() * 3)
    END AS delivery_time,

    CASE
        WHEN r.distance_km <= 20 THEN 4
        WHEN r.distance_km <= 40 THEN 6
        ELSE 8
    END AS promised_time

FROM (
    SELECT
        FLOOR(1 + RAND() * 25) AS dealer_id,
        FLOOR(1 + RAND() * 13) AS product_id,
        FLOOR(1 + RAND() * 10) AS route_id,
        DATE_ADD('2026-01-01', INTERVAL FLOOR(RAND() * 90) DAY) AS invoice_date,
        ROUND(100 + RAND() * 900, 2) AS quantity
    FROM information_schema.tables a
    CROSS JOIN information_schema.tables b
    LIMIT 500
) x

JOIN products p 
    ON x.product_id = p.product_id
JOIN routes r 
    ON x.route_id = r.route_id;
    SELECT 
    i.invoice_id,
    r.route_name,
    r.distance_km,
    i.delivery_time,
    i.promised_time
FROM invoices i
JOIN routes r 
    ON i.route_id = r.route_id
LIMIT 15;
INSERT INTO targets (dealer_id, month, target_revenue)
SELECT
    dealer_id,
    '2026-01-01',
    ROUND(50000 + RAND() * 100000, 2)
FROM dealers
WHERE dealer_id NOT IN (
    SELECT dealer_id FROM targets
);
INSERT INTO targets (dealer_id, month, target_revenue)
SELECT
    d.dealer_id,
    '2026-01-01',
    ROUND(50000 + RAND() * 100000, 2)
FROM dealers d
LEFT JOIN targets t
    ON d.dealer_id = t.dealer_id
WHERE t.dealer_id IS NULL;
SELECT COUNT(*) FROM targets;
USE petroleum_dashboard;
DELETE FROM targets;

INSERT INTO targets (dealer_id, month, target_revenue)
SELECT
    dealer_id,
    '2026-01-01',
    ROUND(2500000 + RAND() * 2500000, 2)
FROM dealers;
SET SQL_SAFE_UPDATES = 0;

DELETE FROM targets;

SET SQL_SAFE_UPDATES = 1;
UPDATE invoices
SET delivery_time = promised_time + FLOOR(1 + RAND()*3)
WHERE RAND() < 0.25;
SET SQL_SAFE_UPDATES = 0;

UPDATE invoices
SET delivery_time = promised_time + FLOOR(1 + RAND()*3)
WHERE RAND() < 0.25;

SET SQL_SAFE_UPDATES = 1;