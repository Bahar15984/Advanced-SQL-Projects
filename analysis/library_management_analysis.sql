/*1. 	Find the titles of all books published by "Bloomsbury.*/
SELECT book_Title
FROM tbl_book
WHERE book_PublisherName = 'Bloomsbury';
-------------------------------------------------------------------------------------------------------------------------------------------------------
/*2.List the names of borrowers whose phone numbers start with the area code "212.*/
SELECT borrower_BorrowerName
FROM tbl_borrower
WHERE borrower_BorrowerPhone LIKE '212%';
-------------------------------------------------------------------------------------------------------------------------------------------------------
/*3 Retrieve the titles of books with more than 10 copies available.*/
SELECT b.book_Title
FROM tbl_book_copies bc
JOIN tbl_book b ON bc.book_copies_BookID = b.book_ID
GROUP BY b.book_Title
HAVING SUM(bc.book_copies_No_Of_Copies) > 10;
--------------------------------------------------------------------------------------------------------------------------------------------------------
/*4. Display the names of borrowers who have borrowed books from the "Central" branch.*/
SELECT DISTINCT br.borrower_BorrowerName
FROM tbl_borrower br
JOIN tbl_book_loans bl ON br.borrower_ID = bl.book_loans_CardNo
JOIN tbl_library_branch lb ON bl.book_loans_BranchID = lb.library_branch_ID
WHERE lb.library_branch_BranchName = 'Central';
----------------------------------------------------------------------------------------------------------------------------------
/*5. List the titles of books borrowed by borrower "Joe Smith.*/
SELECT b.book_Title
FROM tbl_borrower br
JOIN tbl_book_loans bl ON br.borrower_ID = bl.book_loans_CardNo
JOIN tbl_book b ON bl.book_loans_BookID = b.book_ID
WHERE br.borrower_BorrowerName = 'Joe Smith';
----------------------------------------------------------------------------------------------------------------------------------
/*6.Find the names of publishers for the books authored by "J.K. Rowling*/
SELECT DISTINCT b.book_PublisherName
FROM tbl_book_authors ba
JOIN tbl_book b ON ba.book_authors_BookID = b.book_ID
WHERE ba.book_authors_AuthorName = 'J.K. Rowling';
----------------------------------------------------------------------------------------------------------------------------------
/*7.Count the total number of books available in the library.*/
SELECT SUM(book_copies_No_Of_Copies) AS total_books_available
FROM tbl_book_copies;
-----------------------------------------------------------------------------------------------------------------------------------
/*8. Calculate the average number of copies available per book across all branches.*/
SELECT AVG(total_copies) AS avg_copies_per_book
FROM (
    SELECT book_copies_BookID, SUM(book_copies_No_Of_Copies) AS total_copies
    FROM tbl_book_copies
    GROUP BY book_copies_BookID
) AS book_totals;
-------------------------------------------------------------------------------------------------------------------------------------
/*9.Find the branch with the highest number of books loaned out.*/
SELECT TOP 1 lb.library_branch_BranchName, COUNT(*) AS total_loans
FROM tbl_book_loans bl
JOIN tbl_library_branch lb ON bl.book_loans_BranchID = lb.library_branch_ID
GROUP BY lb.library_branch_BranchName
ORDER BY total_loans DESC;
-----------------------------------------------------------------------------------------------------------------------------------
/*10. Insert a new book titled "The Catcher in the Rye" by "J.D. Salinger" into the database.*/
INSERT INTO tbl_book (book_Title, book_PublisherName)
VALUES ('The Catcher in the Rye', 'Unknown Publisher');
-----------------------------------------------------------------------------------------------------------------------------
/*11.Update the address of the "Sharpstown" library branch to "45 West Side Avenue, New York, NY 10012.*/
UPDATE tbl_library_branch
SET library_branch_BranchAddress = '45 West Side Avenue, New York, NY 10012'
WHERE library_branch_BranchName = 'Sharpstown';
------------------------------------------------------------------------------------------------------------------------------
/*12.Remove all books published by "Pan Books" from the database*/

