
---

# 📘 `REPLACE` in SQL (MySQL)

---

## 🔹 1. What is `REPLACE`?

The **`REPLACE` statement** in MySQL is used to **insert a new row or update an existing row** depending on whether the **primary key** or a **unique key** already exists.

It is basically a combination of:

* **`INSERT`** (if the row doesn’t exist).
* **`DELETE + INSERT`** (if the row already exists).

👉 Think of it as:

> “If row exists, delete it and insert the new one. Otherwise, just insert.”

---

## 🔹 2. Syntax

```sql
REPLACE INTO table_name (column1, column2, ...)
VALUES (value1, value2, ...);
```

OR

```sql
REPLACE table_name
SET column1 = value1, column2 = value2, ...;
```

---

## 🔹 3. How `REPLACE` Works

1. MySQL checks if the row with the **same PRIMARY KEY** or **UNIQUE key** already exists.
2. If it exists → deletes the old row.
3. Inserts the new row.

⚠️ Because of the internal **delete + insert**, things to note:

* AUTO\_INCREMENT values **increase** (not reused).
* Any **foreign key constraints** must allow deletion.
* **Triggers** on DELETE and INSERT will fire.

---

## 🔹 4. Example

### Table Setup

```sql
CREATE TABLE Students (
    id INT PRIMARY KEY,
    name VARCHAR(50),
    grade VARCHAR(5)
);

INSERT INTO Students VALUES
(1, 'Alice', 'A'),
(2, 'Bob', 'B'),
(3, 'Charlie', 'C');
```

---

### ✅ Example 1: Normal Insert

```sql
REPLACE INTO Students (id, name, grade)
VALUES (4, 'David', 'B');
```

👉 Since `id = 4` does not exist, it behaves like `INSERT`.

**Result:**

| id | name    | grade |
| -- | ------- | ----- |
| 1  | Alice   | A     |
| 2  | Bob     | B     |
| 3  | Charlie | C     |
| 4  | David   | B     |

---

### ✅ Example 2: Replace Existing Row

```sql
REPLACE INTO Students (id, name, grade)
VALUES (2, 'Bobby', 'A');
```

👉 Since `id = 2` already exists:

* The old row `(2, 'Bob', 'B')` is deleted.
* New row `(2, 'Bobby', 'A')` is inserted.

**Result:**

| id | name    | grade |
| -- | ------- | ----- |
| 1  | Alice   | A     |
| 2  | Bobby   | A     |
| 3  | Charlie | C     |
| 4  | David   | B     |

---

### ✅ Example 3: Replace Using `SET`

```sql
REPLACE Students
SET id = 3, name = 'Charles', grade = 'B';
```

👉 Old row `(3, 'Charlie', 'C')` replaced with `(3, 'Charles', 'B')`.

**Result:**

| id | name    | grade |
| -- | ------- | ----- |
| 1  | Alice   | A     |
| 2  | Bobby   | A     |
| 3  | Charles | B     |
| 4  | David   | B     |

---

## 🔹 5. Difference Between `REPLACE` and `INSERT ... ON DUPLICATE KEY UPDATE`

| Feature              | `REPLACE`                               | `INSERT ... ON DUPLICATE KEY UPDATE`  |
| -------------------- | --------------------------------------- | ------------------------------------- |
| Action if row exists | Deletes old row, inserts new            | Updates existing row directly         |
| Triggers             | Fires `DELETE` + `INSERT` triggers      | Fires only `UPDATE` triggers          |
| AUTO\_INCREMENT      | Value increments (old deleted, new row) | Value does not change (same row kept) |
| Use Case             | Full row replacement                    | Partial updates if row exists         |

---

## 🔹 6. Key Points to Remember

* Works only if table has a **PRIMARY KEY or UNIQUE constraint**.
* Deletes + Inserts → so you might lose information (like `created_at`).
* Can cause **gaps in AUTO\_INCREMENT** values.
* Useful when you want to **always insert fresh data** without checking if it exists.

---

## ✅ Summary

* `REPLACE` = **INSERT if not exists** OR **DELETE + INSERT if exists**.
* Requires **PRIMARY KEY** or **UNIQUE constraint**.
* Different from `ON DUPLICATE KEY UPDATE` (which updates existing row instead of deleting).
* Best for scenarios where replacing the full row is acceptable.

---

