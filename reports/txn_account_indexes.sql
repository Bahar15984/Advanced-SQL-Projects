/* Suggest an indexing strategy to optimize the query performance when joining the
Txn_tbl and Account_tbl.*/

/*To optimize the performance of joins between Txn_tbl and Account_tbl, you should create indexes on the columns that are:

- Used in the JOIN condition, and
- Frequently filtered or used in WHERE/GROUP BY clauses.*/

/*Recommended Indexing Strategy:

1. Create an index on Txn_tbl.customer_id
   This column is used to join with Account_tbl, and likely used in WHERE conditions as well.
*/
CREATE INDEX idx_txn_customer_id ON Txn_tbl(customer_id);

/*2. Create an index on Account_tbl.customer_id
   This complements the join from Txn_tbl and speeds up the lookup.
*/

/*3. Optional: Composite Index on Account_tbl if filtering by date
   If queries often filter or sort by create_date, a composite index helps.
*/
CREATE INDEX idx_account_customer_date ON Account_tbl(customer_id, create_date DESC);

/*Notes:
- Indexes improve read/query performance, but may slightly slow down inserts/updates.
- Periodically check and rebuild indexes if tables grow large.
- Use SQL Server’s Query Analyzer (Execution Plan) to assess performance.
*/

/*Index creation with existence check:*/

-- 1. Index on Txn_tbl.customer_id
IF NOT EXISTS (
    SELECT * FROM sys.indexes 
    WHERE name = 'idx_txn_customer_id' AND object_id = OBJECT_ID('Txn_tbl')
)
BEGIN
    CREATE INDEX idx_txn_customer_id ON Txn_tbl(customer_id);
END;

-- 2. Index on Account_tbl.customer_id
IF NOT EXISTS (
    SELECT * FROM sys.indexes 
    WHERE name = 'idx_account_customer_id' AND object_id = OBJECT_ID('Account_tbl')
)
BEGIN
    CREATE INDEX idx_account_customer_id ON Account_tbl(customer_id);
END;

-- 3. Composite index on Account_tbl(customer_id, create_date)
IF NOT EXISTS (
    SELECT * FROM sys.indexes 
    WHERE name = 'idx_account_customer_date' AND object_id = OBJECT_ID('Account_tbl')
)
BEGIN
    CREATE INDEX idx_account_customer_date ON Account_tbl(customer_id, create_date DESC);
END;

/*Drop indexes (if you need to change or rename them):*/
DROP INDEX idx_txn_customer_id ON Txn_tbl;
DROP INDEX idx_account_customer_id ON Account_tbl;
DROP INDEX idx_account_customer_date ON Account_tbl;