DELETE FROM tbl_book_authors
WHERE book_authors_BookID IN (
    SELECT book_ID FROM tbl_book WHERE book_PublisherName = 'Pan Books'
);


DELETE FROM tbl_book_loans
WHERE book_loans_BookID IN (
    SELECT book_ID FROM tbl_book WHERE book_PublisherName = 'Pan Books'
);


DELETE FROM tbl_book_copies
WHERE book_copies_BookID IN (
    SELECT book_ID FROM tbl_book WHERE book_PublisherName = 'Pan Books'
);
-------------------------------------------------------------------------------------------------------------------------------
/*13. Retrieve the names of borrowers who have borrowed the same book more than once.*/
SELECT DISTINCT br.borrower_BorrowerName
FROM tbl_book_loans bl
JOIN tbl_borrower br ON bl.book_loans_CardNo = br.borrower_ID
JOIN (
    SELECT book_loans_BookID, book_loans_CardNo
    FROM tbl_book_loans
    GROUP BY book_loans_BookID, book_loans_CardNo
    HAVING COUNT(*) > 1
) AS repeated
ON bl.book_loans_BookID = repeated.book_loans_BookID
AND bl.book_loans_CardNo = repeated.book_loans_CardNo;
-------------------------------------------------------------------------------------------------------------------------------
/*14. Find the title of the book with the earliest due date*/
SELECT TOP 1 b.book_Title, bl.book_loans_DueDate
FROM tbl_book_loans bl
JOIN tbl_book b ON bl.book_loans_BookID = b.book_ID
ORDER BY bl.book_loans_DueDate ASC;
-------------------------------------------------------------------------------------------------------------------------------
/*15. List the names of borrowers who have borrowed books authored by both "Stephen King" and "J.K. Rowling.*/
SELECT DISTINCT book_authors_AuthorName
FROM tbl_book_authors
WHERE book_authors_AuthorName LIKE '%King%' OR book_authors_AuthorName LIKE '%Rowling%';
-------------------------------------------------------------------------------------------------------------------------------
/*16. Find the names of borrowers who have borrowed books published by "Bloomsbury*/
SELECT DISTINCT br.borrower_BorrowerName
FROM tbl_borrower br
JOIN tbl_book_loans bl ON br.borrower_ID = bl.book_loans_CardNo
JOIN tbl_book b ON bl.book_loans_BookID = b.book_ID
WHERE b.book_PublisherName = 'Bloomsbury';
----------------------------------------------------------------------------------------------------------------------------------
/*17. Retrieve the titles of books borrowed by borrowers located in New York.*/
SELECT DISTINCT b.book_Title
FROM tbl_borrower br
JOIN tbl_book_loans bl ON br.borrower_ID = bl.book_loans_CardNo
JOIN tbl_book b ON bl.book_loans_BookID = b.book_ID
WHERE br.borrower_BorrowerAddress LIKE '%New York%';
------------------------------------------------------------------------------------------------------------------------------------
/*18. Calculate the average number of books borrowed per borrower.*/
SELECT 
    CAST(COUNT(*) AS FLOAT) / COUNT(DISTINCT book_loans_CardNo) AS avg_books_per_borrower
FROM tbl_book_loans;
------------------------------------------------------------------------------------------------------------------------------------
/*19. Find the branch with the highest average number of books borrowed per borrower.*/
SELECT TOP 1 
    lb.library_branch_BranchName,
    COUNT(*) * 1.0 / COUNT(DISTINCT bl.book_loans_CardNo) AS avg_books_per_borrower
FROM tbl_book_loans bl
JOIN tbl_library_branch lb ON bl.book_loans_BranchID = lb.library_branch_ID
GROUP BY lb.library_branch_BranchName
ORDER BY avg_books_per_borrower DESC;
---------------------------------------------------------------------------------------------------------------------------------------
/*20. Rank library branches based on the total number of books borrowed, without grouping*/
WITH branch_borrow_stats AS (
    SELECT 
        lb.library_branch_ID,
        lb.library_branch_BranchName,
        COUNT(bl.book_loans_ID) AS total_books_borrowed
    FROM tbl_book_loans bl
    JOIN tbl_library_branch lb ON bl.book_loans_BranchID = lb.library_branch_ID
    GROUP BY lb.library_branch_ID, lb.library_branch_BranchName
)

