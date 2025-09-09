-- 📘 views.sql - Practice queries for SQL Views

-- 1️⃣ Create Employees table
CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10,2)
);

-- 2️⃣ Insert sample data
INSERT INTO Employees VALUES
(1, 'Alice', 'HR', 50000),
(2, 'Bob', 'Finance', 60000),
(3, 'Charlie', 'IT', 70000),
(4, 'David', 'Finance', 65000),
(5, 'Eve', 'IT', 75000);

-------------------------------------------------
-- 🔹 Example 1: Simple View
-------------------------------------------------
-- Create a view to show Finance employees only
CREATE VIEW FinanceEmployees AS
SELECT name, salary
FROM Employees
WHERE department = 'Finance';

-- Query the view
SELECT * FROM FinanceEmployees;

-------------------------------------------------
-- 🔹 Example 2: Aggregated View
-------------------------------------------------
-- Create a view to show average salary by department
CREATE VIEW DepartmentAvgSalary AS
SELECT department, AVG(salary) AS avg_salary
FROM Employees
GROUP BY department;

-- Query the view
SELECT * FROM DepartmentAvgSalary;

-------------------------------------------------
-- 🔹 Example 3: Replace (Modify) a View
-------------------------------------------------
-- Create or replace a view to show high earners (salary > 65000)
CREATE OR REPLACE VIEW HighEarners AS
SELECT name, salary
FROM Employees
WHERE salary > 65000;

-- Query the view
SELECT * FROM HighEarners;

-------------------------------------------------
-- 🔹 Example 4: Update Data Through a View
-------------------------------------------------
-- Update salary of Bob using the FinanceEmployees view
UPDATE FinanceEmployees
SET salary = 70000
WHERE name = 'Bob';

-- Verify the update in main table
SELECT * FROM Employees;

-------------------------------------------------
-- 🔹 Example 5: Drop a View
-------------------------------------------------
-- Drop the HighEarners view
DROP VIEW HighEarners;

-------------------------------------------------
-- ✅ Notes:
-- 1. Simple views (single table, no aggregates) are updatable.
-- 2. Complex views (with GROUP BY, joins, or aggregates) are read-only.
-- 3. CREATE OR REPLACE VIEW updates the definition if it already exists.
