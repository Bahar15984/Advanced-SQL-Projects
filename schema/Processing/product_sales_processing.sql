/* =========================
   Processing / Transformations
   ========================= */

-- 1. Find Duplicates
SELECT ps1.*
FROM Product_Sales1 ps1
JOIN Product_Sales2 ps2
  ON ps1.product = ps2.product
  AND ps1.no = ps2.no
  AND ps1.price = ps2.price;

-- 2. Merge Tables
CREATE TABLE Merged_Table (
    product INT,
    no INT,
    q INT,
    price DECIMAL(10,2)
);

INSERT INTO Merged_Table (product, no, q, price)
SELECT product, no, q, price FROM Product_Sales1
UNION ALL
SELECT product, no, NULL AS q, price FROM Product_Sales2;

-- 3. Remove Duplicates
CREATE TABLE Cleaned_Table_Strict (
    product INT,
    no INT,
    price DECIMAL(10, 2)
);

-- Populate after deduplication
INSERT INTO Cleaned_Table_Strict
SELECT DISTINCT product, no, price
FROM Merged_Table;
