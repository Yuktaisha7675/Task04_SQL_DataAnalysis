-- Customers Table
CREATE TABLE customers (
  customer_id INTEGER PRIMARY KEY,
  name TEXT,
  country TEXT
);

-- Orders Table
CREATE TABLE orders (
  order_id INTEGER PRIMARY KEY,
  customer_id INTEGER,
  order_date DATE,
  amount REAL,
  FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- Products Table
CREATE TABLE products (
  product_id INTEGER PRIMARY KEY,
  product_name TEXT,
  category TEXT,
  price REAL
);

-- Order Details Table
CREATE TABLE order_details (
  order_detail_id INTEGER PRIMARY KEY,
  order_id INTEGER,
  product_id INTEGER,
  quantity INTEGER,
  FOREIGN KEY (order_id) REFERENCES orders(order_id),
  FOREIGN KEY (product_id) REFERENCES products(product_id)
);
-- Customers
INSERT INTO customers VALUES (1, 'Alice', 'USA'), (2, 'Bob', 'India'), (3, 'Charlie', 'UK');

-- Orders
INSERT INTO orders VALUES (101, 1, '2023-06-01', 300.00), (102, 2, '2023-06-02', 450.00), (103, 3, '2023-06-03', 200.00);

-- Products
INSERT INTO products VALUES (201, 'Laptop', 'Electronics', 1000.00), (202, 'Headphones', 'Electronics', 100.00), (203, 'Shoes', 'Apparel', 50.00);

-- Order Details
INSERT INTO order_details VALUES (301, 101, 201, 1), (302, 102, 202, 2), (303, 103, 203, 4);
-- SELECT with WHERE, ORDER BY
SELECT * FROM customers WHERE country = 'India' ORDER BY name;

-- GROUP BY with Aggregate Function
SELECT country, COUNT(*) AS total_customers FROM customers GROUP BY country;
-- INNER JOIN
SELECT orders.order_id, customers.name, orders.amount
FROM orders
INNER JOIN customers ON orders.customer_id = customers.customer_id;

-- LEFT JOIN
SELECT customers.name, orders.order_date
FROM customers
LEFT JOIN orders ON customers.customer_id = orders.customer_id;

-- RIGHT JOIN is not supported in SQLite directly, simulate using LEFT JOIN from reverse
SELECT orders.order_id, customers.name
FROM orders
LEFT JOIN customers ON orders.customer_id = customers.customer_id;
-- Subquery to find customers who placed orders above average
SELECT name FROM customers
WHERE customer_id IN (
  SELECT customer_id FROM orders WHERE amount > (SELECT AVG(amount) FROM orders)
);
-- SUM and AVG
SELECT customer_id, SUM(amount) AS total_spent, AVG(amount) AS avg_spent
FROM orders
GROUP BY customer_id;
-- View for order summary
CREATE VIEW order_summary AS
SELECT o.order_id, c.name AS customer_name, o.order_date, o.amount
FROM orders o
JOIN customers c ON o.customer_id = c.customer_id;

-- Select from view
SELECT * FROM order_summary;
-- Create indexes to speed up queries
CREATE INDEX idx_customer_id ON customers(customer_id);
CREATE INDEX idx_order_date ON orders(order_date);





