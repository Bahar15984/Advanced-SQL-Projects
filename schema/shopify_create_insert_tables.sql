/* ==============================================
   Shopify Case Study – Database & Tables Setup
   ============================================== */

CREATE DATABASE W3Schools;
GO

USE W3Schools;
GO

/* -------------------------
   Shippers Table
------------------------- */
CREATE TABLE Shippers (
    ShipperID INT PRIMARY KEY,
    ShipperName NVARCHAR(100)
);

INSERT INTO Shippers VALUES
(1, 'Speedy Express'),
(2, 'United Package'),
(3, 'Federal Shipping');

SELECT * FROM Shippers;

/* -------------------------
   Employees Table
------------------------- */
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    LastName NVARCHAR(100),
    FirstName NVARCHAR(100)
);

INSERT INTO Employees VALUES
(1, 'Davolio', 'Nancy'),
(2, 'Fuller', 'Andrew'),
(3, 'Leverling', 'Janet'),
(4, 'Peacock', 'Margaret'),
(5, 'Buchanan', 'Steven'),
(6, 'Suyama', 'Michael'),
(7, 'Suyama', 'Michael'); -- duplicate for testing

SELECT * FROM Employees;

/* -------------------------
   Customers Table
------------------------- */
CREATE TABLE Customers (
    CustomerID NVARCHAR(5) PRIMARY KEY,
    CompanyName NVARCHAR(100),
    ContactName NVARCHAR(100),
    Country NVARCHAR(100)
);

INSERT INTO Customers VALUES
('ALFKI', 'Alfreds Futterkiste', 'Maria Anders', 'Germany'),
('ANATR', 'Ana Trujillo Emparedados y helados', 'Ana Trujillo', 'Mexico'),
('ANTON', 'Antonio Moreno Taquería', 'Antonio Moreno', 'Mexico');

SELECT * FROM Customers;

/* -------------------------
   Orders Table
------------------------- */
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerID NVARCHAR(5),
    EmployeeID INT,
    OrderDate DATE,
    ShipperID INT,
    FOREIGN KEY (CustomerID) REFERENCES Customers(CustomerID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (ShipperID) REFERENCES Shippers(ShipperID)
);

INSERT INTO Orders VALUES
(10248, 'ALFKI', 5, '2020-07-04', 3),
(10249, 'ANATR', 6, '2020-07-05', 1),
(10250, 'ALFKI', 4, '2020-07-08', 1),
(10251, 'ANTON', 3, '2020-07-08', 2);

SELECT * FROM Orders;

/* -------------------------
   OrderDetails Table
------------------------- */
CREATE TABLE OrderDetails (
    OrderDetailID INT IDENTITY PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

INSERT INTO OrderDetails (OrderID, ProductID, Quantity) VALUES
(10248, 11, 12),
(10249, 42, 10),
(10250, 14, 5),
(10251, 51, 6);

SELECT * FROM OrderDetails;
/* -------------------------
   Products Table
------------------------- */
CREATE TABLE Products (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(100)
);

INSERT INTO Products VALUES
(11, 'Queso Cabrales'),
(42, 'Singaporean Hokkien Fried Mee'),
(14, 'Tofu'),
(51, 'Manjimup Dried Apples');

-- Update Price values for Products
UPDATE Products
SET Price = CASE ProductID
    WHEN 11 THEN 21.00
    WHEN 42 THEN 14.00
    WHEN 14 THEN 23.25
    WHEN 51 THEN 53.00
    ELSE 0
END;
SELECT * FROM Products;