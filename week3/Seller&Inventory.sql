CREATE DATABASE IF NOT EXISTS SellerInventory;
USE SellerInventory;
CREATE TABLE Product (
    Product_ID INT PRIMARY KEY,
    Product_Name VARCHAR(100) NOT NULL,
    Category VARCHAR(50),
    Price DECIMAL(10,2) CHECK (Price >= 0)
);
CREATE TABLE Seller (
    Seller_ID INT PRIMARY KEY,
    Seller_Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(15) UNIQUE,
    Address VARCHAR(200)
);
CREATE TABLE Inventory (
    Inventory_ID INT PRIMARY KEY,
    Product_ID INT NOT NULL,
    Seller_ID INT NOT NULL,
    Stock_Quantity INT NOT NULL CHECK (Stock_Quantity >= 0),
    Stock_Status VARCHAR(20) NOT NULL CHECK (Stock_Status IN ('Available','Out of Stock')),
    Last_Updated DATE NOT NULL,
    FOREIGN KEY (Product_ID) REFERENCES Product(Product_ID),
    FOREIGN KEY (Seller_ID) REFERENCES Seller(Seller_ID)
);
INSERT INTO Product VALUES
(101, 'Laptop', 'Electronics', 55000.00),
(102, 'Keyboard', 'Electronics', 1200.00),
(103, 'Mouse', 'Electronics', 700.00),
(104, 'Headphones', 'Accessories', 1800.00),
(105, 'USB Cable', 'Accessories', 300.00),
(106, 'Web Camera', 'Electronics', 2500.00),
(107, 'Power Bank', 'Accessories', 1500.00),
(108, 'Printer', 'Electronics', 12000.00);
INSERT INTO Seller VALUES
(1, 'ABC Electronics', 'abc@gmail.com', '9876543210', 'Chennai'),
(2, 'Smart Tech', 'smarttech@gmail.com', '9876543211', 'Madurai'),
(3, 'Digital World', 'digitalworld@gmail.com', '9876543212', 'Coimbatore'),
(4, 'Tech Mart', 'techmart@gmail.com', '9876543213', 'Thoothukudi');
INSERT INTO Inventory VALUES
(1001, 101, 1, 25, 'Available', '2026-09-28'),
(1002, 102, 1, 8, 'Available', '2026-09-28'),
(1003, 103, 2, 0, 'Out of Stock', '2026-09-28'),
(1004, 104, 2, 15, 'Available', '2026-09-28'),
(1005, 105, 3, 5, 'Available', '2026-09-28'),
(1006, 106, 3, 0, 'Out of Stock', '2026-09-28'),
(1007, 107, 4, 12, 'Available', '2026-09-28'),
(1008, 108, 4, 30, 'Available', '2026-09-28');
INSERT INTO Seller
VALUES (5, 'New Tech Store', 'newtech@gmail.com', '9876543214', 'Tirunelveli');
INSERT INTO Inventory
VALUES (1009, 103, 5, 20, 'Available', '2026-09-28');
SELECT s.Seller_Name, p.Product_Name, i.Stock_Quantity
FROM Seller s
JOIN Inventory i ON s.Seller_ID = i.Seller_ID
JOIN Product p ON i.Product_ID = p.Product_ID
ORDER BY s.Seller_Name;

 Count products supplied by each seller
SELECT s.Seller_Name, COUNT(i.Product_ID) AS Product_Count
FROM Seller s
LEFT JOIN Inventory i ON s.Seller_ID = i.Seller_ID
GROUP BY s.Seller_ID, s.Seller_Name;

 Update seller details
UPDATE Seller
SET Phone = '987650000', Address = 'Chennai, Tamil Nadu'
WHERE Seller_ID = 2;
SELECT p.Product_ID, p.Product_Name, i.Stock_Quantity
FROM Product p
JOIN Inventory i ON p.Product_ID = i.Product_ID
WHERE i.Stock_Quantity > 0;
SELECT p.Product_ID, p.Product_Name
FROM Product p
JOIN Inventory i ON p.Product_ID = i.Product_ID
WHERE i.Stock_Quantity = 0;
SELECT p.Product_Name, i.Stock_Quantity
FROM Product p
JOIN Inventory i ON p.Product_ID = i.Product_ID
WHERE i.Stock_Quantity < 10;
UPDATE Inventory
SET Stock_Quantity = 18,
    Stock_Status = 'Available',
    Last_Updated = '2026-09-28'
WHERE Inventory_ID = 1002;
DELETE FROM Inventory
WHERE Inventory_ID = 1006;
SELECT s.Seller_Name, p.Product_Name, i.Stock_Quantity, i.Stock_Status
FROM Seller s
JOIN Inventory i ON s.Seller_ID = i.Seller_ID
JOIN Product p ON i.Product_ID = p.Product_ID
ORDER BY s.Seller_Name;
SELECT p.Product_Name, i.Stock_Quantity, i.Stock_Status
FROM Product p
JOIN Inventory i ON p.Product_ID = i.Product_ID;
SELECT SUM(Stock_Quantity) AS Total_Available_Stock
FROM Inventory
WHERE Stock_Quantity > 0;
SELECT COUNT(*) AS Out_of_Stock_Products
FROM Inventory
WHERE Stock_Quantity = 0;
SELECT p.Product_Name, i.Stock_Quantity
FROM Product p
JOIN Inventory i ON p.Product_ID = i.Product_ID
WHERE i.Stock_Quantity = (
    SELECT MAX(Stock_Quantity) FROM Inventory
);
SELECT ROUND(AVG(Stock_Quantity), 2) AS Average_Inventory_Quantity
FROM Inventory;
SELECT * FROM Seller;
SELECT * FROM Product;
SELECT * FROM Inventory;

