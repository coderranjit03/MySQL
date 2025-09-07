
---

# 1. `CREATE`, `ALTER`, `DROP` (DDL)

### `CREATE TABLE`

Creates a new table and its columns, datatypes and constraints.

```sql
CREATE TABLE Departments (
  dept_id INT PRIMARY KEY,
  dept_name VARCHAR(100) NOT NULL
);

CREATE TABLE Employees (
  emp_id INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  dept_id INT,
  salary DECIMAL(10,2) DEFAULT 0.00,
  manager_id INT,
  hired_on DATE,
  is_active BOOLEAN DEFAULT TRUE,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);
```

**Notes**

* Define primary keys, foreign keys, NOT NULL, DEFAULT etc.
* Use `IF NOT EXISTS` in many RDBMS to avoid error if table exists:
  `CREATE TABLE IF NOT EXISTS Employees (...)`.

---

### `ALTER TABLE`

Modify existing table structure: add/drop/modify columns, add constraints.

```sql
-- Add a column
ALTER TABLE Employees ADD COLUMN phone VARCHAR(20);

-- Modify column datatype (MySQL syntax)
ALTER TABLE Employees MODIFY salary DECIMAL(12,2);

-- Rename column (Postgres/MySQL variants; MySQL: CHANGE)
-- MySQL:
ALTER TABLE Employees CHANGE phone phone_number VARCHAR(30);
-- Postgres:
ALTER TABLE Employees RENAME COLUMN phone TO phone_number;

-- Drop a column
ALTER TABLE Employees DROP COLUMN phone_number;
```

**Notes**

* Syntax differs slightly across DBs (MySQL vs Postgres vs Oracle).
* Some changes require copying table internally — be cautious on big tables.

---

### `DROP TABLE`

Removes table and its data/metadata.

```sql
DROP TABLE IF EXISTS Employees;
```

**Warning**: `DROP` permanently deletes data unless you have backups. `TRUNCATE TABLE` removes all rows but keeps structure (usually faster); `TRUNCATE` is DDL and often auto-committed.

---

# 2. `INSERT INTO` (DML)

### Insert single row

```sql
INSERT INTO Employees (name, dept_id, salary, hired_on)
VALUES ('Anita Sharma', 2, 45000.00, '2024-04-01');
```

### Insert multiple rows

```sql
INSERT INTO Departments (dept_id, dept_name)
VALUES (1, 'Sales'), (2, 'Engineering'), (3, 'HR');
```

### Insert from `SELECT` (copying rows)

```sql
-- Archive old employees into another table
INSERT INTO Employees_Archive (emp_id, name, dept_id, salary, hired_on)
SELECT emp_id, name, dept_id, salary, hired_on
FROM Employees
WHERE hired_on < '2015-01-01';
```

**Notes**

* If you omit column list, SQL expects values for *every* column in the table order — usually better to list columns explicitly.
* `INSERT` is DML — it is subject to transactions (`COMMIT`/`ROLLBACK`) unless DB auto-commits.

---

# 3. `SELECT ... FROM` (basic data retrieval)

### Basic select

```sql
SELECT * FROM Employees;
SELECT name, salary FROM Employees WHERE is_active = TRUE;
```

### Aliases, distinct, order, limit

```sql
SELECT e.name AS employee_name, d.dept_name
FROM Employees e
JOIN Departments d ON e.dept_id = d.dept_id
ORDER BY salary DESC
LIMIT 10;    -- MySQL/Postgres (SQL Server uses TOP, Oracle uses FETCH FIRST)
```

**Best practice**: avoid `SELECT *` in production — list required columns.

---

# 4. `WHERE` clause — filtering

The `WHERE` clause filters rows using comparison and logical operators. Structure:

```sql
SELECT columns
FROM table
WHERE condition1 AND (condition2 OR condition3);
```

**Example**

```sql
SELECT name, salary
FROM Employees
WHERE dept_id = 2
  AND salary > 40000
  AND is_active = TRUE;
```

---

# 5. Comparison Operators

Standard comparison operators:

* `=` equal
* `<>` or `!=` not equal
* `>` greater than
* `<` less than
* `>=` greater or equal
* `<=` less or equal
* `IN (val1, val2, ...)` membership
* `NOT IN (...)` not membership (be careful with `NULL`)
* `IS NULL`, `IS NOT NULL` (for NULL checks — **do not use** `= NULL`)

