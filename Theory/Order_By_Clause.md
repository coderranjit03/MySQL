
---

# 📘 ORDER BY Clause in SQL

The `ORDER BY` clause sorts query results in **ascending (ASC)** or **descending (DESC)** order.
Default = `ASC` (ascending).

---

## 1️⃣ ORDER BY with a Single Column

```sql
-- Sort employees by salary (low to high)
SELECT emp_id, name, salary
FROM Employees
ORDER BY salary ASC;

-- Sort employees by hire date (most recent first)
SELECT emp_id, name, hire_date
FROM Employees
ORDER BY hire_date DESC;
```

👉 **Notes**

* `ASC` = smallest → largest (default)
* `DESC` = largest → smallest

---

## 2️⃣ ORDER BY with Multiple Columns

When multiple columns are specified, SQL sorts **first by the first column, then by the second within ties, etc.**

```sql
-- Sort by department first, then by salary descending
SELECT name, dept_id, salary
FROM Employees
ORDER BY dept_id ASC, salary DESC;
```

👉 If two employees are in the same department, their salaries decide their order.

---

## 3️⃣ ORDER BY with Column Position (not recommended)

You can use the column’s **ordinal position** in the `SELECT` list:

```sql
SELECT name, salary, dept_id
FROM Employees
ORDER BY 2 DESC;   -- orders by salary (2nd column)
```

⚠️ Not recommended in production because if you reorder `SELECT` list, sorting changes unexpectedly.

---

## 4️⃣ ORDER BY with Aliases

```sql
SELECT name, salary * 12 AS annual_salary
FROM Employees
ORDER BY annual_salary DESC;
```

👉 Aliases can be used in `ORDER BY`, even though not allowed in `WHERE`.

---

## 5️⃣ ORDER BY with Functions

You can sort by **computed expressions**:

```sql
-- Sort by length of employee names
SELECT name
FROM Employees
ORDER BY LENGTH(name);

-- Sort by year of hire
SELECT name, hire_date
FROM Employees
ORDER BY YEAR(hire_date);
```

👉 Useful when you don’t have a dedicated column but want derived sorting.

---

## 6️⃣ ORDER BY with CASE (Custom Sorting)

`CASE` lets you define **custom sort orders** not based on alphabet/number rules.

```sql
-- Custom sort: Active employees first, then inactive
SELECT name, is_active
FROM Employees
ORDER BY CASE WHEN is_active = TRUE THEN 1 ELSE 2 END;

-- Custom sort for department priority
SELECT name, dept_id
FROM Employees
ORDER BY 
  CASE dept_id
    WHEN 3 THEN 1   -- HR first
    WHEN 1 THEN 2   -- Sales second
    ELSE 3          -- Others later
  END;
```

👉 Very powerful when business rules require **non-natural ordering**.

---

## 7️⃣ Handling NULL Values in ORDER BY

* By default:

  * **MySQL** → `NULL` is considered **lowest value** (appears first in ASC, last in DESC).
  * **Oracle** → `NULLS LAST` by default.
  * **Postgres** → ASC → NULLS first, DESC → NULLS last.
* You can **explicitly control** with `NULLS FIRST` / `NULLS LAST` (Postgres, Oracle, SQL Server 2022+).

### Examples

```sql
-- Place NULLs last explicitly
SELECT name, manager_id
FROM Employees
ORDER BY manager_id ASC NULLS LAST;

-- Place NULLs first
SELECT name, manager_id
FROM Employees
ORDER BY manager_id DESC NULLS FIRST;
```

👉 In MySQL (which doesn’t support `NULLS FIRST/LAST`), use `CASE`:

```sql
-- MySQL way to push NULLs last
SELECT name, manager_id
FROM Employees
ORDER BY (manager_id IS NULL), manager_id;
```

Here `(manager_id IS NULL)` returns `1` for nulls and `0` for not null → ensures nulls are pushed to the end.

---

## 8️⃣ ORDER BY in Subqueries and LIMIT

Often combined with `LIMIT` / `TOP` for pagination or “Top N” queries.

```sql
-- Top 5 highest-paid employees
SELECT name, salary
FROM Employees
ORDER BY salary DESC
LIMIT 5;   -- MySQL/Postgres (SQL Server: TOP 5, Oracle: FETCH FIRST 5 ROWS ONLY)
```

---

# ✅ Summary Table

| Feature             | Example                                                                        |
| ------------------- | ------------------------------------------------------------------------------ |
| Single column       | `ORDER BY salary ASC`                                                          |
| Multiple columns    | `ORDER BY dept_id ASC, salary DESC`                                            |
| Aliases             | `ORDER BY annual_salary`                                                       |
| Functions           | `ORDER BY LENGTH(name)`                                                        |
| CASE (custom order) | `ORDER BY CASE dept_id WHEN 3 THEN 1 ELSE 2 END`                               |
| Handle NULLs        | `ORDER BY manager_id NULLS LAST` (or `ORDER BY (manager_id IS NULL)` in MySQL) |

---

👉 With this, you can sort **any dataset** exactly how you want — by natural order, computed expressions, or even business logic.

---

