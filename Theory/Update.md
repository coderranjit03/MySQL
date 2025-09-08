Got it 👍 Let’s cover the **`UPDATE` statement in SQL** in a full, detailed way:

---

# 📘 `UPDATE` in SQL

## 🔹 1. What is `UPDATE`?

The `UPDATE` statement in SQL is used to **modify existing records** in a table.
It allows you to:

* Change the value(s) of one or more columns,
* Apply conditions (`WHERE`) to restrict which rows are updated,
* Update multiple rows at once,
* Even update data using values from another table (via `JOIN` or subqueries).

---

## 🔹 2. Syntax of `UPDATE`

```sql
UPDATE table_name
SET column1 = value1, column2 = value2, ...
WHERE condition;
```

### Components:

* **`table_name`** → The table where data is to be updated.
* **`SET`** → Defines which column(s) and new values.
* **`WHERE`** → Filters which rows to update.
  ⚠️ If omitted, **all rows will be updated** (common beginner mistake!).

---

## 🔹 3. Simple Example

```sql
-- Table: Employees
CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10,2)
);

INSERT INTO Employees VALUES
(1, 'Alice', 'HR', 50000),
(2, 'Bob', 'Finance', 60000),
(3, 'Charlie', 'IT', 70000);
```

### ✅ Example 1: Update single column

```sql
UPDATE Employees
SET salary = 65000
WHERE emp_id = 2;
```

**Output:**

| emp\_id | name    | department | salary |
| ------- | ------- | ---------- | ------ |
| 1       | Alice   | HR         | 50000  |
| 2       | Bob     | Finance    | 65000  |
| 3       | Charlie | IT         | 70000  |

---

### ✅ Example 2: Update multiple columns

```sql
UPDATE Employees
SET department = 'Human Resources', salary = 52000
WHERE name = 'Alice';
```

**Output:**

| emp\_id | name    | department      | salary |
| ------- | ------- | --------------- | ------ |
| 1       | Alice   | Human Resources | 52000  |
| 2       | Bob     | Finance         | 65000  |
| 3       | Charlie | IT              | 70000  |

---

## 🔹 4. Updating All Rows (⚠️ Dangerous!)

If you **omit WHERE**, all rows are updated.

```sql
UPDATE Employees
SET salary = salary + 5000;
```

**Effect:** Everyone’s salary increases by 5000.
Always double-check before running updates without `WHERE`.

---

## 🔹 5. Conditional Updates

You can use conditions to control updates.

```sql
-- Increase salary by 10% for IT employees
UPDATE Employees
SET salary = salary * 1.1
WHERE department = 'IT';
```

---

## 🔹 6. Using `UPDATE` with `JOIN`

You can update values in one table using data from another.

```sql
-- Table: Bonuses
CREATE TABLE Bonuses (
    emp_id INT,
    bonus DECIMAL(10,2)
);

INSERT INTO Bonuses VALUES (1, 2000), (3, 3000);

-- Update Employees salary by adding bonus
UPDATE Employees e
JOIN Bonuses b ON e.emp_id = b.emp_id
SET e.salary = e.salary + b.bonus;
```

---

## 🔹 7. Using Subqueries in `UPDATE`

```sql
-- Increase salary of employee with the highest bonus
UPDATE Employees
SET salary = salary + 1000
WHERE emp_id = (
    SELECT emp_id FROM Bonuses
    ORDER BY bonus DESC LIMIT 1
);
```

---

## 🔹 8. `UPDATE` with `CASE` (Conditional Updates in One Query)

```sql
UPDATE Employees
SET salary = CASE
    WHEN department = 'HR' THEN salary + 2000
    WHEN department = 'Finance' THEN salary + 3000
    ELSE salary + 1000
END;
```

---

## 🔹 9. Best Practices

✅ Always use `WHERE` unless you intentionally want to update all rows.
✅ Test your query with `SELECT` first to see which rows will be affected.
✅ Make backups before bulk updates.
✅ Use transactions (`BEGIN`, `COMMIT`, `ROLLBACK`) for safety.
✅ Combine with constraints (PK, FK) to avoid unintended changes.

---

## ✅ Summary

* `UPDATE` modifies data in existing rows.
* Syntax: `UPDATE table SET column = value WHERE condition;`
* Without `WHERE`, **all rows** are updated.
* Can update single/multiple columns.
* Can use conditions, joins, subqueries, or CASE for complex updates.
* Use with caution in production databases.

---

Would you like me to also create a **`UPDATE.md` file** (like your `Primary_Key.md` and `Foreign_Key.md`) for your MySQL repo, with explanations + examples + outputs neatly formatted?
