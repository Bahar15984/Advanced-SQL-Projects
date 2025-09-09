/* ========= DB Objects (DDL) ========= */

/* Core (Northwind-like) */
IF OBJECT_ID('dbo.Shippers','U') IS NOT NULL DROP TABLE dbo.Shippers;
IF OBJECT_ID('dbo.Employees','U') IS NOT NULL DROP TABLE dbo.Employees;
IF OBJECT_ID('dbo.Customers','U') IS NOT NULL DROP TABLE dbo.Customers;
IF OBJECT_ID('dbo.Orders','U') IS NOT NULL DROP TABLE dbo.Orders;
IF OBJECT_ID('dbo.OrderDetails','U') IS NOT NULL DROP TABLE dbo.OrderDetails;
IF OBJECT_ID('dbo.Products','U') IS NOT NULL DROP TABLE dbo.Products;

CREATE TABLE dbo.Shippers (
    ShipperID   INT        NOT NULL PRIMARY KEY,
    CompanyName NVARCHAR(100) NOT NULL
);

CREATE TABLE dbo.Employees (
    EmployeeID  INT        NOT NULL PRIMARY KEY,
    LastName    NVARCHAR(50) NOT NULL,
    FirstName   NVARCHAR(50) NOT NULL
);

CREATE TABLE dbo.Customers (
    CustomerID  NCHAR(5)   NOT NULL PRIMARY KEY,
    CompanyName NVARCHAR(100) NOT NULL,
    ContactName NVARCHAR(100) NOT NULL,
    Country     NVARCHAR(50)  NOT NULL
);

CREATE TABLE dbo.Orders (
    OrderID     INT        NOT NULL PRIMARY KEY,
    CustomerID  NCHAR(5)   NOT NULL,
    EmployeeID  INT        NOT NULL,
    OrderDate   DATE       NOT NULL,
    ShipperID   INT        NOT NULL,
    CONSTRAINT FK_Orders_Customers FOREIGN KEY (CustomerID) REFERENCES dbo.Customers(CustomerID),
    CONSTRAINT FK_Orders_Employees FOREIGN KEY (EmployeeID) REFERENCES dbo.Employees(EmployeeID),
    CONSTRAINT FK_Orders_Shippers  FOREIGN KEY (ShipperID)  REFERENCES dbo.Shippers(ShipperID)
);


CREATE TABLE Products (
    ProductID   INT PRIMARY KEY,
    ProductName NVARCHAR(100) NOT NULL,
    Price       DECIMAL(10,2) NOT NULL   
);


CREATE TABLE dbo.OrderDetails (
    OrderID     INT NOT NULL,
    ProductID   INT NOT NULL,
    Quantity    INT NOT NULL,
    CONSTRAINT PK_OrderDetails PRIMARY KEY (OrderID, ProductID),
    CONSTRAINT FK_OD_Orders   FOREIGN KEY (OrderID)   REFERENCES dbo.Orders(OrderID),
    CONSTRAINT FK_OD_Products FOREIGN KEY (ProductID) REFERENCES dbo.Products(ProductID)
);

/* POS / Sales */
IF OBJECT_ID('dbo.POS1','U') IS NOT NULL DROP TABLE dbo.POS1;
IF OBJECT_ID('dbo.POS2','U') IS NOT NULL DROP TABLE dbo.POS2;
IF OBJECT_ID('dbo.POS3','U') IS NOT NULL DROP TABLE dbo.POS3;
IF OBJECT_ID('dbo.Sales_Summary','U') IS NOT NULL DROP TABLE dbo.Sales_Summary;

CREATE TABLE dbo.POS1 (
    [date]   DATE         NOT NULL,
    [sales]  DECIMAL(10,2) NOT NULL,
    [product] INT         NOT NULL,
    [no]     INT          NOT NULL
);

CREATE TABLE dbo.POS2 (
    [date]   DATE         NOT NULL,
    [sales]  DECIMAL(10,2) NOT NULL,
    [product] INT         NOT NULL,
    [no]     INT          NOT NULL
);

CREATE TABLE dbo.POS3 (
    [date]   DATE         NOT NULL,
    [sales]  DECIMAL(10,2) NOT NULL,
    [product] INT         NOT NULL,
    [no]     INT          NOT NULL
);

CREATE TABLE dbo.Sales_Summary (
    [date]    DATE         NOT NULL,
    [product] INT          NOT NULL,
    [sales]   DECIMAL(10,2) NOT NULL
    /* No PK by design for fast append; add indexes later if needed */
);
