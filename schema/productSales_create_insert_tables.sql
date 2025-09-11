/* ============================================
   Product Sales Analysis - Tables & Inserts
   ============================================ */

-- Table 1
CREATE TABLE Product_Sales1 (
    product INT,
    no INT,
    q INT,
    price DECIMAL(10, 2)
);

INSERT INTO Product_Sales1 VALUES
(23, 3, 12, 250.00),
(23, 15, 24, 450.00),
(23, 25, 16, 346.00),
(46, 45, 25, 560.00);

------------------------------------------------

-- Table 2
CREATE TABLE Product_Sales2 (
    product INT,
    no INT,
    price DECIMAL(10, 2)
);

INSERT INTO Product_Sales2 VALUES
(46, 23, 250.00),
(27, 15, 450.00),
(37, 25, 36.00),
(46, 50, 700.00),
(23, 3, 250.00); -- duplicate for testing

------------------------------------------------

-- Merged Table (later populated by UNION query)
CREATE TABLE Merged_Table (
    product INT,
    no INT,
    q INT,
    price DECIMAL(10,2)
);

------------------------------------------------

-- Cleaned Table (to store deduplicated data)
CREATE TABLE Cleaned_Table_Strict (
    product INT,
    no INT,
    price DECIMAL(10, 2)
);

------------------------------------------------

-- POS1
CREATE TABLE POS1 (
    date DATE,
    sales DECIMAL(10, 2),
    product INT,
    no INT
);

INSERT INTO POS1 VALUES
('2001-01-22', 250.00, 23, 3),
('2002-01-22', 300.00, 27, 15);

------------------------------------------------

-- POS2
CREATE TABLE POS2 (
    date DATE,
    sales DECIMAL(10, 2),
    product INT,
    no INT
);

INSERT INTO POS2 VALUES
('2001-01-22', 280.00, 23, 3),
('2002-01-22', 150.00, 37, 25);

------------------------------------------------

-- POS3
CREATE TABLE POS3 (
    date DATE,
    sales DECIMAL(10, 2),
    product INT,
    no INT
);

INSERT INTO POS3 VALUES
('2001-01-22', 280.00, 23, 3),
('2002-01-22', 400.00, 27, 15);

------------------------------------------------

-- Sales_Summary
CREATE TABLE Sales_Summary (
    date DATE,
    product INT,
    sales DECIMAL(10, 2)
);

-- Populate from POS tables
INSERT INTO Sales_Summary (date, product, sales)
SELECT date, product, sales FROM POS1
UNION ALL
SELECT date, product, sales FROM POS2
UNION ALL
SELECT date, product, sales FROM POS3;
