
---

# 🔗 SELF JOIN in SQL

## 📝 What is a SELF JOIN?

* A **SELF JOIN** is a regular join where a table is **joined with itself**.
* The table is treated as **two different tables** by using **aliases**.
* It is useful when you want to **compare rows in the same table**.

👉 Think of it as:

* “Join a table with itself to find relationships within the same dataset.”

---

## 📌 Syntax

```sql
SELECT a.column1, b.column2
FROM table_name a
JOIN table_name b
ON a.common_column = b.related_column;
```

* `a` and `b` are **aliases** for the same table.
* You must use aliases, otherwise SQL cannot distinguish between the two references.

---

## 📊 Example

### Table: **employees**

| emp\_id | emp\_name | manager\_id |
| ------- | --------- | ----------- |
| 1       | Alice     | NULL        |
| 2       | Bob       | 1           |
| 3       | Charlie   | 1           |
| 4       | David     | 2           |
| 5       | Emma      | 2           |

---

### Example 1: Find Employees with Their Managers

```sql
SELECT e1.emp_name AS employee, 
       e2.emp_name AS manager
FROM employees e1
LEFT JOIN employees e2
ON e1.manager_id = e2.emp_id;
```

✅ Output:

| employee | manager |
| -------- | ------- |
| Alice    | NULL    |
| Bob      | Alice   |
| Charlie  | Alice   |
| David    | Bob     |
| Emma     | Bob     |

📌 Explanation:

* `employees e1` → employees table as **employee**.
* `employees e2` → same table as **manager**.
* Join condition: `e1.manager_id = e2.emp_id`.

---

### Example 2: Find Colleagues with the Same Manager

```sql
SELECT e1.emp_name AS employee1, 
       e2.emp_name AS employee2, 
       e1.manager_id
FROM employees e1
JOIN employees e2
ON e1.manager_id = e2.manager_id
AND e1.emp_id < e2.emp_id;
```

✅ Output:

| employee1 | employee2 | manager\_id |
| --------- | --------- | ----------- |
| Bob       | Charlie   | 1           |
| David     | Emma      | 2           |

📌 Explanation:

* Both employees share the same `manager_id`.
* `e1.emp_id < e2.emp_id` avoids duplicate pairs (Bob-Charlie and Charlie-Bob).

---

### Example 3: Hierarchical Data (Find Manager Chain)

If we want to see a chain of managers (like David → Bob → Alice):

```sql
SELECT e1.emp_name AS employee, 
       e2.emp_name AS direct_manager, 
       e3.emp_name AS top_manager
FROM employees e1
LEFT JOIN employees e2 ON e1.manager_id = e2.emp_id
LEFT JOIN employees e3 ON e2.manager_id = e3.emp_id;
```

✅ Output:

| employee | direct\_manager | top\_manager |
| -------- | --------------- | ------------ |
| David    | Bob             | Alice        |
| Emma     | Bob             | Alice        |
| Charlie  | Alice           | NULL         |
| Bob      | Alice           | NULL         |
| Alice    | NULL            | NULL         |

---

## 🚀 When to Use SELF JOIN?

* Finding **manager-employee relationships**.
* Identifying **hierarchies** (org charts, family trees, category trees).
* Comparing **rows within the same table**.
* Detecting **duplicates or relationships** within a dataset.

---

## ❌ Limitations

1. Can become complex with multiple levels of hierarchy.
2. Requires careful use of **aliases**.
3. Performance may suffer with large datasets if not indexed properly.

---

## 🧠 Key Takeaway

* `SELF JOIN` = join a table with itself using aliases.
* Very useful for hierarchical or relationship-based queries.
* Needs good indexing on self-referencing columns (like `manager_id`).

---

