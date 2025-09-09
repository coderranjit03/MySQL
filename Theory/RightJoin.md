
---

# 🔗 RIGHT JOIN in SQL

## 📝 What is RIGHT JOIN?

* `RIGHT JOIN` (or **RIGHT OUTER JOIN**) returns **all rows from the right table** and the **matching rows from the left table**.
* If there is no match, NULL values are returned for columns from the left table.

👉 Think of it as:

* Keep **everything from the RIGHT table**,
* Fill missing data from the LEFT table with **NULL**.

---

## 📌 Syntax

```sql
SELECT columns
FROM table1
RIGHT JOIN table2
ON table1.common_column = table2.common_column;
```

* `table1` = left table
* `table2` = right table
* Keeps all rows from `table2` regardless of match

---

## 🎯 Key Points About RIGHT JOIN

1. Returns **all rows from right table**.
2. If no match → left table values = **NULL**.
3. Rarely used compared to `LEFT JOIN` (most people just swap table order and use LEFT JOIN).
4. Useful when right table is the **primary reference table**.

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

### Example 1: Basic RIGHT JOIN

```sql
SELECT b.title, a.first_name, a.last_name
FROM authors a
RIGHT JOIN books b
ON a.author_id = b.author_id;
```

✅ Output:

| title                    | first\_name | last\_name |
| ------------------------ | ----------- | ---------- |
| Pride and Prejudice      | Jane        | Austen     |
| 1984                     | George      | Orwell     |
| Animal Farm              | George      | Orwell     |
| The Old Man and the Sea  | Ernest      | Hemingway  |
| Murder on the Orient Exp | Agatha      | Christie   |
| Unknown Book             | NULL        | NULL       |

📌 Notice: `"Unknown Book"` has no matching author → shows NULL for author info.

---

### Example 2: RIGHT JOIN with Filtering

```sql
SELECT b.title, a.first_name, a.last_name
FROM authors a
RIGHT JOIN books b
ON a.author_id = b.author_id
WHERE a.author_id IS NULL;
```

✅ Output:

| title        | first\_name | last\_name |
| ------------ | ----------- | ---------- |
| Unknown Book | NULL        | NULL       |

📌 Returns only books without matching authors.

---

### Example 3: RIGHT JOIN with Aggregation

```sql
SELECT b.title, COUNT(a.author_id) AS matched_authors
FROM authors a
RIGHT JOIN books b
ON a.author_id = b.author_id
GROUP BY b.book_id;
```

✅ Output:

| title                    | matched\_authors |
| ------------------------ | ---------------- |
| Pride and Prejudice      | 1                |
| 1984                     | 1                |
| Animal Farm              | 1                |
| The Old Man and the Sea  | 1                |
| Murder on the Orient Exp | 1                |
| Unknown Book             | 0                |

📌 Shows how many authors matched each book.

---

## 🚀 When to Use RIGHT JOIN?

* When the **right table is your main reference table** and you don’t want to lose its rows.
* To find **unmatched rows** from the left table.
* For **data completeness checks** (e.g., all books should have an author).

---

## ❌ Limitations of RIGHT JOIN

1. Less commonly used (LEFT JOIN is preferred for readability).
2. Can confuse developers if tables are swapped incorrectly.
3. Same performance cost as LEFT JOIN (requires indexes for efficiency).

---

## 🧠 Key Takeaway

* `RIGHT JOIN` = **All rows from RIGHT table + matched rows from LEFT**.
* Missing matches on left side → **NULL values**.
* Useful when right table is the **priority dataset**.

---

