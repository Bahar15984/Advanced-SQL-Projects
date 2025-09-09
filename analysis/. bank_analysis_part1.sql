/* 1) Most recent account_id per customer by create_date */
SELECT a.customer_id, a.account_id
FROM dbo.Account_tbl AS a
WHERE a.create_date = (
    SELECT MAX(create_date)
    FROM dbo.Account_tbl
    WHERE customer_id = a.customer_id
);

/* 2) Total transaction amount per customer */
SELECT customer_id, SUM(amount) AS total_amount
FROM dbo.Txn_tbl
GROUP BY customer_id;

/* 3) Customers with at least one transaction of txn_type_key = 3125 */
SELECT DISTINCT customer_id
FROM dbo.Txn_tbl
WHERE txn_type_key = 3125;

/* 4) Customers with NO transactions of txn_type_key = 3125 */
WITH all_cust AS (SELECT DISTINCT customer_id FROM dbo.Account_tbl),
have_3125 AS (SELECT DISTINCT customer_id FROM dbo.Txn_tbl WHERE txn_type_key = 3125)
SELECT a.customer_id
FROM all_cust a
LEFT JOIN have_3125 h ON a.customer_id = h.customer_id
WHERE h.customer_id IS NULL;

/* 5) Inflow/Outflow/Net per customer */
SELECT customer_id,
       SUM(CASE WHEN amount > 0 THEN amount ELSE 0 END) AS inflow,
       SUM(CASE WHEN amount < 0 THEN -amount ELSE 0 END) AS outflow,
       SUM(amount) AS net_flow
FROM dbo.Txn_tbl
GROUP BY customer_id;
