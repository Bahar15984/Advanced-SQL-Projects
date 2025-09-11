/* Transaction & Account Management Analysis */

/* 1. Most recent account per customer */
SELECT customer_id, account_id
FROM Account_tbl a
WHERE create_date = (
    SELECT MAX(create_date)
    FROM Account_tbl
    WHERE customer_id = a.customer_id
);

/* 2. Join Txn_tbl with most recent account */
WITH MostRecentAccount AS (
    SELECT 
        customer_id, 
        account_id, 
        create_date,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY create_date DESC) AS rn
    FROM Account_tbl
)
SELECT 
    t.customer_id,
    t.txn_id,
    t.Txn_type_key,
    t.amount,
    a.account_id AS most_recent_account_id,
    a.create_date AS account_create_date
FROM Txn_tbl t
LEFT JOIN MostRecentAccount a
    ON t.customer_id = a.customer_id
WHERE a.rn = 1;

/* 3. Total transaction amount + most recent account */
WITH MostRecentAccount AS (
    SELECT 
        customer_id,
        account_id,
        create_date,
        ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY create_date DESC) AS rn
    FROM Account_tbl
),
TotalTxn AS (
    SELECT 
        customer_id,
        SUM(amount) AS total_transaction_amount
    FROM Txn_tbl
    GROUP BY customer_id
)
SELECT 
    t.customer_id,
    t.total_transaction_amount,
    a.account_id AS most_recent_account_id,
    a.create_date AS account_create_date
FROM TotalTxn t
LEFT JOIN MostRecentAccount a
    ON t.customer_id = a.customer_id
WHERE a.rn = 1;

/* 4. Customers with no account record */
SELECT 
    t.customer_id,
    t.txn_id,
    t.Txn_type_key,
    t.amount,
    a.account_id,
    a.create_date
FROM Txn_tbl t
LEFT JOIN Account_tbl a
    ON t.customer_id = a.customer_id;

/* 5. Credit vs Debit Transactions */
SELECT 
    customer_id,
    COUNT(CASE WHEN txn_type_key IN (3125, 3124, 3600, 4500, 6577, 8900) THEN 1 END) AS credit_txn_count,
    SUM(CASE WHEN txn_type_key IN (3125, 3124, 3600, 4500, 6577, 8900) THEN amount ELSE 0 END) AS credit_txn_amount,
    COUNT(CASE WHEN txn_type_key IN (3546, 3543, 14, 1600, 8700, 8888) THEN 1 END) AS debit_txn_count,
    SUM(CASE WHEN txn_type_key IN (3546, 3543, 14, 1600, 8700, 8888) THEN amount ELSE 0 END) AS debit_txn_amount
FROM Txn_tbl
GROUP BY customer_id;
