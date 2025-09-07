
---

# 🎯 SQL Aliases

## 🔹 What are Aliases?

* An **alias** is a temporary **nickname** or **alternate name** given to a **table** or a **column** in a SQL query.
* Aliases make queries **shorter, cleaner, and more readable**.
* They **exist only during query execution** → they are not stored in the database.

👉 Think of it like using a **shortcut name** for long column/table names.

---

## 🔹 Types of Aliases

1. **Column Aliases** → rename columns in the output.
2. **Table Aliases** → rename tables (mostly used in joins and subqueries).

---

## 🔹 Syntax

```sql
-- Column Alias
SELECT column_name AS alias_name
FROM table_name;

-- Table Alias
SELECT t.column_name
FROM table_name AS t;
```

> Note: `AS` is optional in most SQL dialects. You can just write `column_name alias_name`.

---

## 🔹 1. Column Alias Example

### Query:

```sql
SELECT first_name AS Name, salary AS "Monthly Salary"
FROM Employees;
```

### Output:

| Name    | Monthly Salary |
| ------- | -------------- |
| John    | 5000           |
| Alice   | 6000           |
| Michael | 5500           |

✅ Here:

* `first_name` → renamed as `Name`
* `salary` → renamed as `"Monthly Salary"` (quotes used for spaces in alias)

**Use Case:**

* Cleaner reports (user-friendly column headers).
* Handle complex calculated columns (like `SUM(price * qty)`).

---

## 🔹 2. Table Alias Example

### Query:

```sql
SELECT e.first_name, d.department_name
FROM Employees AS e
JOIN Departments AS d
ON e.dept_id = d.dept_id;
```

### Output:

| first\_name | department\_name |
| ----------- | ---------------- |
| John        | IT               |
| Alice       | HR               |
| Michael     | Finance          |

✅ Here:

* `Employees` → aliased as `e`
* `Departments` → aliased as `d`
* Instead of writing `Employees.first_name`, we can just write `e.first_name`.

**Use Case:**

* Essential in **joins** (especially with long table names).
* Useful in **self-joins** to distinguish the same table.

---

## 🔹 3. Aliases in Expressions (Calculated Columns)

### Query:

```sql
SELECT first_name, (salary * 12) AS Annual_Salary
FROM Employees;
```

### Output:

| first\_name | Annual\_Salary |
| ----------- | -------------- |
| John        | 60000          |
| Alice       | 72000          |
| Michael     | 66000          |

✅ Here: `(salary * 12)` doesn’t have a column name → alias makes it readable.

---

## 🔹 4. Aliases in Subqueries

### Query:

```sql
SELECT e.first_name
FROM (SELECT * FROM Employees WHERE salary > 5000) AS e;
```

✅ The subquery `(SELECT * FROM Employees WHERE salary > 5000)` is given an alias `e`.
Without alias, SQL wouldn’t allow referencing the subquery.

---

## 🔹 5. Aliases in Self-Join (Important Use Case)

### Query:

```sql
SELECT e1.first_name AS Employee, e2.first_name AS Manager
FROM Employees AS e1
JOIN Employees AS e2
ON e1.manager_id = e2.emp_id;
```

### Output:

| Employee | Manager |
| -------- | ------- |
| John     | Alice   |
| Michael  | Alice   |

✅ Here we used the same table `Employees` twice, but distinguished them with aliases `e1` and `e2`.

---

## 🔹 Summary of Use Cases

* **Column Aliases**

  * Rename column headings for reports.
  * Simplify calculated columns.
  * Handle long/complex names.

* **Table Aliases**

  * Make queries shorter & cleaner.
  * Essential for **joins** and **subqueries**.
  * Must-have in **self-joins**.

---

⚡ **Key Takeaway:**
Aliases don’t change database structure — they are just **temporary names** for making queries easier to write and understand.

---
