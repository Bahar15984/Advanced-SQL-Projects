/* ===============================================
   Shopify Case Study – Analysis Queries
   =============================================== */

/* 1) Total number of orders per customer */
SELECT CustomerID, COUNT(*) AS total_orders
FROM Orders
GROUP BY CustomerID
ORDER BY total_orders DESC;

/* 2) Top 5 customers by total sales */
SELECT o.CustomerID, SUM(od.Quantity * p.Price) AS total_sales
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY o.CustomerID
ORDER BY total_sales DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;

/* 3) Total revenue per product */
SELECT p.ProductID, p.ProductName, SUM(od.Quantity * p.Price) AS revenue
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY revenue DESC;

/* 4) Average order value (AOV) per customer */
WITH order_totals AS (
    SELECT
        o.OrderID,
        o.CustomerID,
        SUM(od.Quantity * p.Price) AS order_total
    FROM dbo.Orders o
    JOIN dbo.OrderDetails od ON o.OrderID = od.OrderID
    JOIN dbo.Products     p  ON od.ProductID = p.ProductID
    -- WHERE o.OrderDate BETWEEN '2020-01-01' AND '2020-12-31'
    GROUP BY o.OrderID, o.CustomerID
)
SELECT
    ot.CustomerID,
    CAST(AVG(ot.order_total) AS DECIMAL(18,2)) AS avg_order_value
FROM order_totals ot
GROUP BY ot.CustomerID
ORDER BY avg_order_value DESC;



/* 5) Monthly sales trend */
SELECT YEAR(o.OrderDate) AS year, MONTH(o.OrderDate) AS month,
       SUM(od.Quantity * p.Price) AS monthly_sales
FROM Orders o
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY YEAR(o.OrderDate), MONTH(o.OrderDate)
ORDER BY year, month;

/* 6) Top-selling products by quantity */
SELECT TOP 10 p.ProductName, SUM(od.Quantity) AS total_qty
FROM OrderDetails od
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY p.ProductName
ORDER BY total_qty DESC;

/* 7) Repeat customers (placed more than 1 order) */
SELECT CustomerID, COUNT(DISTINCT OrderID) AS num_orders
FROM Orders
GROUP BY CustomerID
HAVING COUNT(DISTINCT OrderID) > 1;

/* 8) Customers who placed an order in the last 30 days */
SELECT DISTINCT CustomerID
FROM Orders
WHERE OrderDate >= DATEADD(DAY, -30, CAST(GETDATE() AS DATE));

/* 9) Percentage of orders shipped by each Shipper */
SELECT s.CompanyName,
       COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Orders) AS percent_of_orders
FROM Orders o
JOIN Shippers s ON o.ShipperID = s.ShipperID
GROUP BY s.CompanyName;

/* 10) Most popular product per country */
SELECT c.Country, p.ProductName, SUM(od.Quantity) AS qty_sold
FROM Orders o
JOIN Customers c ON o.CustomerID = c.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
GROUP BY c.Country, p.ProductName
HAVING SUM(od.Quantity) = (
    SELECT MAX(SUM(od2.Quantity))
    FROM Orders o2
    JOIN OrderDetails od2 ON o2.OrderID = od2.OrderID
    JOIN Customers c2 ON o2.CustomerID = c2.CustomerID
    WHERE c2.Country = c.Country
    GROUP BY od2.ProductID
);
