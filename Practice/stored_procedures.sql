-- Create sample employees table
CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    department VARCHAR(50),
    salary DECIMAL(10,2)
);

-- Insert sample data
INSERT INTO employees VALUES
(1, 'Alice', 'HR', 60000),
(2, 'Bob', 'IT', 70000),
(3, 'Charlie', 'Finance', 80000);

---------------------------------------------------
-- 1. Simple Procedure
DELIMITER $$
CREATE PROCEDURE GetAllEmployees()
BEGIN
   SELECT * FROM employees;
END $$
DELIMITER ;

CALL GetAllEmployees();

---------------------------------------------------
-- 2. Procedure with IN parameter
DELIMITER $$
CREATE PROCEDURE GetEmployeesByDept(IN dept_name VARCHAR(50))
BEGIN
   SELECT emp_id, name, salary
   FROM employees
   WHERE department = dept_name;
END $$
DELIMITER ;

CALL GetEmployeesByDept('IT');

---------------------------------------------------
-- 3. Procedure with OUT parameter
DELIMITER $$
CREATE PROCEDURE GetEmployeeCount(OUT total INT)
BEGIN
   SELECT COUNT(*) INTO total FROM employees;
END $$
DELIMITER ;

CALL GetEmployeeCount(@emp_count);
SELECT @emp_count AS TotalEmployees;

---------------------------------------------------
-- 4. Procedure with INOUT parameter
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

---------------------------------------------------
-- 5. Drop Procedure
DROP PROCEDURE IF EXISTS GetEmployeesByDept;

---------------------------------------------------
-- 6. Show all procedures
SHOW PROCEDURE STATUS WHERE Db = DATABASE();

-- 7. Show source code of a procedure
SHOW CREATE PROCEDURE GetAllEmployees;
````

