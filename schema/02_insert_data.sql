/* ========= Seed data (DML) ========= */

/* Core */
INSERT INTO dbo.Shippers (ShipperID, CompanyName) VALUES
(1,'Speedy Express'),
(2,'United Package'),
(3,'Federal Shipping');

select * from dbo.Shippers;

INSERT INTO dbo.Employees (EmployeeID, LastName, FirstName) VALUES
(1,'Davolio','Nancy'),
(2,'Fuller','Andrew'),
(3,'Leverling','Janet'),
(4,'Peacock','Margaret'),
(5,'Buchanan','Steven'),
(6,'Suyama','Michael');

select * from dbo.Employees;

-- Example extra row (if desired)
-- INSERT INTO dbo.Employees VALUES (7,'Suyama','Michael');

INSERT INTO dbo.Customers (CustomerID, CompanyName, ContactName, Country) VALUES
('ALFKI','Alfreds Futterkiste','Maria Anders','Germany'),
('ANATR','Ana Trujillo Emparedados y helados','Ana Trujillo','Mexico'),
('ANTON','Antonio Moreno Taquería','Antonio Moreno','Mexico');
select * FROM dbo.Customers;






INSERT INTO dbo.Orders (OrderID, CustomerID, EmployeeID, OrderDate, ShipperID) VALUES
(10248,'ALFKI',5,'2020-07-04',3),
(10249,'ANATR',6,'2020-07-05',1),
(10250,'ALFKI',4,'2020-07-08',1),
(10251,'ANTON',3,'2020-07-08',2);
select * from dbo.Orders;



INSERT INTO dbo.Products (ProductID, ProductName) VALUES
(11,'Queso Cabrales'),
(42,'Singaporean Hokkien Fried Mee'),
(14,'Tofu'),
(51,'Manjimup Dried Apples');



INSERT INTO dbo.OrderDetails (OrderID, ProductID, Quantity) VALUES
(10248,11,12),
(10249,42,10),
(10250,14,5),
(10251,51,6);
select * from dbo.OrderDetails;


/* POS demo data */
INSERT INTO dbo.POS1 ([date],[sales],[product],[no]) VALUES
('2000-01-10', 120.00, 23,  1),
('2000-01-11', 150.50, 27,  2),
('2000-01-12',  99.99, 23, 10);
select * FROM dbo.POS1;

INSERT INTO dbo.POS2 ([date],[sales],[product],[no]) VALUES
('2001-02-05', 210.00, 23,  5),
('2001-02-06', 310.00, 27,  6);
select * FROM dbo.POS2;

INSERT INTO dbo.POS3 ([date],[sales],[product],[no]) VALUES
('2001-01-22', 280.00, 23,  3),
('2002-01-22', 400.00, 27, 15);
select * FROM dbo.POS3;

/* Consolidate POS into Sales_Summary */
INSERT INTO dbo.Sales_Summary ([date],[product],[sales])
SELECT [date],[product],[sales] FROM dbo.POS1
UNION ALL
SELECT [date],[product],[sales] FROM dbo.POS2
UNION ALL
SELECT [date],[product],[sales] FROM dbo.POS3;

SELECT * FROM dbo.Sales_Summary ORDER BY [date];