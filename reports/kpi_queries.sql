/* KPI: active customers (placed >=1 order in last 12 months) */
SELECT COUNT(DISTINCT o.CustomerID) AS active_customers_12m
FROM dbo.Orders o
WHERE o.OrderDate >= DATEADD(MONTH, -12, CAST(GETDATE() AS DATE));

/* KPI: average order quantity */
SELECT AVG(od.Quantity*1.0) AS avg_items_per_order
FROM dbo.OrderDetails od;

/* KPI: top products by quantity sold */
SELECT TOP 5 p.ProductID, p.ProductName, SUM(od.Quantity) AS qty_sold
FROM dbo.OrderDetails od
JOIN dbo.Products p ON p.ProductID = od.ProductID
GROUP BY p.ProductID, p.ProductName
ORDER BY qty_sold DESC;



SELECT * 
FROM sys.tables
WHERE name = 'OrderDetails';
