SELECT * FROM books;
SELECT * FROM branch;
SELECT * FROM employees;
SELECT * FROM members;
SELECT * FROM issued_status;
SELECT * FROM return_status;




-- Project Task

-- Task 1. 
-- Create a New Book Record -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 
-- 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

INSERT INTO books (isbn, book_title, category, rental_price, status, author,publisher)
VALUES
('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')


-- Task 2: Update an Existing Member's Address


UPDATE members
SET member_address = '469 Elm St'
WHERE member_id = 'C102';


-- Task 3: Delete a Record from the Issued Status Table 
-- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.

DELETE FROM issued_status
WHERE issued_id = 'IS121'


-- Task 4: Retrieve All Books Issued by a Specific Employee 
-- Objective: Select all books issued by the employee with emp_id = 'E101'.


SELECT 
     book_title,
	 isbn
FROM books as bo
JOIN issued_status as ist
ON bo.isbn = ist.issued_book_isbn
WHERE 
   issued_emp_id = 'E101'



-- Task 5: List Members Who Have Issued More Than One Book 
-- Objective: Use GROUP BY to find members who have issued more than one book.


SELECT 
    issued_member_id,
	member_name,
	COUNT(issued_book_isbn) AS Total_book_issued
FROM members AS m
JOIN issued_status as ist
ON m.member_id = ist.issued_member_id
GROUP BY 1,2
HAVING COUNT(issued_id) > 1


-- CTAS
-- Task 6: Create Summary Tables: 
--Used CTAS to generate new tables based on query results - each book and total book_issued_cnt**


CREATE TABLE book_cunt
AS
SELECT 
    bo.isbn,
	bo.book_title,
	COUNT(ist.issued_id) as no_issued
FROM books as bo
JOIN issued_status as ist
ON bo.isbn = ist.issued_book_isbn
GROUP BY 1,2;



-- Task 7. Retrieve All Books in a Specific Category:

SELECT * FROM books
WHERE category = 'Classic'


-- Task 8: Find Total Rental Income by Category:


SELECT 
     bo.category,
     SUM(bo.rental_price) AS rental_income
FROM books AS bo
GROUP BY 1


-- Task 9: List Employees with Their Branch Manager's Name and their branch details:

SELECT
     e1.*,
	 br.manager_id,
	 br.branch_address,
	 e2.emp_name AS manager
FROM employees as e1
JOIN branch as br
ON br.branch_id  = e1.branch_id
JOIN employees as e2
ON e2.emp_id = br.manager_id


-- Task 10. Create a Table of Books with Rental Price Above a Certain Threshold 7USD:

CREATE TABLE high_rental 
AS
SELECT * FROM books
WHERE rental_price > '7'


                                                 --END--











