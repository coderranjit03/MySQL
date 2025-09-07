
---

# 📘 LIMIT & OFFSET in SQL

These two clauses are used to **restrict and control** how many rows are returned in a query result.

---

## 1️⃣ LIMIT Clause

The `LIMIT` clause specifies **how many rows to return**.

```sql
-- Get top 5 employees with highest salaries
SELECT emp_id, name, salary
FROM Employees
ORDER BY salary DESC
LIMIT 5;
```

👉 Returns only **5 rows**, even if there are thousands of employees.

---

## 2️⃣ OFFSET Clause

The `OFFSET` clause tells SQL to **skip a certain number of rows** before returning results.
It’s usually combined with `LIMIT`.

```sql
-- Skip first 5 employees and return next 5
SELECT emp_id, name, salary
FROM Employees
ORDER BY salary DESC
LIMIT 5 OFFSET 5;
```

👉 This will return rows **6–10** from the result set.

---

## 3️⃣ Combining LIMIT & OFFSET (Pagination)

Pagination = **splitting large result sets into smaller “pages” of data.**
Common in websites (e.g., product listings, search results, dashboards).

Example: Page size = 10 rows

* **Page 1:**

  ```sql
  SELECT * FROM Employees
  ORDER BY emp_id
  LIMIT 10 OFFSET 0;   -- First 10 rows
  ```

* **Page 2:**

  ```sql
  SELECT * FROM Employees
  ORDER BY emp_id
  LIMIT 10 OFFSET 10;  -- Rows 11–20
  ```

* **Page 3:**

  ```sql
  SELECT * FROM Employees
  ORDER BY emp_id
  LIMIT 10 OFFSET 20;  -- Rows 21–30
  ```

👉 Formula for pagination:

```
OFFSET = (page_number - 1) * page_size
LIMIT = page_size
```

---

## 4️⃣ Example: Pagination in a Products Table

Suppose we have **100 products** and want to show **10 products per page**:

* **Page 1 (products 1–10):**

  ```sql
  SELECT * FROM Products
  ORDER BY product_id
  LIMIT 10 OFFSET 0;
  ```

* **Page 5 (products 41–50):**

  ```sql
  SELECT * FROM Products
  ORDER BY product_id
  LIMIT 10 OFFSET 40;
  ```

---

## 5️⃣ OFFSET vs FETCH (Standard SQL / Oracle / SQL Server)

Different RDBMS support different syntax:

* **MySQL & PostgreSQL:** use `LIMIT ... OFFSET ...`
* **SQL Server:** uses `OFFSET ... FETCH NEXT ... ROWS ONLY`
* **Oracle:** supports `OFFSET ... FETCH` (newer versions)

Example in SQL Server:

```sql
-- Page 2 with 10 rows per page
SELECT emp_id, name, salary
FROM Employees
ORDER BY emp_id
OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY;
```

---

## 6️⃣ Performance Considerations ⚡

* Using `OFFSET` with very high numbers (e.g., page 10000) can be **slow** because the database still has to **scan and skip** all earlier rows.
* Alternatives for better performance:

  * Use **keyset pagination** (`WHERE id > last_seen_id`) instead of OFFSET.
  * Example:

    ```sql
    -- Instead of OFFSET for next page
    SELECT * FROM Employees
    WHERE emp_id > 50
    ORDER BY emp_id
    LIMIT 10;
    ```

---

# ✅ Summary

| Clause                  | Purpose                | Example                                    |
| ----------------------- | ---------------------- | ------------------------------------------ |
| `LIMIT n`               | Returns first `n` rows | `LIMIT 5`                                  |
| `OFFSET n`              | Skips `n` rows         | `OFFSET 10`                                |
| Pagination              | Split data into pages  | `LIMIT 10 OFFSET 20` → Page 3 (rows 21–30) |
| SQL Server/Oracle style | `OFFSET … FETCH`       | `OFFSET 10 ROWS FETCH NEXT 10 ROWS ONLY`   |

---

⚡ **Use case:**

* E-commerce websites (show 10 products per page)
* Blogs (10 posts per page)
* Admin dashboards (users list)
* APIs (return limited results for performance)

---