**Examples**

```sql
-- equality & inequality
SELECT * FROM Products WHERE price = 9.99;
SELECT * FROM Products WHERE category <> 'electronics';

-- IN
SELECT * FROM Employees WHERE dept_id IN (1, 3);

-- IS NULL (correct way to check NULL)
SELECT * FROM Employees WHERE manager_id IS NULL;
```

**Important**: `col = NULL` returns `UNKNOWN` (not true). Always use `IS NULL`.

---

# 6. Logical Operators — `AND`, `OR`, `NOT`

* `AND` — true when both operands are true
* `OR` — true when at least one operand is true
* `NOT` — negates the truth value

**Operator precedence**: `NOT` > `AND` > `OR` (use parentheses to be explicit).

### Examples

```sql
-- employees in dept 2 with salary > 50k OR senior title
SELECT * FROM Employees
WHERE (dept_id = 2 AND salary > 50000)
   OR title LIKE '%Senior%';

-- NOT usage
SELECT * FROM Employees
WHERE NOT (is_active = FALSE);
```

### Three-valued logic (NULL)

SQL uses three-valued logic: `TRUE`, `FALSE`, `UNKNOWN` (when `NULL` is involved). Here are compact truth-tables:

**A AND B**

| A     | B     | A AND B |
| ----- | ----- | ------- |
| TRUE  | TRUE  | TRUE    |
| TRUE  | FALSE | FALSE   |
| FALSE | TRUE  | FALSE   |
| FALSE | FALSE | FALSE   |
| TRUE  | NULL  | NULL    |
| NULL  | TRUE  | NULL    |
| FALSE | NULL  | FALSE   |
| NULL  | FALSE | FALSE   |
| NULL  | NULL  | NULL    |

**A OR B**

| A     | B     | A OR B |
| ----- | ----- | ------ |
| TRUE  | TRUE  | TRUE   |
| TRUE  | FALSE | TRUE   |
| FALSE | TRUE  | TRUE   |
| FALSE | FALSE | FALSE  |
| TRUE  | NULL  | TRUE   |
| NULL  | TRUE  | TRUE   |
| FALSE | NULL  | NULL   |
| NULL  | FALSE | NULL   |
| NULL  | NULL  | NULL   |

**NOT**

| A     | NOT A |
| ----- | ----- |
| TRUE  | FALSE |
| FALSE | TRUE  |
| NULL  | NULL  |

**Implication**: if `WHERE` condition evaluates to `NULL` (unknown), the row is not returned. That’s why `IS NULL` checks are required.

---

# 7. `NULL` — semantics & handling

* `NULL` means *unknown / missing value*, not zero or empty string.
* Comparisons with `NULL` yield `UNKNOWN`.
* Use `IS NULL` / `IS NOT NULL` to test nullity.

**Examples**

```sql
-- find employees without manager
SELECT * FROM Employees WHERE manager_id IS NULL;

-- replace NULL with default using COALESCE
SELECT name, COALESCE(phone, 'no-phone') AS phone_display FROM Employees;
```

`COALESCE(col, default)` returns the first non-NULL value.

---

# 8. `LIKE` — pattern matching

`LIKE` supports wildcards:

* `%` — any sequence of characters (including empty)
* `_` — exactly one character

**Examples**

```sql
-- names starting with 'A'
SELECT * FROM Employees WHERE name LIKE 'A%';

-- emails ending with gmail.com
SELECT * FROM Customers WHERE email LIKE '%@gmail.com';

-- names with exactly 5 characters
SELECT * FROM Employees WHERE name LIKE '_____' ;

-- escape wildcard if you literally want % or _
SELECT * FROM Products WHERE code LIKE '50\%%' ESCAPE '\';
```

**Case sensitivity**: depends on DB collation/case-sensitivity. Postgres: use `ILIKE` for case-insensitive matching.

---

# 9. `BETWEEN` — range checks

* `BETWEEN a AND b` is **inclusive**: equivalent to `>= a AND <= b`.
* Order matters — typically use `low AND high`.

**Examples**

