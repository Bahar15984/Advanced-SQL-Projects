/* POS sanity checks */
SELECT TOP 10 * FROM dbo.POS1 ORDER BY [date];
SELECT TOP 10 * FROM dbo.POS2 ORDER BY [date];
SELECT TOP 10 * FROM dbo.POS3 ORDER BY [date];
SELECT TOP 10 * FROM dbo.Sales_Summary ORDER BY [date];

/* Total sales per product */
SELECT s.product, SUM(s.sales) AS total_sales
FROM dbo.Sales_Summary s
GROUP BY s.product
ORDER BY total_sales DESC;

/* Monthly sales trend */
SELECT DATEFROMPARTS(YEAR([date]), MONTH([date]), 1) AS month_start,
       SUM(sales) AS month_sales
FROM dbo.Sales_Summary
GROUP BY DATEFROMPARTS(YEAR([date]), MONTH([date]), 1)
ORDER BY month_start;

/* Top 5 selling days per product */
SELECT product, [date], sales
FROM (
    SELECT product, [date], sales,
           ROW_NUMBER() OVER (PARTITION BY product ORDER BY sales DESC) AS rn
    FROM dbo.Sales_Summary
) t
WHERE rn <= 5;

