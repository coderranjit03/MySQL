

-- ============================================
-- Window Functions Practice in MySQL
-- ============================================

-- Create database
CREATE DATABASE IF NOT EXISTS company_db;
USE company_db;

-- Create employees table
CREATE TABLE IF NOT EXISTS employees (
    emp_id INT PRIMARY KEY,
    employee_name VARCHAR(50),
    department VARCHAR(50),
    salary INT
);

-- Insert sample data
INSERT INTO employees VALUES
(1, 'Alice', 'HR', 4000),
(2, 'Bob', 'HR', 4500),
(3, 'Charlie', 'HR', 4500),
(4, 'David', 'IT', 6000),
(5, 'Eva', 'IT', 7000),
(6, 'Frank', 'IT', 6500),
(7, 'Grace', 'Finance', 5000),
(8, 'Helen', 'Finance', 5200);

-- ============================================
-- 1. Aggregate Window Functions
-- ============================================
SELECT 
    department,
    employee_name,
    salary,
    SUM(salary) OVER (PARTITION BY department) AS dept_total,
    AVG(salary) OVER (PARTITION BY department) AS dept_avg
FROM employees;

-- ============================================
-- 2. Ranking Functions
-- ============================================
SELECT 
    employee_name,
    department,
    salary,
    ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) AS row_num,
    RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rank_num,
    DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS dense_rank,
    NTILE(3) OVER (ORDER BY salary DESC) AS quartile
FROM employees;

-- ============================================
-- 3. Value Functions
-- ============================================
SELECT 
    employee_name,
    salary,
    LAG(salary, 1) OVER (ORDER BY salary) AS prev_salary,
    LEAD(salary, 1) OVER (ORDER BY salary) AS next_salary,
    FIRST_VALUE(salary) OVER (PARTITION BY department ORDER BY salary) AS min_salary,
    LAST_VALUE(salary) OVER (PARTITION BY department ORDER BY salary 
        RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS max_salary
FROM employees;

-- ============================================
-- 4. Cumulative & Moving Aggregates
-- ============================================
-- Running Total
SELECT 
    employee_name,
    salary,
    SUM(salary) OVER (ORDER BY emp_id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
FROM employees;

-- Moving Average (last 3 rows)
SELECT 
    employee_name,
    salary,
    AVG(salary) OVER (ORDER BY emp_id ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_avg
FROM employees;
