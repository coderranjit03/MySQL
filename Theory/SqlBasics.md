
---

# 📘 What is SQL?

**SQL (Structured Query Language)** is a **standard language** for interacting with relational databases.
It allows you to:

* **Define** database structures (tables, schemas)
* **Manipulate** data (insert, update, delete, select)
* **Control** access (permissions, roles)
* **Ensure consistency** of data with transactions

👉 In short, SQL = **Language to talk with databases**.

---

# 🔹 Why SQL is Important?

* Almost every application (websites, apps, banking systems, social media, e-commerce) needs a **database**.
* SQL is the **universal skill** used across MySQL, PostgreSQL, Oracle, SQL Server, SQLite (with some small differences).
* Knowing SQL means you can **analyze data, build apps, and manage databases**.

---

# 🔹 SQL Command Categories

SQL is divided into **sub-languages**, each serving a purpose:

1. **DDL (Data Definition Language)** – Defines **structure**
2. **DML (Data Manipulation Language)** – Works with **data**
3. **DCL (Data Control Language)** – Manages **permissions**
4. **TCL (Transaction Control Language)** – Manages **transactions**

We’ll now go deeper into each one with **examples**.

---

## 1️⃣ DDL (Data Definition Language)

* Defines the **schema/structure** of the database.
* It defines **what tables exist** and **what columns they have**.
* Examples:

  * `CREATE` → make a table
  * `ALTER` → modify table structure
  * `DROP` → delete table
  * `TRUNCATE` → delete all rows (but keep structure)

### Example

```sql
-- Create table
CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    salary DECIMAL(10,2),
    hire_date DATE
);

-- Add new column
ALTER TABLE Employees ADD department VARCHAR(30);

-- Delete column
ALTER TABLE Employees DROP COLUMN department;

-- Remove all rows but keep structure
TRUNCATE TABLE Employees;

-- Delete table permanently
DROP TABLE Employees;
```

✔️ DDL is **auto-committed** → once executed, changes are permanent.

---

## 2️⃣ DML (Data Manipulation Language)

* Deals with **data inside tables**.
* Used for **CRUD operations** on data.

  * `INSERT` → Add new data
  * `SELECT` → Retrieve data
  * `UPDATE` → Modify data
  * `DELETE` → Remove data

### Example

```sql
-- Insert data
INSERT INTO Employees (emp_id, name, salary, hire_date)
VALUES (1, 'Ravi Kumar', 50000, '2023-01-15');

-- Read data
SELECT * FROM Employees;
SELECT name, salary FROM Employees WHERE salary > 40000;

-- Update data
UPDATE Employees
SET salary = 60000
WHERE emp_id = 1;

-- Delete data
DELETE FROM Employees WHERE emp_id = 1;
```

✔️ DML is **not auto-committed** → requires `COMMIT` or `ROLLBACK`.

---

## 3️⃣ DCL (Data Control Language)


* Deals with **permissions & access control**.
* Controls **who can access what**.

  * `GRANT` → Give access
  * `REVOKE` → Take back access

### Example

```sql
-- Give permission
GRANT SELECT, INSERT ON Employees TO user1;

-- Remove permission
REVOKE INSERT ON Employees FROM user1;
```

✔️ Useful for **database security**.

---

## 4️⃣ TCL (Transaction Control Language)

* Ensures **data consistency**.
* Transactions = group of SQL statements executed as **one unit**.

### Example

```sql
-- Insert multiple records
INSERT INTO Employees VALUES (2, 'Anita', 70000, '2022-05-01');
INSERT INTO Employees VALUES (3, 'Rahul', 45000, '2022-07-10');

-- If all good, save changes
COMMIT;

-- If mistake, undo changes
ROLLBACK;

-- Create a checkpoint
SAVEPOINT before_raise;

-- Rollback to checkpoint
ROLLBACK TO before_raise;
```

✔️ Used with **DML commands only**.

---

# 🔹 Additional SQL Features

SQL also has many **powerful features**:

### 1. **Constraints** (ensure data rules)

```sql
CREATE TABLE Students (
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE,
    age INT CHECK (age >= 18)
);
```

### 2. **Joins** (combine data from multiple tables)

```sql
-- Inner Join
SELECT Employees.name, Departments.dept_name
FROM Employees
INNER JOIN Departments ON Employees.dept_id = Departments.dept_id;
```

### 3. **Aggregate Functions**

```sql
SELECT AVG(salary), MAX(salary), MIN(salary), COUNT(*) FROM Employees;
```

### 4. **Group By & Having**

```sql
SELECT department, AVG(salary)
FROM Employees
GROUP BY department
HAVING AVG(salary) > 50000;
```

### 5. **Indexes** (speed up queries)

```sql
CREATE INDEX idx_name ON Employees(name);
```

### 6. **Views** (virtual tables)

```sql
CREATE VIEW HighSalary AS
SELECT name, salary FROM Employees WHERE salary > 60000;
```

---

# 🔑 Key Differences at a Glance

| Command Type | Full Form                    | Purpose                            | Auto-Commit?                 | Examples                               |
| ------------ | ---------------------------- | ---------------------------------- | ---------------------------- | -------------------------------------- |
| **DDL**      | Data Definition Language     | Defines structure (tables, schema) | ✅ Yes                        | `CREATE`, `ALTER`, `DROP`, `TRUNCATE`  |
| **DML**      | Data Manipulation Language   | Works with data (CRUD)             | ❌ No                         | `INSERT`, `UPDATE`, `DELETE`, `SELECT` |
| **DCL**      | Data Control Language        | Controls permissions               | ✅ Yes                        | `GRANT`, `REVOKE`                      |
| **TCL**      | Transaction Control Language | Manages transactions               | ❌ No (needs commit/rollback) | `COMMIT`, `ROLLBACK`, `SAVEPOINT`      |

---

# 🔑 Summary

* **SQL = Universal language for databases**
* **DDL** → Defines database objects (tables, schema)
* **DML** → Manipulates data (CRUD)
* **DCL** → Controls permissions (GRANT/REVOKE)
* **TCL** → Manages transactions (COMMIT/ROLLBACK)

---


