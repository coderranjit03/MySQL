
---

# 📘 `DELETE` vs `TRUNCATE` in SQL

Both `DELETE` and `TRUNCATE` are **Data Manipulation Language (DML) / Data Definition Language (DDL)** operations used to remove data from tables.
But they **work differently** in performance, rollback, and how they treat table structure.

---

## 🔹 1. `DELETE` Statement

### ✅ Definition

The `DELETE` statement removes one or more rows from a table based on a condition.
It is part of **DML (Data Manipulation Language)**.

### ✅ Syntax

```sql
DELETE FROM table_name
WHERE condition;
```

* **`table_name`** → the table from which rows are deleted.
* **`WHERE condition`** → specifies which rows to delete.
  ⚠️ If omitted, **all rows** are deleted, but the table structure remains.

---

### ✅ Example

```sql
-- Table
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
(4, 'David', 'Finance', 65000);
```

#### Example 1: Delete a specific row

```sql
DELETE FROM Employees
WHERE emp_id = 2;
```

**Result:**

| emp\_id | name    | department | salary |
| ------- | ------- | ---------- | ------ |
| 1       | Alice   | HR         | 50000  |
| 3       | Charlie | IT         | 70000  |
| 4       | David   | Finance    | 65000  |

---

#### Example 2: Delete multiple rows

```sql
DELETE FROM Employees
WHERE department = 'Finance';
```

**Result:**

| emp\_id | name    | department | salary |
| ------- | ------- | ---------- | ------ |
| 1       | Alice   | HR         | 50000  |
| 3       | Charlie | IT         | 70000  |

---

#### Example 3: Delete all rows (⚠️ Dangerous!)

```sql
DELETE FROM Employees;
```

All rows deleted, but table structure remains intact.

---

### ✅ Features of `DELETE`

* Removes **selected rows** (with `WHERE`).
* Logs each row deletion (slower for large tables).
* Can be rolled back if inside a transaction.
* Triggers (if defined) will fire on `DELETE`.
* Does **not reset AUTO\_INCREMENT** counters.

---

## 🔹 2. `TRUNCATE` Statement

### ✅ Definition

The `TRUNCATE` statement removes **all rows** from a table.
It is a **DDL (Data Definition Language)** command (though some DBs treat it like DML).

### ✅ Syntax

```sql
TRUNCATE TABLE table_name;
```

* Removes **all data** from the table.
* Much **faster** than `DELETE` (no row-by-row logging).
* Resets the table’s `AUTO_INCREMENT` counter.

---

### ✅ Example

```sql
TRUNCATE TABLE Employees;
```

**Result:**

* All rows deleted.
* Table structure still exists.
* `AUTO_INCREMENT` reset to 1.

---

### ✅ Features of `TRUNCATE`

* Deletes **all rows** (no `WHERE` clause allowed).
* Faster than `DELETE` (minimal logging).
* Usually **cannot be rolled back** (depends on DB + transaction settings).
* Resets `AUTO_INCREMENT`.
* Triggers (like `AFTER DELETE`) usually do **not** fire.

---

## 🔹 3. Key Differences: `DELETE` vs `TRUNCATE`

| Feature                   | DELETE                              | TRUNCATE                     |
| ------------------------- | ----------------------------------- | ---------------------------- |
| **Command Type**          | DML                                 | DDL                          |
| **Deletes**               | Specific rows (with `WHERE`) or all | All rows only                |
| **WHERE clause**          | ✅ Allowed                           | ❌ Not allowed                |
| **Logging**               | Logs each row deletion (slower)     | Minimal logging (faster)     |
| **Rollback**              | ✅ Can rollback (if in transaction)  | ❌ Usually can’t rollback     |
| **Triggers**              | ✅ Fires DELETE triggers             | ❌ Triggers usually not fired |
| **AUTO\_INCREMENT Reset** | ❌ No reset                          | ✅ Resets counter to 1        |
| **Performance**           | Slower for large tables             | Very fast                    |
| **Use Case**              | Remove selective rows               | Quickly empty entire table   |

---

## 🔹 4. When to Use?

* **Use `DELETE`** when:

  * You need to remove **specific rows**.
  * You need triggers to execute.
  * You may need to rollback.

* **Use `TRUNCATE`** when:

  * You want to **remove all rows quickly**.
  * You don’t care about triggers or rollback.
  * You want to reset `AUTO_INCREMENT`.

---

## ✅ Summary

* `DELETE` → Selective, row-by-row, slow, safe (can rollback).
* `TRUNCATE` → Fast, removes everything, resets counters, not rollback-friendly.

---
