-- HAVING Clause Examples in SQL
-- =============================================
-- This file demonstrates various examples of using HAVING in SQL queries
-- to filter grouped records after aggregation.

-- Database Setup
-- =============================================
CREATE DATABASE db_for_having;
USE db_for_having;

-- Table Creation
-- =============================================
CREATE TABLE sales (
    id INT AUTO_INCREMENT PRIMARY KEY,
    product VARCHAR(50),
    category VARCHAR(50),
    quantity INT,
    price DECIMAL(10,2),
    sale_date DATE
);

-- Initial Data Insertion
-- =============================================
INSERT INTO sales (product, category, quantity, price, sale_date) VALUES
('Laptop', 'Electronics', 5, 70000, '2021-01-12'),
('Smartphone', 'Electronics', 10, 30000, '2021-02-18'),
('Tablet', 'Electronics', 4, 25000, '2021-03-22'),
('Shirt', 'Clothing', 20, 1500, '2021-04-15'),
('Jeans', 'Clothing', 15, 2000, '2021-05-10'),
('Jacket', 'Clothing', 8, 4000, '2021-06-25'),
('Sofa', 'Furniture', 2, 30000, '2021-07-05'),
('Chair', 'Furniture', 6, 5000, '2021-08-11'),
('Table', 'Furniture', 3, 12000, '2021-09-20'),
('Bed', 'Furniture', 1, 45000, '2021-10-01');

-- View All Sales Data
-- =============================================
SELECT * FROM sales;

-- Example 1: Find Categories Having More Than 2 Products
-- =============================================
SELECT category, COUNT(*) AS total_products
FROM sales
GROUP BY category
HAVING COUNT(*) > 2;

-- Example 2: Find Categories With Average Price Greater Than 20,000
-- =============================================
SELECT category, AVG(price) AS avg_price
FROM sales
GROUP BY category
HAVING avg_price > 20000;

-- Example 3: Find Products Sold More Than 5 Times
-- =============================================
SELECT product, SUM(quantity) AS total_quantity
FROM sales
GROUP BY product
HAVING SUM(quantity) > 5;

-- Example 4: Find Categories With Total Sales Value Above 50,000
-- =============================================
SELECT category, SUM(quantity * price) AS total_sales
FROM sales
GROUP BY category
HAVING total_sales > 50000;

-- Example 5: Find Categories Where Minimum Price Is Greater Than 2000
-- =============================================
SELECT category, MIN(price) AS min_price
FROM sales
GROUP BY category
HAVING MIN(price) > 2000;

-- Example 6: Find Categories With Both Conditions (More Than 3 Products AND Avg Price > 10000)
-- =============================================
SELECT category, COUNT(*) AS total_products, AVG(price) AS avg_price
FROM sales
GROUP BY category
HAVING total_products > 3 AND avg_price > 10000;

-- Example 7: Find Products Sold After 2021-05-01 With Total Quantity > 5
-- =============================================
SELECT product, SUM(quantity) AS total_quantity
FROM sales
WHERE sale_date > '2021-05-01'
GROUP BY product
HAVING total_quantity > 5;

-- Example 8: Find The Category With The Highest Average Price
-- =============================================
SELECT category, AVG(price) AS avg_price
FROM sales
GROUP BY category
HAVING avg_price = (
    SELECT MAX(avg_price)
    FROM (
        SELECT AVG(price) AS avg_price
        FROM sales
        GROUP BY category
    ) AS subquery
);
