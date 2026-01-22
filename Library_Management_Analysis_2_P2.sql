
SELECT * FROM books;
SELECT * FROM branch;
SELECT * FROM employees;
SELECT * FROM members;
SELECT * FROM issued_status;
SELECT * FROM return_status;



-- Advanced Project Task

/*
Task 13: 
Identify Members with Overdue Books
Write a query to identify members who have overdue books (assume a 30-day return period). 
Display the member's_id, member's name, book title, issue date, and days overdue.
*/

-- issued_status == members == books == return_status
-- filter books which is return
-- overdue > 30 


SELECT CURRENT_DATE


SELECT 
    ist.issued_member_id,
	m.member_name,
	bk.book_title,
	ist.issued_date ,
    CURRENT_DATE - ist.issued_date as over_dues_days
FROM issued_status AS ist
JOIN members as m 
ON m.member_id = ist.issued_member_id
JOIN books as bk
ON bk.isbn = ist.issued_book_isbn
WHERE 
     (CURRENT_DATE - ist.issued_date) > 30
ORDER BY 1


/*
Task 14: Branch Performance Report
Create a query that generates a performance report for each branch, showing the number of books issued, 
the number of books returned, and the total revenue generated from book rentals.
*/

CREATE TABLE branch_report
AS
select
     b.branch_id,
	 b.manager_id,
	 count(ist.issued_id) AS no_book_issued,
	 SUM(bk.rental_price) AS Total_revenue
FROM issued_status as ist
JOIN employees as e 
ON e.emp_id = ist.issued_emp_id
JOIN branch as b 
ON b.branch_id = e.branch_id
JOIN books as bk
ON bk.isbn = ist.issued_book_isbn
GROUP BY 1,2;


/*
Task 15: CTAS: Create a Table of Active Members
Use the CREATE TABLE AS (CTAS) statement to create a new table active_members containing 
members who have issued at least one book in the last 2 months.
*/

SELECT * FROM members
WHERE member_id IN (SELECT 
                         DISTINCT issued_member_id
                     FROM issued_status 
                     WHERE 
                          issued_date >= CURRENT_DATE - INTERVAL '2 month'
                   )


/*
Task 16: Find Employees with the Most Book Issues Processed
Write a query to find the top 3 employees who have processed the most book issues. 
Display the employee name, number of books processed, and their branch.
*/

SELECT 
      e.emp_name,
	  br.*,
	  COUNT(ist.issued_id) AS no_book_issued
FROM employees AS e 
JOIN issued_status AS ist 
ON ist.issued_emp_id = e.emp_id
JOIN branch as br
ON br.branch_id = e.branch_id
GROUP BY 1,2 
ORDER BY 3 DESC




                                               --END--














