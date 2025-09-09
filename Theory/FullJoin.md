

# 🔗 FULL JOIN in MySQL

## ✅ MySQL Syntax for FULL JOIN

```sql
SELECT columns
FROM table1
LEFT JOIN table2
ON table1.common_column = table2.common_column

UNION

SELECT columns
FROM table1
RIGHT JOIN table2
ON table1.common_column = table2.common_column;
```

---

## 📊 Example with Authors & Books

### Tables:

**authors**

| author\_id | first\_name | last\_name |
| ---------- | ----------- | ---------- |
| 1          | Jane        | Austen     |
| 2          | George      | Orwell     |
| 3          | Ernest      | Hemingway  |
| 4          | Agatha      | Christie   |
| 5          | Mark        | Twain      |

**books**

| book\_id | title                    | author\_id |
| -------- | ------------------------ | ---------- |
| 101      | Pride and Prejudice      | 1          |
| 102      | 1984                     | 2          |
| 103      | Animal Farm              | 2          |
| 104      | The Old Man and the Sea  | 3          |
| 105      | Murder on the Orient Exp | 4          |
| 106      | Unknown Book             | 99         |

---

### Example 1: FULL JOIN in MySQL

```sql
SELECT a.first_name, a.last_name, b.title
FROM authors a
LEFT JOIN books b ON a.author_id = b.author_id

UNION

SELECT a.first_name, a.last_name, b.title
FROM authors a
RIGHT JOIN books b ON a.author_id = b.author_id;
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
| NULL        | NULL       | Unknown Book             |

---

### Example 2: Find Only Non-Matching Rows

```sql
SELECT a.first_name, a.last_name, b.title
FROM authors a
LEFT JOIN books b ON a.author_id = b.author_id
WHERE b.book_id IS NULL

UNION

SELECT a.first_name, a.last_name, b.title
FROM authors a
RIGHT JOIN books b ON a.author_id = b.author_id
WHERE a.author_id IS NULL;
```

✅ Output:

| first\_name | last\_name | title        |
| ----------- | ---------- | ------------ |
| Mark        | Twain      | NULL         |
| NULL        | NULL       | Unknown Book |

📌 This gives only rows where **no match exists**.

---

⚡ So in **MySQL**, you’ll always write FULL JOIN like this:
👉 `LEFT JOIN ... UNION ... RIGHT JOIN`

---

