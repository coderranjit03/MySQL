
-- Create sample table
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    salary DECIMAL(10,2),
    department VARCHAR(50),
    manager_id INT
);

-- Insert sample data
INSERT INTO employees VALUES
(1, 'Alice', 70000, 'HR', NULL),
(2, 'Bob', 60000, 'IT', 1),
(3, 'Charlie', 50000, 'IT', 2),
(4, 'David', 55000, 'Finance', 1),
(5, 'Eve', 75000, 'Finance', NULL);

------------------------------------------------
-- Example 1: Basic CTE
WITH HighSalaryEmployees AS (
    SELECT emp_id, name, salary
    FROM employees
    WHERE salary > 50000
)
SELECT * FROM HighSalaryEmployees;

------------------------------------------------
-- Example 2: Aggregation with CTE
WITH DeptSalary AS (
    SELECT department, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department
)
SELECT department, avg_salary
FROM DeptSalary
WHERE avg_salary > 60000;

------------------------------------------------
-- Example 3: Recursive CTE
WITH RECURSIVE EmployeeHierarchy AS (
    SELECT emp_id, name, manager_id, 1 AS level
    FROM employees
    WHERE manager_id IS NULL
    
    UNION ALL
    
    SELECT e.emp_id, e.name, e.manager_id, eh.level + 1
    FROM employees e
    INNER JOIN EmployeeHierarchy eh
    ON e.manager_id = eh.emp_id
)
SELECT * FROM EmployeeHierarchy;
