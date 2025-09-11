/* 1. What is the difference between Primary Key (PK) and Foreign Key (FK)?

Primary Key:

A column (or combination of columns) that uniquely identifies each row in a table.

Cannot contain NULL values.

Each table can have only one Primary Key.

Foreign Key:

A column that establishes a relationship between two tables by referring to the Primary Key in another table.

Can contain duplicate values and NULLs.

Used to enforce referential integrity.*/

*************************************************************************************************************

/* 2. What is the difference between a View, a Table, and a Temporary Table?
A table is a database object that permanently stores data in rows and columns. It exists in the database until it's explicitly deleted.

A view is a virtual table based on a SQL query. It does not store data physically; instead, it provides a saved query that can be reused like a table. The underlying data is pulled from base tables whenever the view is queried.

A temporary table is like a regular table but exists only for the duration of the session or transaction that created it. Once the session ends, the temporary table and its data are automatically deleted. It's useful for intermediate processing or staging data during complex queries.

*/
**************************************************************************************************************
 /*3. What is the difference between Clustered and Non-clustered Indexes?
 Clustered Index:

Sorts and stores the actual data rows of the table based on the index key.

Only one clustered index is allowed per table because the data rows themselves are stored in order.

Non-clustered Index:

Contains a separate structure from the data rows with pointers to the actual data.

Allows multiple non-clustered indexes per table.

Ideal for improving query performance on columns that are frequently searched but not part of the primary ordering.*/

**********************************************************************************************************************
/* 4. What is the difference between Stored Procedures and Functions?
Stored Procedures:

Can perform complex operations including multiple SQL statements (INSERT, UPDATE, DELETE).

May or may not return a value.

Cannot be used in SELECT statements.

Support exception handling (TRY-CATCH).

Functions:

Must return a single value or a table.

Can be used inside SELECT, WHERE, and JOIN clauses.

Cannot modify database state (no INSERT, UPDATE, DELETE).

No TRY-CATCH exception handling support.*/

***********************************************************************************************************************
/* 5. What is the ACID property in a database?
ACID stands for:

Atomicity – Ensures that all operations in a transaction are completed; if not, the transaction is aborted.

Consistency – Guarantees that a transaction brings the database from one valid state to another.

Isolation – Ensures that transactions are executed independently without interference.

Durability – Once a transaction is committed, it remains so, even in the case of a system failure.*/

************************************************************************************************
/*6. How would you optimize your SQL queries to handle large datasets efficiently?*/
--Use indexes on Client_ID, Open_Date, Status, and Credit_Status.

--Avoid SELECT *; always specify required columns.

--Use CTEs or temporary tables for repeated subqueries.

--Use indexed views if the report is frequently used.*/
*************************************************************************************************
/*7.  What methods can you use to handle missing data or inconsistencies when
generating reports from these datasets?
*Use LEFT JOIN to retain clients with missing values in one product.

*Use ISNULL() or COALESCE() to replace NULLs with default values.

*Validate and clean data before analysis (e.g., negative balances, invalid dates).*/
***************************************************************************************************
/*8. Describe how you can join multiple tables in SQL to create a consolidated report
for customer metrics.


"Use LEFT JOINs on Client_ID to merge subqueries such as:

XYZ_Since_Date

Product1_Since_Date

Product2_Since_Date

Total_Actives

Total_Assets*/
*******************************************************************************
/*9. What indexing strategies would you recommend to improve query performance in
this scenario?

"Index on Client_ID (used in JOIN, GROUP BY)

Index on Open_Date (for MIN() and range queries)

Composite index on (Client_ID, Status) for filtering active accounts

Covering index for reporting views"
*/
**********************************************************************************
/*10. How can SQL aggregate functions like SUM, MIN, and COUNT help in
calculating the required KPIs?

"SUM(Assets) gives total financial exposure per client.

MIN(Open_Date) tracks customer start date per product.

COUNT(*) counts how many active accounts a client has.

These functions are essential in building KPI summaries by reducing rows and aggregating numerical data across groups.

"*/