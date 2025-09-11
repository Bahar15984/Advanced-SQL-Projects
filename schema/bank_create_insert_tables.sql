/* Bank Analysis – Create Tables */

CREATE TABLE Activity_checking (
    Client_ID INT,
    Account_ID INT,
    Open_Date DATE,
    Assets INT,
    Status VARCHAR(10)
);

/* Insert sample data into Activity_checking */
INSERT INTO Activity_checking VALUES
(1001, 20032, '2019-11-02', 7744, 'Active'),
(1002, 20056, '2020-12-12', -12451, 'Inactive'),
(1003, 20032, '2019-01-12', 1274, 'Active'),
(1003, 20074, '2019-01-19', 7683, 'Active'),
(1002, 20793, '2017-09-17', -591, 'Active'),
(1004, 20142, '2017-02-16', 14144, 'Active'),
(1005, 21943, '2016-10-24', 13981, 'Active'),
(1006, 29371, '2008-06-09', 14049, 'Inactive'),
(1002, 29081, '2018-04-05', 2092, 'Active');
-------------------------------------------------------------------------------------
CREATE TABLE Activity_creditcard (
    Client_ID INT,
    Account_ID INT,
    Open_Date DATE,
    Credit_Status VARCHAR(10),
    Assets INT
);

/* Insert sample data into Activity_creditcard */
INSERT INTO Activity_creditcard VALUES
(1003, 313058, '2015-12-17', 'Active', -4059),
(1004, 339524, '2019-01-16', 'Active', -4327),
(1002, 330572, '2019-09-26', 'Active', 15392),
(1003, 396821, '2020-02-07', 'Inactive', -1359),
(1004, 375271, '2018-03-15', 'Active', -1601),
(1003, 373859, '2020-09-09', 'Active', 16515),
(1006, 383733, '2017-11-08', 'Inactive', 5226),
(1006, 353413, '2018-03-16', 'Inactive', 13741),
(1005, 365605, '2017-06-25', 'Active', -4110);
