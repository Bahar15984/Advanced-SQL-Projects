/* ===============================================
   Shopify SQL Interview Questions
   =============================================== */

/* Q1: How many orders were shipped by Speedy Express in total? */
SELECT COUNT(*) AS TotalOrders
FROM Orders o
JOIN Shippers s ON o.ShipperID = s.ShipperID
WHERE s.CompanyName = 'Speedy Express';


/* Q2: What is the last name of the employee with the most orders? */
SELECT TOP 1 e.LastName, COUNT(*) AS OrderCount
FROM Orders o
JOIN Employees e ON o.EmployeeID = e.EmployeeID
GROUP BY e.LastName
ORDER BY COUNT(*) DESC;

/* Q3: What product was ordered the most by customers in Germany? */
SELECT TOP 1 p.ProductName, SUM(od.Quantity) AS TotalQuantity
FROM Customers c
JOIN Orders o ON c.CustomerID = o.CustomerID
JOIN OrderDetails od ON o.OrderID = od.OrderID
JOIN Products p ON od.ProductID = p.ProductID
WHERE c.Country = 'Germany'
GROUP BY p.ProductName
ORDER BY SUM(od.Quantity) DESC;
