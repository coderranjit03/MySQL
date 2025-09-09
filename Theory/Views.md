
---

# 📘 SQL Views (Expanded with Theory + Examples)

---

## 🔹 1. What is a View?

A **View** in SQL is a **virtual table** based on a query. Unlike a table, it **does not store data permanently**; instead, it saves the query logic.
Whenever we query the view, the database **executes the underlying SQL** and shows the results as if it were a real table.

👉 Example use case: Suppose you have a big table with **employee salaries**, but you don’t want to give HR access to all columns (like `emp_id` or `department`). Instead of writing the query every time, you can **create a view** that only shows `name` and `salary`.

---

## 🔹 2. Syntax

```sql
-- Create a view
CREATE VIEW view_name AS
SELECT column1, column2, ...
FROM table_name
WHERE condition;

-- Query a view
SELECT * FROM view_name;

-- Update a view
CREATE OR REPLACE VIEW view_name AS
SELECT ...
FROM ...;

-- Drop a view
DROP VIEW view_name;
```

---

## 🔹 3. Examples with Theory

---

### ✅ Example 1: **Simple View**

#### Table Setup:

```sql
CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10,2)
);

INSERT INTO Employees VALUES
(1, 'Alice', 'HR', 50000),
(2, 'Bob', 'Finance', 60000),
(3, 'Charlie', 'IT', 70000),
(4, 'David', 'Finance', 65000),
(5, 'Eve', 'IT', 75000);
```

#### Create a View:

```sql
CREATE VIEW FinanceEmployees AS
SELECT name, salary
FROM Employees
WHERE department = 'Finance';
```

**Theory:**

* Here we are creating a **virtual table** that only shows employees from the **Finance department**.
* Instead of filtering every time with `WHERE department = 'Finance'`, we can just query the view.

#### Querying the View:

```sql
SELECT * FROM FinanceEmployees;
```

**Output:**

| name  | salary |
| ----- | ------ |
| Bob   | 60000  |
| David | 65000  |

👉 Now, any user who runs `SELECT * FROM FinanceEmployees;` sees only Finance employees, **without knowing the underlying Employees table structure**.

---

### ✅ Example 2: **Aggregated View**

```sql
CREATE VIEW DepartmentAvgSalary AS
SELECT department, AVG(salary) AS avg_salary
FROM Employees
GROUP BY department;
```

**Theory:**

* This view groups employees by their **department** and calculates the **average salary**.
* Without the view, you would need to write this query every time. With the view, you can just query it like a table.

#### Query:

```sql
SELECT * FROM DepartmentAvgSalary;
```

**Output:**

| department | avg\_salary |
| ---------- | ----------- |
| HR         | 50000       |
| Finance    | 62500       |
| IT         | 72500       |

👉 This is useful in **reporting dashboards** where management wants to see **summary data** without learning SQL queries.

---

### ✅ Example 3: **Updating a View**

```sql
CREATE OR REPLACE VIEW HighEarners AS
SELECT name, salary
FROM Employees
WHERE salary > 65000;
```

**Theory:**

* Here we use **`CREATE OR REPLACE`** because we want to **update the view definition**.
* The new view now shows employees who earn more than **65,000**.

#### Query:

```sql
SELECT * FROM HighEarners;
```

**Output:**

| name    | salary |
| ------- | ------ |
| Charlie | 70000  |
| Eve     | 75000  |

👉 This view is helpful when HR wants to **quickly identify high-paying employees**.

---

### ✅ Example 4: **Updatable View**

```sql
UPDATE FinanceEmployees
SET salary = 70000
WHERE name = 'Bob';
```

**Theory:**

* Since `FinanceEmployees` is a **simple view** (based on one table, no aggregates), you can **update the underlying table** through the view.
* After this update, Bob’s salary in the `Employees` table will also change.

👉 Not all views are updatable. If a view has **joins, aggregates, or GROUP BY**, it becomes **read-only**.

---

## 🔹 4. Types of Views

1. **Simple View** – based on one table, no functions or grouping. (Updatable)
2. **Complex View** – based on multiple tables, joins, or grouping. (Usually read-only)
3. **Materialized View** (not in MySQL) – stores actual query results for performance.

---

## 🔹 5. Advantages of Views

* **Simplifies queries** → no need to rewrite long joins.
* **Security** → expose only required columns.
* **Consistency** → single definition used everywhere.
* **Data independence** → changes in table structure don’t always affect users.

---

## 🔹 6. Limitations of Views

* Views do **not store data** (unless materialized).
* Performance can be slow if based on complex queries.
* Not all views are updatable.
* If base tables change (drop columns), views may break.

---

✅ **Summary:**

* A **View** is like a **virtual table** that saves query logic.
* Useful for **security, simplicity, and reporting**.
* **Simple views** can be updated, **complex views** are usually read-only.
