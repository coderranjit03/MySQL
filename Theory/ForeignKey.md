
---

# 📘 Foreign Key in SQL

## 🔹 1. What is a Foreign Key?

A **Foreign Key (FK)** is a column (or a set of columns) in one table that **refers to the Primary Key in another table**.

It creates a **relationship** between two tables:

* The table **containing the foreign key** is called the **child table**.
* The table **containing the referenced primary key** is called the **parent table**.

👉 Think of it like this:

* **Parent table:** Aadhar database with unique Aadhar numbers.
* **Child table:** Bank accounts that store Aadhar numbers as reference.
* If the Aadhar doesn’t exist in parent DB, it **cannot be used in child table**.

---

## 🔹 2. Rules of Foreign Key

1. A Foreign Key **must reference a Primary Key or Unique Key** in another table.
2. A Foreign Key can accept **NULL values** (unless explicitly restricted).
3. A table can have **multiple foreign keys**.
4. Helps maintain **referential integrity** (prevents invalid data entry).
5. When the referenced record in the parent table is updated or deleted, the **ON UPDATE** or **ON DELETE** actions decide what happens in the child table.

---

## 🔹 3. Syntax

```sql
-- Defining Foreign Key during table creation
CREATE TABLE child_table (
    column_name datatype,
    FOREIGN KEY (column_name) REFERENCES parent_table(parent_column)
);

-- Naming Foreign Key Constraint
CREATE TABLE child_table (
    column_name datatype,
    CONSTRAINT fk_name FOREIGN KEY (column_name) REFERENCES parent_table(parent_column)
);

-- Adding Foreign Key after table creation
ALTER TABLE child_table
ADD CONSTRAINT fk_name FOREIGN KEY (column_name) REFERENCES parent_table(parent_column);
```

---

## 🔹 4. Example 1: Basic Foreign Key

```sql
-- Parent Table
CREATE TABLE departments (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(50)
);

-- Child Table with FK referencing departments
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

-- Insert Data
INSERT INTO departments VALUES (1, 'HR'), (2, 'Finance'), (3, 'IT');

INSERT INTO employees VALUES (101, 'Alice', 1), (102, 'Bob', 2);

-- ❌ This will fail because dept_id=5 does not exist in parent table
INSERT INTO employees VALUES (103, 'Charlie', 5);
```

### ✅ Output:

* First two employee inserts succeed.
* Third insert fails:
  `Cannot add or update a child row: a foreign key constraint fails`

---

## 🔹 5. Example 2: ON DELETE and ON UPDATE Actions

Foreign Keys support actions that define what happens when parent records are updated or deleted:

* `ON DELETE CASCADE` → Delete child records automatically.
* `ON DELETE SET NULL` → Set child column to NULL.
* `ON DELETE RESTRICT` (default) → Prevent deletion if child exists.
* `ON UPDATE CASCADE` → Update child column when parent is updated.

```sql
-- Parent Table
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50)
);

-- Child Table with ON DELETE CASCADE
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id) ON DELETE CASCADE
);

-- Insert Data
INSERT INTO customers VALUES (1, 'John'), (2, 'Emma');
INSERT INTO orders VALUES (101, 1), (102, 2);

-- Delete a customer
DELETE FROM customers WHERE customer_id = 1;

SELECT * FROM orders;
```

### ✅ Output:

| order\_id | customer\_id |
| --------- | ------------ |
| 102       | 2            |

👉 Order 101 got **deleted automatically** because customer\_id=1 was deleted.

---

## 🔹 6. Example 3: Multiple Foreign Keys

```sql
-- Parent Tables
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    student_name VARCHAR(50)
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY,
    course_name VARCHAR(50)
);

-- Child Table
CREATE TABLE enrollments (
    student_id INT,
    course_id INT,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id),
    PRIMARY KEY (student_id, course_id)
);
```

👉 Here, `enrollments` table has **two FKs** referencing `students` and `courses`.

---

## 🔹 7. Difference Between Primary Key and Foreign Key

| Feature          | Primary Key (PK)                       | Foreign Key (FK)                             |
| ---------------- | -------------------------------------- | -------------------------------------------- |
| **Definition**   | Uniquely identifies records in a table | References PK/Unique Key from another table  |
| **NULL allowed** | Not allowed                            | Allowed (unless restricted)                  |
| **Uniqueness**   | Always unique                          | May repeat                                   |
| **Table**        | Defined in parent table                | Defined in child table                       |
| **Purpose**      | Enforce row identity                   | Enforce referential integrity between tables |

---

## 🔹 8. Best Practices for Foreign Keys

* Always link **child table foreign keys** to **parent table primary/unique keys**.
* Use **CASCADE** options carefully — they can delete large amounts of data if not handled properly.
* Index the foreign key columns for faster joins.
* Do not use foreign keys for frequently updated columns (can reduce performance).

---

## ✅ Summary

* **Foreign Key** connects one table to another, enforcing **referential integrity**.
* Supports `ON DELETE` and `ON UPDATE` actions for handling parent-child relationships.
* A table can have **multiple foreign keys**.
* Essential for building **normalized relational databases**.

---

