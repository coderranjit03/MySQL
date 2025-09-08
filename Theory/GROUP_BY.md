# 📘 GROUP BY Clause in SQL

## 🔹 Definition
The **GROUP BY** clause in SQL is used to arrange **identical data into groups**. 
It is commonly used with **aggregate functions** like `COUNT()`, `SUM()`, `AVG()`, `MIN()`, and `MAX()` 
to perform calculations on each group of data instead of the entire table.


**Think of it as:**
`👉 “Take all rows, put them into buckets based on a column (or more than one), then summarize each bucket.”`


## 🔹 Syntax
```sql
SELECT column1, aggregate_function(column2)
FROM table_name
GROUP BY column1;
```
* `column1` → the column by which we group the data.
* `aggregate_function(column2)` → calculation applied on each group.

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

### Query: Count employees in each department
```sql
SELECT department, COUNT(*) AS employee_count
FROM employees
GROUP BY department;
```

### Output:
| department | employee_count |
|------------|----------------|
| HR         | 2              |
| IT         | 3              |
| Finance    | 1              |

---

## 🔹 Key Points
- `GROUP BY` must come **after WHERE** but **before ORDER BY** in SQL order of execution.
- It can group by **one or multiple columns**.
- Used only when we want **aggregation per group** (not row-wise).
