
---

# 🎯 SQL `DISTINCT` (Detailed Explanation)

## 🔹 What is `DISTINCT`?

* `DISTINCT` is used in SQL to **remove duplicate rows** from the result set.
* It ensures that only **unique values** (or unique combinations of values) are returned.
* Works on **one column** or **multiple columns**.

👉 Think of it as a filter that **collapses duplicates into one entry**.

---

## 🔹 Syntax

```sql
SELECT DISTINCT column1, column2, ...
FROM table_name
WHERE condition;
```

---

## 🔹 1. Basic Example (Single Column)

### Query:

```sql
SELECT DISTINCT department
FROM Employees;
```

### Employees Table:

| emp\_id | first\_name | department |
| ------- | ----------- | ---------- |
| 1       | John        | IT         |
| 2       | Alice       | HR         |
| 3       | Michael     | IT         |
| 4       | Sarah       | Finance    |
| 5       | David       | HR         |

### Output:

| department |
| ---------- |
| IT         |
| HR         |
| Finance    |

✅ Without `DISTINCT`, we would have repeated `IT` and `HR`.
✅ With `DISTINCT`, duplicates are removed.

---

## 🔹 2. Multiple Columns Example

### Query:

```sql
SELECT DISTINCT department, job_title
FROM Employees;
```

### Output:

| department | job\_title |
| ---------- | ---------- |
| IT         | Developer  |
| IT         | Tester     |
| HR         | Recruiter  |
| Finance    | Accountant |

✅ Here, `DISTINCT` considers the **combination of department + job\_title**.
Even if `IT` repeats, the pair `(IT, Developer)` and `(IT, Tester)` are unique.

---

## 🔹 3. `DISTINCT` with Expressions

### Query:

```sql
SELECT DISTINCT UPPER(department)
FROM Employees;
```

### Output:

| department |
| ---------- |
| IT         |
| HR         |
| FINANCE    |

✅ `DISTINCT` can be applied to **functions/expressions**, ensuring uniqueness after transformation.

---

## 🔹 4. `DISTINCT` with Aggregate Functions

### Query:

```sql
SELECT COUNT(DISTINCT department) AS unique_departments
FROM Employees;
```

### Output:

| unique\_departments |
| ------------------- |
| 3                   |

✅ Here, instead of just counting rows, we count **unique departments**.

---

## 🔹 5. `DISTINCT` vs `GROUP BY`

Both can remove duplicates, but they serve different purposes:

### Query with `DISTINCT`:

```sql
SELECT DISTINCT department
FROM Employees;
```

### Query with `GROUP BY`:

```sql
SELECT department
FROM Employees
GROUP BY department;
```

Both give the same unique department list.

✅ Difference:

* `DISTINCT` → only removes duplicates.
* `GROUP BY` → groups data, usually used with aggregates (`SUM`, `COUNT`, etc.).

---

## 🔹 6. Use Cases of `DISTINCT`

* Get unique list of categories, departments, products, users, etc.
* Remove duplicate entries from reports.
* Use with `COUNT` to find **number of unique values**.
* Clean results when joining tables causes duplicate rows.

---

## 🔹 Important Notes

* `DISTINCT` applies to the **entire row**, not just one column.
* Performance impact: `DISTINCT` requires sorting or hashing → can be slow on very large datasets.
* Sometimes `GROUP BY` is more efficient if you’re aggregating.

---

## 🔹 Quick Example (With & Without DISTINCT)

### Query Without DISTINCT:

```sql
SELECT department FROM Employees;
```

### Output:

| department |
| ---------- |
| IT         |
| HR         |
| IT         |
| Finance    |
| HR         |

---

### Query With DISTINCT:

```sql
SELECT DISTINCT department FROM Employees;
```

### Output:

| department |
| ---------- |
| IT         |
| HR         |
| Finance    |

---

⚡ **Key Takeaway:**
Use `DISTINCT` when you want **unique rows** in your result.
For aggregates → `COUNT(DISTINCT col)` helps avoid overcounting.
For grouping + calculations → prefer `GROUP BY`.

---

