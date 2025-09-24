CREATE DATABASE ECommerceDataBase;
USE ECommerceDataBase;
--Creating tables
--Customers
CREATE TABLE Customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    created_at DATE
);
--products
CREATE TABLE Products (
    product_id INT PRIMARY KEY,
    name VARCHAR(100),
    price DECIMAL(10, 2),
    category VARCHAR(50)
);
--Orders
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    order_date DATE,
    quantity INT,
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);
--payments
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY,
    order_id INT,
    amount DECIMAL(10, 2),
    payment_date DATE,
    payment_method VARCHAR(50),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

--Inserting data
--Customers
INSERT INTO Customers (customer_id, name, email, created_at) VALUES
(1, 'Aarav Sharma', 'aarav@example.com', '2023-01-10'),
(2, 'Meera Iyer', 'meera@example.com', '2023-02-15'),
(3, 'Ravi Kumar', 'ravi@example.com', '2023-03-20'),
(4, 'Sneha Reddy', 'sneha@example.com', '2023-04-05'),
(5, 'Karan Patel', 'karan@example.com', '2023-05-12');

--Products
INSERT INTO Products (product_id, name, price, category) VALUES
(101, 'Wireless Mouse', 799.00, 'Electronics'),
(102, 'Bluetooth Speaker', 1499.00, 'Electronics'),
(103, 'Yoga Mat', 599.00, 'Fitness'),
(104, 'Notebook Pack', 299.00, 'Stationery'),
(105, 'Desk Lamp', 899.00, 'Home Decor');

--Orders
INSERT INTO Orders (order_id, customer_id, product_id, order_date, quantity) VALUES
(1001, 1, 101, '2023-06-01', 2),
(1002, 2, 102, '2023-06-03', 1),
(1003, 3, 103, '2023-06-05', 3),
(1004, 1, 104, '2023-07-10', 5),
(1005, 4, 105, '2023-07-15', 1),
(1006, 5, 101, '2023-08-01', 1),
(1007, 2, 103, '2023-08-05', 2),
(1008, 3, 102, '2023-08-10', 1);

--Payments
INSERT INTO Payments (payment_id, order_id, amount, payment_date, payment_method) VALUES
(5001, 1001, 1598.00, '2023-06-01', 'Credit Card'),
(5002, 1002, 1499.00, '2023-06-03', 'UPI'),
(5003, 1003, 1797.00, '2023-06-05', 'Debit Card'),
(5004, 1004, 1495.00, '2023-07-10', 'Net Banking'),
(5005, 1005, 899.00, '2023-07-15', 'Credit Card'),
(5006, 1006, 799.00, '2023-08-01', 'UPI'),
(5007, 1007, 1198.00, '2023-08-05', 'Debit Card'),
(5008, 1008, 1499.00, '2023-08-10', 'Credit Card');

--Top 5 customers by total spend
SELECT TOP 5 
    c.customer_id, 
    c.name, 
    SUM(p.amount) AS total_spent
FROM Customers c
JOIN Orders o ON c.customer_id = o.customer_id
JOIN Payments p ON o.order_id = p.order_id
GROUP BY c.customer_id, c.name
ORDER BY total_spent DESC;

--Best selling products by quantity
SELECT TOP 5 
    pr.product_id, 
    pr.name, 
    COUNT(*) AS total_orders
FROM Products pr
JOIN Orders o ON pr.product_id = o.product_id
GROUP BY pr.product_id, pr.name
ORDER BY total_orders DESC;

--Monthly sales summary
SELECT FORMAT(o.order_date, 'yyyy-MM') AS month, SUM(p.amount) AS monthly_sales
FROM Orders o
JOIN Payments p ON o.order_id = p.order_id
GROUP BY FORMAT(o.order_date, 'yyyy-MM')
ORDER BY month;