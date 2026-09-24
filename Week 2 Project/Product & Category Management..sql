CREATE DATABASE ProductCategoryDB;
USE ProductCategoryDB;
CREATE TABLE Category (
    Category_ID INT PRIMARY KEY,
    Category_Name VARCHAR(50) NOT NULL UNIQUE,
    Description VARCHAR(150) NOT NULL
);
CREATE TABLE Product (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(100) NOT NULL UNIQUE,
    Category_ID INT NOT NULL,
    Price DECIMAL(10,2) NOT NULL CHECK (Price > 0),
    Stock_Quantity INT NOT NULL CHECK (Stock_Quantity >= 0),
    FOREIGN KEY (Category_ID) REFERENCES Category(Category_ID)
);
INSERT INTO Category VALUES
(1, 'Electronics', 'Electronic devices and accessories'),
(2, 'Books', 'Educational and general reading books'),
(3, 'Clothing', 'Men and women clothing products'),
(4, 'Home Appliances', 'Useful appliances for home');
INSERT INTO Product VALUES
(101, 'Wireless Mouse', 1, 799.00, 25),
(102, 'Bluetooth Speaker', 1, 1499.00, 18),
(103, 'USB Keyboard', 1, 999.00, 30),
(104, 'Python Programming Book', 2, 650.00, 12),
(105, 'Data Science Handbook', 2, 850.00, 10),
(106, 'Cotton T-Shirt', 3, 499.00, 40),
(107, 'Denim Jeans', 3, 1299.00, 15),
(108, 'Electric Kettle', 4, 1199.00, 20),
(109, 'Mixer Grinder', 4, 2499.00, 8),
(110, 'Smart Watch', 1, 2999.00, 14);
INSERT INTO Product
VALUES (111, 'Webcam', 1, 1899.00, 10);
SELECT * FROM Product;
UPDATE Product
SET Price = 1799.00, Stock_Quantity = 12
WHERE Product_ID = 111;
SELECT c.Category_Name, p.Product_Name, p.Price, p.Stock_Quantity
FROM Category c
JOIN Product p
ON c.Category_ID = p.Category_ID
ORDER BY c.Category_Name;
SELECT c.Category_Name, COUNT(p.Product_ID) AS Product_Count
FROM Category c
LEFT JOIN Product p
ON c.Category_ID = p.Category_ID
GROUP BY c.Category_ID, c.Category_Name;
SELECT Product_Name, Price
FROM Product
WHERE Price = (SELECT MAX(Price) FROM Product);
SELECT c.Category_Name, COUNT(p.Product_ID) AS Product_Count
FROM Category c
JOIN Product p
ON c.Category_ID = p.Category_ID
GROUP BY c.Category_ID, c.Category_Name
HAVING COUNT(p.Product_ID) > 5;
SELECT AVG(Price) AS Average_Product_Price
FROM Product;

