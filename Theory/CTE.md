
# 📘 Common Table Expressions (CTE) in SQL

## 🔹 What is a CTE?
A **Common Table Expression (CTE)** is a **temporary result set** defined within the execution of a single query.  
It improves readability, makes queries modular, and is useful for recursive operations.

Think of it as a **named temporary view** that only exists during the query execution.

---

## 🔹 Syntax
```sql
WITH cte_name (column1, column2, ...)
AS (
    -- SQL query that defines the CTE
    SELECT ...
)
-- Use the CTE in the main query
SELECT *
FROM cte_name;
````

* `WITH` → defines the CTE.
* `cte_name` → name of the temporary result set.
* `(column1, column2, …)` → optional column aliases.
* Must be followed by a **main query**.

---

## 🔹 Example 1: Basic CTE

Find employees with salary greater than 50,000.

```sql
WITH HighSalaryEmployees AS (
    SELECT emp_id, name, salary
    FROM employees
    WHERE salary > 50000
)
SELECT *
FROM HighSalaryEmployees;
```

---

## 🔹 Example 2: CTE with Aggregation

Find departments with average salary greater than 60,000.

```sql
WITH DeptSalary AS (
    SELECT department, AVG(salary) AS avg_salary
    FROM employees
    GROUP BY department
)
SELECT department, avg_salary
FROM DeptSalary
WHERE avg_salary > 60000;
```

---

## 🔹 Example 3: Recursive CTE

Build a hierarchy of employees.

```sql
WITH RECURSIVE EmployeeHierarchy AS (
    -- Base case: top managers
    SELECT emp_id, name, manager_id, 1 AS level
    FROM employees
    WHERE manager_id IS NULL
    
    UNION ALL
    
    -- Recursive step: employees reporting to managers
    SELECT e.emp_id, e.name, e.manager_id, eh.level + 1
    FROM employees e
    INNER JOIN EmployeeHierarchy eh
    ON e.manager_id = eh.emp_id
)
SELECT *
FROM EmployeeHierarchy;
```

---

## ✅ Advantages

* Improves readability of complex queries
* Can be reused multiple times in one query
* Allows **recursive queries** (hierarchies, trees)
* Breaks down complex logic step by step

---

## ⚠️ Limitations

* Exists only for the duration of the query
* Not always efficient for huge datasets
* Recursive CTEs may be slow if not optimized

---

📌 **In short:**
CTE = **temporary, named query result** that makes SQL queries **clean, reusable, and recursive-friendly**.

