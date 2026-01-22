# Library Management System – SQL Analytics Project
## Overview

This project implements a relational Library Management System and applies SQL analytics to evaluate library operations, 
member behavior, inventory utilization, and fine compliance.
The objective is to demonstrate how transactional data can be structured and queried to generate operational and 
management-level insights, similar to real-world analytics systems used in organizations.
## Business Problem

Libraries generate continuous transactional data but often lack analytical visibility into:

- Which books are actually used.

- How members behave over time.

- Where operational bottlenecks exist.

- How much revenue is lost or gained through fines.

- Whether inventory investments are justified.

- Without structured analysis, decisions are made intuitively rather than data-driven.

## Solution

This project addresses the problem by:

1. Designing a normalized relational database (3NF)

2. Capturing book, member, issue, return, and fine data

3. Writing SQL queries that translate operations into metrics

4. Producing insights that support operational control and planning 

##  Database Design
The schema is designed to ensure data integrity, scalability, and query efficiency.

### Core Tables

- books
- members
- issue_records
- return_records
- fines

Each table represents a core business entity found in real library systems. 
![image](https://github.com/kovidanand/SQL-Library_Management_Analysis_P2/blob/main/ERD.pgerd)

## Analytical Use Cases with Queries
### 1. Book Inventory Utilization

Business Question
Which books are most frequently issued?

Query
```sql
SELECT 
    b.book_id,
    b.book_name,
    COUNT(i.issue_id) AS total_issues
FROM books b
JOIN issue_records i 
    ON b.book_id = i.book_id
GROUP BY b.book_id, b.book_name
ORDER BY total_issues DESC;
```

**Impact**

- Identifies high-demand books
 
- Supports procurement and stocking decisions

- Prevents over-investment in unused inventory


### 2. Category-Level Demand Analysis

Business Question
Which book categories have the highest demand?

Query
```sql
SELECT 
    b.category,
    COUNT(i.issue_id) AS issue_count
FROM books b
JOIN issue_records i 
    ON b.book_id = i.book_id
GROUP BY b.category
ORDER BY issue_count DESC;
```

**Impact**

- Guides category-wise budget allocation

- Improves availability for popular genres

### 3. Member Activity Analysis

Business Question
Who are the most active library members?

Query
```sql
SELECT 
    m.member_id,
    m.member_name,
    COUNT(i.issue_id) AS books_issued
FROM members m
JOIN issue_records i 
    ON m.member_id = i.member_id
GROUP BY m.member_id, m.member_name
ORDER BY books_issued DESC;
```

**Impact**

- Identifies highly engaged users

- Enables member segmentation and engagement strategies

### 4. Overdue Book Identification

Business Question
Which issued books were returned late?

Query
```sql
SELECT 
    i.issue_id,
    i.book_id,
    i.member_id,
    r.return_date,
    i.due_date,
    (r.return_date - i.due_date) AS delay_days
FROM issue_records i
JOIN return_records r 
    ON i.issue_id = r.issue_id
WHERE r.return_date > i.due_date;
```

**Impact**

- Improves compliance monitoring

- Reduces book unavailability caused by delays


### 5. Fine Revenue Analysis

Business Question
How much fine revenue is generated due to late returns?

Query
```sql 
SELECT 
    SUM(f.fine_amount) AS total_fine_revenue
FROM fines f;
```

**Impact**

- Ensures financial transparency

- Helps evaluate fine policies

### 6. Average Return Delay

Business Question
What is the average delay in book returns?

Query
```sql
SELECT 
    AVG(r.return_date - i.due_date) AS avg_delay_days
FROM issue_records i
JOIN return_records r 
    ON i.issue_id = r.issue_id
WHERE r.return_date > i.due_date;
```

**Impact**

- Measures operational discipline

- Supports policy optimization

## SQL Skills Demonstrated

- Relational joins (INNER, LEFT)

- Aggregation and KPIs

- Date arithmetic

- Filtering based on business rules

- Structured and readable query writing

## Business Value Delivered

- Converts raw transactions into insights

- Improves inventory utilization

- Enhances compliance and turnaround time

- Supports data-driven decision-making

- Establishes a foundation for BI dashboards

## Future Enhancements

- Power BI / Tableau dashboards

- Python-based automation

- Stored procedures and triggers

- Predictive demand forecasting





























