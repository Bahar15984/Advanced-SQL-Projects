/* ===============================
   Bank Analysis 
   =============================== */

/* 1. XYZ_Since_Date: First date of relationship with XYZ */
SELECT Client_ID, MIN(Open_Date) AS XYZ_Since_Date
FROM (
    SELECT Client_ID, Open_Date FROM Activity_checking
    UNION ALL
    SELECT Client_ID, Open_Date FROM Activity_creditcard
) AS combined_dates
GROUP BY Client_ID;

/* 2. Product1_Since_Date: First date customer joined Product1 (checking) */
SELECT Client_ID, MIN(Open_Date) AS Product1_Since_Date
FROM Activity_checking
GROUP BY Client_ID;

/* 3. Product2_Since_Date: First date customer joined Product2 (credit card) */
SELECT Client_ID, MIN(Open_Date) AS Product2_Since_Date
FROM Activity_creditcard
GROUP BY Client_ID;

/* 4. Total_Actives: Total active accounts under each customer */
SELECT Client_ID, COUNT(*) AS Total_Actives
FROM (
    SELECT Client_ID FROM Activity_checking WHERE Status = 'Active'
    UNION ALL
    SELECT Client_ID FROM Activity_creditcard WHERE Credit_Status = 'Active'
) AS active_accounts
GROUP BY Client_ID;

/* 5. Total_Assets: Total assets per customer */
SELECT Client_ID, SUM(Assets) AS Total_Assets
FROM (
    SELECT Client_ID, Assets FROM Activity_checking
    UNION ALL
    SELECT Client_ID, Assets FROM Activity_creditcard
) AS combined_assets
GROUP BY Client_ID;

/* 7. Track XYZ_Since_Date across both datasets */
SELECT Client_ID, MIN(Open_Date) AS XYZ_Since_Date
FROM (
    SELECT Client_ID, Open_Date FROM Activity_checking
    UNION ALL
    SELECT Client_ID, Open_Date FROM Activity_creditcard
) AS combined
GROUP BY Client_ID;

/* 8. Find first date a customer joined Product1 */
SELECT Client_ID, MIN(Open_Date) AS Product1_Since_Date
FROM Activity_checking
GROUP BY Client_ID;

/* 9. Total active accounts across both datasets */
SELECT Client_ID, COUNT(*) AS Total_Actives
FROM (
    SELECT Client_ID FROM Activity_checking WHERE Status = 'Active'
    UNION ALL
    SELECT Client_ID FROM Activity_creditcard WHERE Credit_Status = 'Active'
) AS active_accounts
GROUP BY Client_ID;

/* 10. Calculate total assets (positive + negative) */
SELECT Client_ID, SUM(Assets) AS Total_Assets
FROM (
    SELECT Client_ID, Assets FROM Activity_checking
    UNION ALL
    SELECT Client_ID, Assets FROM Activity_creditcard
) AS combined_assets
GROUP BY Client_ID;
