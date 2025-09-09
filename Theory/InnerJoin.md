
---

# 🔗 INNER JOIN in SQL

## 📝 What is INNER JOIN?

* `INNER JOIN` is the **most common type of join** in SQL.
* It **returns only the rows where there is a match in both tables** based on a join condition.
* Rows that do **not satisfy the condition** are excluded from the result set.

👉 Think of it as the **intersection** of two tables in set theory.

---

## 📌 Syntax

```sql
SELECT columns
FROM table1
INNER JOIN table2
ON table1.common_column = table2.common_column;
```

* `INNER JOIN` → keyword used to combine rows.
* `ON` → specifies the join condition.
* `common_column` → must exist in both tables and be logically related (often foreign key ↔ primary key).

---

## 🎯 Key Points About INNER JOIN

1. Returns **only matching rows**.
2. If no match → row is **excluded**.
3. Multiple tables can be joined using multiple `INNER JOIN`s.
4. Join condition can include additional filters (e.g., date ranges, numeric conditions).
5. `INNER JOIN` can be written as `JOIN` (default).

---

## 📊 Example

### Tables:

**Authors**

| author\_id | first\_name | last\_name | birth\_year |
| ---------- | ----------- | ---------- | ----------- |
| 1          | Jane        | Austen     | 1775        |
| 2          | George      | Orwell     | 1903        |
| 3          | Ernest      | Hemingway  | 1899        |
| 4          | Agatha      | Christie   | 1890        |

**Books**

| book\_id | title                    | author\_id | publication\_year |
| -------- | ------------------------ | ---------- | ----------------- |
| 101      | Pride and Prejudice      | 1          | 1813              |
| 102      | 1984                     | 2          | 1949              |
| 103      | Animal Farm              | 2          | 1945              |
| 104      | The Old Man and the Sea  | 3          | 1952              |
| 105      | Murder on the Orient Exp | 4          | 1934              |

---

### Example 1: Basic INNER JOIN

```sql
SELECT b.title, a.first_name, a.last_name
FROM books b
INNER JOIN authors a
ON b.author_id = a.author_id;
```

✅ Output:

| title                    | first\_name | last\_name |
| ------------------------ | ----------- | ---------- |
| Pride and Prejudice      | Jane        | Austen     |
| 1984                     | George      | Orwell     |
| Animal Farm              | George      | Orwell     |
| The Old Man and the Sea  | Ernest      | Hemingway  |
| Murder on the Orient Exp | Agatha      | Christie   |

🔎 Only books **with matching authors** are included. If a book had an unknown `author_id`, it would be excluded.

---

### Example 2: INNER JOIN with `WHERE`

```sql
SELECT b.title, a.first_name, a.last_name, a.birth_year
FROM books b
INNER JOIN authors a
ON b.author_id = a.author_id
WHERE b.publication_year > 1940;
```

✅ Output:

| title                   | first\_name | last\_name | birth\_year |
| ----------------------- | ----------- | ---------- | ----------- |
| 1984                    | George      | Orwell     | 1903        |
| Animal Farm             | George      | Orwell     | 1903        |
| The Old Man and the Sea | Ernest      | Hemingway  | 1899        |

📌 Only books published **after 1940** are shown.

---

### Example 3: INNER JOIN with Aggregation

```sql
SELECT a.first_name, a.last_name, COUNT(b.book_id) AS book_count
FROM authors a
INNER JOIN books b
ON a.author_id = b.author_id
GROUP BY a.author_id;
```

✅ Output:

| first\_name | last\_name | book\_count |
| ----------- | ---------- | ----------- |
| Jane        | Austen     | 1           |
| George      | Orwell     | 2           |
| Ernest      | Hemingway  | 1           |
| Agatha      | Christie   | 1           |

📌 Shows **how many books each author wrote**.

---

## 🚀 When to Use INNER JOIN?

* When you only care about **rows with matching data** in both tables.
* For enforcing **referential integrity** (e.g., students ↔ courses).
* To fetch **related data across multiple tables**.

---

## ❌ Limitations of INNER JOIN

1. Rows without matches are **lost** (excluded).

   * To include unmatched rows, use `LEFT JOIN` or `RIGHT JOIN`.
2. Can produce **large result sets** if tables are big (performance concern).
3. Requires proper **indexes** on join columns for efficiency.

---

## 🧠 Key Takeaway

* `INNER JOIN` = **intersection** of two tables.
* Best for cases where **only matching rows are meaningful**.
* Simple, efficient, and most commonly used join in SQL.

---

