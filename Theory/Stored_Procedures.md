
---

# 📘 `Stored_Procedures.md`


# ⚡ Stored Procedures in MySQL

## 🔹 What is a Stored Procedure?
A **Stored Procedure** is a **precompiled block of SQL statements** stored in the database.  
It can be called multiple times without rewriting SQL logic.  

📌 Think of it as a **function in programming**, but it runs directly inside the MySQL server.

---

## 🔹 Benefits
✅ Improves **performance** (compiled once, reused)  
✅ Enhances **security** (restricts raw table access)  
✅ Provides **reusability** (write once, call anywhere)  
✅ Easier **maintenance** (logic stored in DB)

---

## 🔹 Syntax
```sql
DELIMITER $$

CREATE PROCEDURE procedure_name (parameter_mode param_name datatype, ...)
BEGIN
   -- SQL statements
END $$

DELIMITER ;
````

### Parameter Modes:

* **IN** → Input only (default)
* **OUT** → Output (returns value)
* **INOUT** → Both input & output

---

## 🔹 Creating Stored Procedures

### 1. Without Parameters

```sql
DELIMITER $$

CREATE PROCEDURE GetAllEmployees()
BEGIN
   SELECT * FROM employees;
END $$

DELIMITER ;

CALL GetAllEmployees();
```

---

### 2. With IN Parameter

```sql
DELIMITER $$

CREATE PROCEDURE GetEmployeesByDept(IN dept_name VARCHAR(50))
BEGIN
   SELECT emp_id, name, salary
   FROM employees
   WHERE department = dept_name;
END $$

DELIMITER ;

CALL GetEmployeesByDept('IT');
```

---

### 3. With OUT Parameter

```sql
DELIMITER $$

CREATE PROCEDURE GetEmployeeCount(OUT total INT)
BEGIN
   SELECT COUNT(*) INTO total FROM employees;
END $$

DELIMITER ;

CALL GetEmployeeCount(@emp_count);
SELECT @emp_count AS TotalEmployees;
```

---

### 4. With INOUT Parameter

```sql
DELIMITER $$

CREATE PROCEDURE UpdateSalary(IN empId INT, INOUT newSalary DECIMAL(10,2))
BEGIN
   UPDATE employees
   SET salary = newSalary
   WHERE emp_id = empId;

   SELECT salary INTO newSalary
   FROM employees
   WHERE emp_id = empId;
END $$

DELIMITER ;

SET @sal = 85000;
CALL UpdateSalary(2, @sal);
SELECT @sal AS UpdatedSalary;
```

---

## 🔹 Altering Stored Procedures

⚠️ MySQL does not support direct `ALTER PROCEDURE`.
Instead, you must **DROP and CREATE again**.

```sql
DROP PROCEDURE IF EXISTS GetAllEmployees;

DELIMITER $$
CREATE PROCEDURE GetAllEmployees()
BEGIN
   SELECT emp_id, name FROM employees;
END $$
DELIMITER ;
```

---

## 🔹 Deleting Stored Procedures

```sql
DROP PROCEDURE procedure_name;

-- Example
DROP PROCEDURE GetEmployeesByDept;
```

---

## 🔹 Viewing Procedures

```sql
-- List all procedures in current DB
SHOW PROCEDURE STATUS WHERE Db = 'your_database';

-- Show definition of a procedure
SHOW CREATE PROCEDURE GetAllEmployees;
```

---

## ✅ Advantages

* Faster execution
* Better security
* Reduces network traffic
* Reusable & modular

## ⚠️ Disadvantages

* Harder to debug
* Less portable across DBMS
* Complex logic may slow performance

---

📌 **In short**:
Stored Procedures = **Reusable SQL programs** stored in the DB.
You can **create, call, drop, and re-create** them easily. Best for performance, reusability, and security.