```sql
-- salary between 30k and 60k (inclusive)
SELECT name, salary
FROM Employees
WHERE salary BETWEEN 30000 AND 60000;

-- dates between
SELECT * FROM Orders WHERE order_date BETWEEN '2024-01-01' AND '2024-01-31';
```

**Note**: `BETWEEN` includes endpoints. For decimals/dates pay attention to time parts (use `>=`/`<` for half-open ranges if needed).

---

# 10. Subqueries (nested queries)

Subqueries (inner queries) can be used in `SELECT`, `FROM`, `WHERE`, and more.

### Types

* **Non-correlated subquery**: independent of outer query. Runs once.
* **Correlated subquery**: references outer query columns. Runs per row.
* **Scalar subquery**: returns single value.
* **IN / NOT IN subqueries**
* **EXISTS** subqueries
* **Derived tables** (subquery in `FROM`)

---

### Examples

**IN (non-correlated)**

```sql
-- All employees in departments named 'Sales'
SELECT * FROM Employees
WHERE dept_id IN (SELECT dept_id FROM Departments WHERE dept_name = 'Sales');
```

**Correlated subquery**

```sql
-- employees with salary greater than their department average
SELECT e.emp_id, e.name, e.salary, e.dept_id
FROM Employees e
WHERE e.salary > (
    SELECT AVG(salary) 
    FROM Employees
    WHERE dept_id = e.dept_id   -- reference to outer query -> correlated
);
```

**EXISTS (preferred for NOT IN / NULL pitfalls)**

```sql
-- departments that have at least one employee
SELECT d.dept_id, d.dept_name
FROM Departments d
WHERE EXISTS (
    SELECT 1 FROM Employees e WHERE e.dept_id = d.dept_id
);
```

**NOT IN NULL pitfall**
If the subquery returns any `NULL`, `NOT IN` may yield no results:

```sql
-- Danger: if subquery returns NULL, NOT IN yields UNKNOWN -> rows filtered out
SELECT * FROM Employees WHERE dept_id NOT IN (SELECT dept_id FROM BlacklistedDepts);
```

**Safer with NOT EXISTS or filter NULLs:**

```sql
-- Safe version
SELECT * FROM Employees e
WHERE NOT EXISTS (
  SELECT 1 FROM BlacklistedDepts b WHERE b.dept_id = e.dept_id
);
```

**Subquery in FROM (derived table)**

```sql
-- compute dept averages then join to departments
SELECT d.dept_name, s.avg_salary
FROM (
   SELECT dept_id, AVG(salary) AS avg_salary
   FROM Employees
   GROUP BY dept_id
) s
JOIN Departments d ON s.dept_id = d.dept_id;
```

---

# Combined practical examples

1. **Find active employees in Engineering with salary between 40k and 80k and name starting with 'R'**

```sql
SELECT emp_id, name, salary
FROM Employees
WHERE is_active = TRUE
  AND dept_id = (SELECT dept_id FROM Departments WHERE dept_name = 'Engineering')
  AND salary BETWEEN 40000 AND 80000
  AND name LIKE 'R%';
```

2. **Get products whose price is in top 10% (using subquery)**

```sql
SELECT p.*
FROM Products p
WHERE price >= (
  SELECT MAX(price) * 0.9 FROM Products   -- simplified example
);
```

3. **Find customers who ordered more than average order amount**

```sql
SELECT customer_id
FROM Orders
GROUP BY customer_id
HAVING AVG(total_amount) > (SELECT AVG(total_amount) FROM Orders);
```

---

# Quick pitfalls & best-practices

* `NULL` ≠ empty string or 0 — use `IS NULL`.
* Avoid `NOT IN` if subquery might return `NULL` — prefer `NOT EXISTS` or filter nulls.
* Use parentheses with `AND`/`OR` to ensure correct logic.
* Use `COALESCE()` or `IFNULL()` to handle nulls when you need a concrete value.
* Prefer `EXISTS` for correlated existence checks (often faster).
* Prefer explicit column list in `INSERT` and `SELECT`.
* Use prepared statements / parameters to avoid SQL injection (e.g., `?` in JDBC).
* Index columns used frequently in `WHERE` to speed queries (but avoid over-indexing).

---

