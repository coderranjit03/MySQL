
---

# ⚡ **Window Functions in SQL (MySQL 8.0+)**

---

## 🔹 **What is a Window Function?**

A **window function** performs a **calculation across a set of rows** related to the current row (a "window" of rows).
Unlike **aggregate functions** (`SUM`, `AVG`, etc.) that collapse rows into a single result, **window functions keep each row while adding calculated values**.

👉 They are used for **ranking, running totals, moving averages, percentages, comparisons, etc.**

---

## 🔹 **Basic Syntax**

```sql
function_name (expression) 
OVER (
    [PARTITION BY column]
    [ORDER BY column]
    [ROWS or RANGE frame_spec]
)
```

### Explanation:

* **`function_name`** → e.g., `SUM`, `AVG`, `ROW_NUMBER`, `RANK`.
* **`OVER()`** → defines the "window" of rows the function applies to.
* **`PARTITION BY`** → divides rows into groups (like `GROUP BY` but without collapsing).
* **`ORDER BY`** → defines the order inside each partition.
* **Frame clause (`ROWS` / `RANGE`)** → defines how many rows are included in the calculation window (optional).

---

## 🔹 **Types of Window Functions**

### 1. **Aggregate Window Functions**

Apply aggregate functions but without collapsing rows.
Examples: `SUM()`, `AVG()`, `COUNT()`, `MIN()`, `MAX()`.

```sql
SELECT 
    department,
    employee_name,
    salary,
    SUM(salary) OVER (PARTITION BY department) AS dept_total_salary,
    AVG(salary) OVER (PARTITION BY department) AS dept_avg_salary
FROM employees;
```

✅ Each row still exists, but shows department totals & averages.

---

### 2. **Ranking Functions**

Used to assign ranks or row numbers.

* **ROW\_NUMBER()** → Sequential row number (no duplicates).
* **RANK()** → Same rank for ties, next rank is skipped.
* **DENSE\_RANK()** → Same rank for ties, next rank is continuous.
* **NTILE(n)** → Divides rows into `n` buckets.

```sql
SELECT 
    employee_name,
    department,
    salary,
    ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) AS row_num,
    RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS rank_num,
    DENSE_RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS dense_rank,
    NTILE(3) OVER (ORDER BY salary DESC) AS quartile
FROM employees;
```

---

### 3. **Value Functions**

Access values from other rows.

* **LAG(expression, offset, default)** → Get value from a **previous row**.
* **LEAD(expression, offset, default)** → Get value from a **next row**.
* **FIRST\_VALUE(expression)** → First value in partition.
* **LAST\_VALUE(expression)** → Last value in partition.

```sql
SELECT
    employee_name,
    salary,
    LAG(salary, 1) OVER (ORDER BY salary) AS prev_salary,
    LEAD(salary, 1) OVER (ORDER BY salary) AS next_salary,
    FIRST_VALUE(salary) OVER (PARTITION BY department ORDER BY salary) AS lowest_salary,
    LAST_VALUE(salary) OVER (PARTITION BY department ORDER BY salary RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) AS highest_salary
FROM employees;
```

---

### 4. **Cumulative and Moving Aggregates**

Using **frame clauses** with aggregates.

#### **Cumulative Total**

```sql
SELECT
    employee_name,
    salary,
    SUM(salary) OVER (ORDER BY employee_id ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
FROM employees;
```

#### **Moving Average (Last 3 Rows)**

```sql
SELECT
    employee_name,
    salary,
    AVG(salary) OVER (ORDER BY employee_id ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS moving_avg
FROM employees;
```

---

## 🔹 **Frame Clauses (ROWS vs RANGE)**

| Clause                                                        | Meaning                       |
| ------------------------------------------------------------- | ----------------------------- |
| **ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW**          | From first row to current row |
| **ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING**                  | Sliding window of 3 rows      |
| **RANGE BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING** | Whole partition               |

📌 **ROWS vs RANGE difference:**

* **ROWS** → exact number of rows.
* **RANGE** → based on value range (ties may include multiple rows).

---

## 🔹 **Example Dataset**

```sql
CREATE TABLE employees (
    emp_id INT,
    employee_name VARCHAR(50),
    department VARCHAR(50),
    salary INT
);

INSERT INTO employees VALUES
(1, 'Alice', 'HR', 4000),
(2, 'Bob', 'HR', 4500),
(3, 'Charlie', 'HR', 4500),
(4, 'David', 'IT', 6000),
(5, 'Eva', 'IT', 7000),
(6, 'Frank', 'IT', 6500),
(7, 'Grace', 'Finance', 5000),
(8, 'Helen', 'Finance', 5200);
```

---

## 🔹 **When to Use Window Functions**

* ✅ Finding **running totals**
* ✅ Calculating **moving averages**
* ✅ Generating **row numbers or rankings**
* ✅ Comparing row values (**previous vs next**)
* ✅ Calculating **percentiles and quartiles**
* ✅ Avoiding subqueries for performance

---

## 🔹 **Advantages**

* Powerful analytics without collapsing rows.
* Cleaner queries compared to self-joins.
* Optimized for performance (esp. in MySQL 8+).

## 🔹 **Limitations**

* Not available in MySQL < 8.0.
* Cannot be used in `WHERE` clause directly (use subquery/CTE).
* More resource-heavy with large datasets.

---

## ✅ **Summary**

Window functions = **advanced SQL functions** for analytics.

* Types: **Aggregate, Ranking, Value, Cumulative**
* Key tools: `OVER()`, `PARTITION BY`, `ORDER BY`, `ROWS/RANGE`
* Best for analytics like **running totals, ranks, moving averages, percentiles**.

---