

---

# 🔗 LEFT JOIN in SQL

## 📝 What is LEFT JOIN?

* `LEFT JOIN` (or **LEFT OUTER JOIN**) returns **all rows from the left table** and the **matching rows from the right table**.
* If there is no match, NULL values are returned for columns from the right table.

👉 Think of it as:

* Keep **everything from the LEFT table**,
* Fill missing data from the RIGHT table with **NULL**.

---

## 📌 Syntax

```sql
SELECT columns
FROM table1
LEFT JOIN table2
ON table1.common_column = table2.common_column;
```

* `table1` = left table (always preserved)
* `table2` = right table (only rows that match)

---

## 🎯 Key Points About LEFT JOIN

1. Returns **all rows from the left table**.
2. If no match → right table values = **NULL**.
3. Most commonly used JOIN in SQL.
4. Useful when left table is the **primary reference** dataset.

---

## 📊 Example

### Tables:

**Authors**

| author\_id | first\_name | last\_name |
| ---------- | ----------- | ---------- |
| 1          | Jane        | Austen     |
| 2          | George      | Orwell     |
| 3          | Ernest      | Hemingway  |
| 4          | Agatha      | Christie   |
| 5          | Mark        | Twain      |

**Books**

| book\_id | title                    | author\_id |
| -------- | ------------------------ | ---------- |
| 101      | Pride and Prejudice      | 1          |
| 102      | 1984                     | 2          |
| 103      | Animal Farm              | 2          |
| 104      | The Old Man and the Sea  | 3          |
| 105      | Murder on the Orient Exp | 4          |
| 106      | Unknown Book             | 99         |

---

### Example 1: Basic LEFT JOIN

```sql
SELECT a.first_name, a.last_name, b.title
FROM authors a
LEFT JOIN books b
ON a.author_id = b.author_id;
```

✅ Output:

| first\_name | last\_name | title                    |
| ----------- | ---------- | ------------------------ |
| Jane        | Austen     | Pride and Prejudice      |
| George      | Orwell     | 1984                     |
| George      | Orwell     | Animal Farm              |
| Ernest      | Hemingway  | The Old Man and the Sea  |
| Agatha      | Christie   | Murder on the Orient Exp |
| Mark        | Twain      | NULL                     |

📌 Notice: **Mark Twain** has no book → shows NULL for title.

---

### Example 2: Find Authors Without Books

```sql
SELECT a.first_name, a.last_name
FROM authors a
LEFT JOIN books b
ON a.author_id = b.author_id
WHERE b.book_id IS NULL;
```

✅ Output:

| first\_name | last\_name |
| ----------- | ---------- |
| Mark        | Twain      |

📌 Only authors without books are returned.

---

### Example 3: LEFT JOIN with Aggregation

```sql
SELECT a.first_name, a.last_name, COUNT(b.book_id) AS total_books
FROM authors a
LEFT JOIN books b
ON a.author_id = b.author_id
GROUP BY a.author_id;
```

✅ Output:

| first\_name | last\_name | total\_books |
| ----------- | ---------- | ------------ |
| Jane        | Austen     | 1            |
| George      | Orwell     | 2            |
| Ernest      | Hemingway  | 1            |
| Agatha      | Christie   | 1            |
| Mark        | Twain      | 0            |

📌 Shows number of books per author (including those with 0).

---

## 🚀 When to Use LEFT JOIN?

* When left table is your **main dataset**.
* To find **unmatched rows** from the left table.
* For **reporting** (e.g., all authors, even those without books).

---

## ❌ Limitations of LEFT JOIN

1. Can produce **many NULLs** if right table has fewer matches.
2. May require indexes on join columns for **performance**.
3. If not filtered properly, may cause **large outputs**.

---

## 🧠 Key Takeaway

* `LEFT JOIN` = **All rows from LEFT table + matched rows from RIGHT**.
* Missing matches on right side → **NULL values**.
* Very common for **data completeness checks** and reports.

---