SELECT 
    library_branch_BranchName,
    total_books_borrowed,
    RANK() OVER (ORDER BY total_books_borrowed DESC) AS branch_rank
FROM branch_borrow_stats;
------------------------------------------------------------------------------------------------------------------------------------------
/*21. Calculate the percentage of books borrowed from each branch relative to the total number of books borrowed across all branches.*/
SELECT 
    lb.library_branch_BranchName,
    COUNT(bl.book_loans_ID) AS books_borrowed,
    CAST(COUNT(bl.book_loans_ID) * 100.0 / SUM(COUNT(bl.book_loans_ID)) OVER() AS DECIMAL(5,2)) AS borrow_percentage
FROM tbl_book_loans bl
JOIN tbl_library_branch lb ON bl.book_loans_BranchID = lb.library_branch_ID
GROUP BY lb.library_branch_BranchName;

-------------------------------------------------------------------------------------------------------------------------------------------
/*22. Find the names of borrowers who have borrowed books authored by "Stephen King" and "J.K. Rowling" from the same library branch*/

-- Joe Smith borrows Stephen King + J.K. Rowling from branch 1 (Sharpstown)
INSERT INTO tbl_book_loans (book_loans_BookID, book_loans_BranchID, book_loans_CardNo, book_loans_DateOut, book_loans_DueDate)
VALUES (2, 1, 100, '2024-01-01', '2024-02-01');  -- "It" (Stephen King)

INSERT INTO tbl_book_loans (book_loans_BookID, book_loans_BranchID, book_loans_CardNo, book_loans_DateOut, book_loans_DueDate)
VALUES (8, 1, 100, '2024-01-02', '2024-02-02');  -- "Harry Potter and the Philosopher's Stone" (J.K. Rowling)


-- Jane Smith borrows Stephen King + J.K. Rowling from branch 2 (Central)
INSERT INTO tbl_book_loans (book_loans_BookID, book_loans_BranchID, book_loans_CardNo, book_loans_DateOut, book_loans_DueDate)
VALUES (3, 2, 101, '2024-01-03', '2024-02-03');  -- "The Green Mile" (Stephen King)

INSERT INTO tbl_book_loans (book_loans_BookID, book_loans_BranchID, book_loans_CardNo, book_loans_DateOut, book_loans_DueDate)
VALUES (16, 2, 101, '2024-01-04', '2024-02-04'); -- "Harry Potter and the Chamber of Secrets" (J.K. Rowling)


-- Tom Li borrows Stephen King + J.K. Rowling from branch 3 (Saline)
INSERT INTO tbl_book_loans (book_loans_BookID, book_loans_BranchID, book_loans_CardNo, book_loans_DateOut, book_loans_DueDate)
VALUES (2, 3, 102, '2024-01-05', '2024-02-05');  -- "It" (Stephen King)

INSERT INTO tbl_book_loans (book_loans_BookID, book_loans_BranchID, book_loans_CardNo, book_loans_DateOut, book_loans_DueDate)
VALUES (17, 3, 102, '2024-01-06', '2024-02-06'); -- "Harry Potter and the Prisoner of Azkaban" (J.K. Rowling)



SELECT DISTINCT br.borrower_BorrowerName, lb.library_branch_BranchName
FROM tbl_borrower br
JOIN tbl_book_loans bl1 ON br.borrower_ID = bl1.book_loans_CardNo
JOIN tbl_book_authors ba1 ON bl1.book_loans_BookID = ba1.book_authors_BookID
JOIN tbl_book_loans bl2 ON br.borrower_ID = bl2.book_loans_CardNo
JOIN tbl_book_authors ba2 ON bl2.book_loans_BookID = ba2.book_authors_BookID
JOIN tbl_library_branch lb ON bl1.book_loans_BranchID = lb.library_branch_ID
WHERE ba1.book_authors_AuthorName = 'Stephen King'
  AND ba2.book_authors_AuthorName = 'J.K. Rowling'
  AND bl1.book_loans_BranchID = bl2.book_loans_BranchID;    

