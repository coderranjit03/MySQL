# 📘 HAVING Clause in SQL

## 🔹 Definition
The **HAVING** clause is used to filter **groups of data created by GROUP BY**.  

It is similar to the `WHERE` clause, but:  
- `WHERE` filters **rows** before grouping.  
- `HAVING` filters **groups** after grouping.

---

## 🔹 Syntax
```sql
SELECT column1, aggregate_function(column2)
FROM table_name
GROUP BY column1
HAVING condition;
```

---

## 🔹 Example

### Employees Table
| id | name    | department | salary  |
|----|---------|------------|---------|
| 1  | Alice   | HR         | 50000   |
| 2  | Bob     | HR         | 55000   |
| 3  | Charlie | IT         | 70000   |
| 4  | David   | IT         | 72000   |
| 5  | Eve     | IT         | 73000   |
| 6  | Frank   | Finance    | 60000   |

### Query: Find departments with more than 2 employees
```sql
SELECT department, COUNT(*) AS employee_count
FROM employees
GROUP BY department
HAVING COUNT(*) > 2;
```

### Output:
| department | employee_count |
|------------|----------------|
| IT         | 3              |

---

## 🔹 Another Example
### Query: Find departments with total salary above 100000
```sql
SELECT department, SUM(salary) AS total_salary
FROM employees
GROUP BY department
HAVING total_salary > 100000;
```

### Output:
| department | total_salary |
|------------|--------------|
| IT         | 215000       |

---

## 🔹 Difference Between WHERE and HAVING
| Feature           | WHERE Clause                                | HAVING Clause                             |
|-------------------|---------------------------------------------|-------------------------------------------|
| **When Applied**  | Before grouping (filters individual rows)   | After grouping (filters grouped results)   |
| **Used With**     | Can be used without `GROUP BY`              | Always used with `GROUP BY` (mostly)       |
| **Aggregate Func**| Cannot be used with aggregate functions     | Can be used with aggregate functions       |

---

## 🔹 Combined Example
### Query: Find departments with average salary greater than 60000
```sql
SELECT department, AVG(salary) AS avg_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 60000;
```

### Output:
| department | avg_salary |
|------------|------------|
| IT         | 71666.67   |
