
---

# 📘 Primary Key in SQL

## 🔹 1. What is a Primary Key?

A **Primary Key** is a **unique identifier** for each record in a database table.
It ensures that:

* No two rows have the same primary key value (**uniqueness**).
* No row has a `NULL` primary key value (**not null**).

👉 Think of it as the "identity card number" of each row in a table.
Just like no two people can have the same Aadhaar number (in India) or Social Security Number (in the US), no two rows can share the same primary key value.

---

## 🔹 2. Rules of Primary Key

1. Each table can have **only one primary key**.
2. A primary key can consist of **one column** (simple key) or **multiple columns** (composite key).
3. Primary key values **must be unique**.
4. Primary key values **cannot be NULL**.
5. A primary key automatically creates a **unique index** on that column(s) for fast access.

---

## 🔹 3. Syntax

```sql
-- Defining Primary Key during table creation
CREATE TABLE table_name (
    column_name datatype PRIMARY KEY,
    ...
);

-- Defining Composite Primary Key
CREATE TABLE table_name (
    column1 datatype,
    column2 datatype,
    ...
    PRIMARY KEY (column1, column2)
);

-- Adding Primary Key after table creation
ALTER TABLE table_name
ADD CONSTRAINT pk_constraint_name PRIMARY KEY (column_name);
```

---

## 🔹 4. Example 1: Simple Primary Key

```sql
CREATE TABLE students (
    student_id INT PRIMARY KEY,
    name VARCHAR(50),
    age INT
);

-- Insert Records
INSERT INTO students (student_id, name, age) VALUES
(1, 'Alice', 20),
(2, 'Bob', 22),
(3, 'Charlie', 21);

-- Trying to insert duplicate primary key
INSERT INTO students (student_id, name, age) VALUES
(1, 'David', 23);
```

### ✅ Output:

* The first three inserts succeed.
* The last insert **fails** with error:
  `Duplicate entry '1' for key 'PRIMARY'`

---

## 🔹 5. Example 2: Composite Primary Key

A **Composite Primary Key** means using more than one column together as the unique identifier.

```sql
CREATE TABLE course_enrollments (
    student_id INT,
    course_id INT,
    enrollment_date DATE,
    PRIMARY KEY (student_id, course_id)
);

-- Insert Records
INSERT INTO course_enrollments VALUES
(1, 101, '2023-01-10'),
(1, 102, '2023-01-15'),
(2, 101, '2023-01-20');

-- Trying to insert duplicate combination
INSERT INTO course_enrollments VALUES
(1, 101, '2023-02-01');
```

### ✅ Output:

* The first three inserts succeed.
* The last insert **fails** because `(student_id=1, course_id=101)` already exists.

---

## 🔹 6. Example 3: Primary Key Auto Increment

Primary keys are often used with `AUTO_INCREMENT` so they generate unique values automatically.

```sql
CREATE TABLE employees (
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50)
);

INSERT INTO employees (name, department) VALUES
('Alice', 'HR'),
('Bob', 'Finance'),
('Charlie', 'IT');

SELECT * FROM employees;
```

### ✅ Output:

| emp\_id | name    | department |
| ------- | ------- | ---------- |
| 1       | Alice   | HR         |
| 2       | Bob     | Finance    |
| 3       | Charlie | IT         |

---

## 🔹 7. Difference Between Primary Key and Unique Key

| Feature            | Primary Key                    | Unique Key                               |
| ------------------ | ------------------------------ | ---------------------------------------- |
| **Uniqueness**     | Ensures uniqueness of records  | Ensures uniqueness, but multiple allowed |
| **NULL values**    | Cannot accept NULL             | Can accept one NULL (depends on DBMS)    |
| **Number allowed** | Only one per table             | Multiple unique keys allowed per table   |
| **Purpose**        | Used for entity identification | Used for enforcing uniqueness constraint |

---

## 🔹 8. Difference Between Primary Key and Foreign Key

| Feature          | Primary Key (PK)                       | Foreign Key (FK)                             |
| ---------------- | -------------------------------------- | -------------------------------------------- |
| **Definition**   | Uniquely identifies records in a table | References PK from another table             |
| **NULL allowed** | Not allowed                            | Allowed (depending on relationship)          |
| **Uniqueness**   | Always unique                          | May repeat                                   |
| **Purpose**      | Enforce row identity                   | Enforce referential integrity between tables |

---

## 🔹 9. Best Practices for Primary Key

* Always choose a column (or set of columns) that **uniquely identifies each row**.
* Use **numeric, auto-incremented IDs** as PK for simplicity and performance.
* Avoid natural keys (like email, phone number) as PK because they may change.
* Keep PKs **small and simple** to improve indexing and query performance.

---

## ✅ Summary

* A **Primary Key** is the main way to uniquely identify each row in a table.
* It enforces **uniqueness** and **not null** constraints.
* Supports **simple** and **composite** keys.
* Often used with **AUTO\_INCREMENT** for automatically generating IDs.
* Works closely with **foreign keys** to build relationships between tables.

---