-------------------------------------------------------------------------------------------------------------------------------------------------
/*23. Retrieve the names of borrowers who have borrowed books from branches located in New York and have more than 5 books checked out.*/

SELECT br.borrower_BorrowerName
FROM tbl_borrower br
JOIN tbl_book_loans bl ON br.borrower_ID = bl.book_loans_CardNo
JOIN tbl_library_branch lb ON bl.book_loans_BranchID = lb.library_branch_ID
WHERE lb.library_branch_BranchAddress LIKE '%New York%'
GROUP BY br.borrower_ID, br.borrower_BorrowerName
HAVING COUNT(*) > 5;
---------------------------------------------------------------------------------------------------------------------------------------------------
/*24. How many copies of the book titled "The Lost Tribe" are owned by the library branch whose name is "Sharpstown"?*/

SELECT bc.book_copies_No_Of_Copies
FROM tbl_book_copies bc
JOIN tbl_book b ON bc.book_copies_BookID = b.book_ID
JOIN tbl_library_branch lb ON bc.book_copies_BranchID = lb.library_branch_ID
WHERE b.book_Title = 'The Lost Tribe'
  AND lb.library_branch_BranchName = 'Sharpstown';
-----------------------------------------------------------------------------------------------------------------------------------------------------
/*25. How many copies of the book titled "The Lost Tribe" are owned by each library branch?*/
SELECT lb.library_branch_BranchName, bc.book_copies_No_Of_Copies
FROM tbl_book_copies bc
JOIN tbl_book b ON bc.book_copies_BookID = b.book_ID
JOIN tbl_library_branch lb ON bc.book_copies_BranchID = lb.library_branch_ID
WHERE b.book_Title = 'The Lost Tribe';
--------------------------------------------------------------------------------------------------------------------------------------------------------
/*26. Retrieve the names of all borrowers who do not have any books checked out.*/

/*26. Retrieve the names of all borrowers who do not have any books checked out.*/

SELECT br.borrower_BorrowerName
FROM tbl_borrower br
LEFT JOIN tbl_book_loans bl
    ON br.borrower_ID = bl.book_loans_CardNo
WHERE bl.book_loans_ID IS NULL;

--------------------------------------------------------------------------------------------------------------------
/*27. For each book that is loaned out from the "Sharpstown" branch and whose DueDate is today, retrieve the book title, the borrower's name, and the borrower's address. */


UPDATE tbl_book_loans
SET book_loans_DueDate = CAST(GETDATE() AS DATE)
WHERE book_loans_ID = 52;

-------------------------------------------------------------------------------

SELECT 
    b.book_Title,
    br.borrower_BorrowerName,
    br.borrower_BorrowerAddress
FROM tbl_book_loans bl
JOIN tbl_book b ON bl.book_loans_BookID = b.book_ID
JOIN tbl_borrower br ON bl.book_loans_CardNo = br.borrower_ID
JOIN tbl_library_branch lb ON bl.book_loans_BranchID = lb.library_branch_ID
WHERE lb.library_branch_BranchName = 'Sharpstown'
  AND CAST(bl.book_loans_DueDate AS DATE) = CAST(GETDATE() AS DATE);

---------------------------------------------------------------------------------------------------------------------------------------------------------------
/*28. For each library branch, retrieve the branch name and the total number of books loaned out from that branch*/
SELECT 
    lb.library_branch_BranchName,
    COUNT(bl.book_loans_ID) AS total_books_loaned
FROM tbl_library_branch lb
LEFT JOIN tbl_book_loans bl ON lb.library_branch_ID = bl.book_loans_BranchID
GROUP BY lb.library_branch_BranchName;
--------------------------------------------------------------------------------------------------------------