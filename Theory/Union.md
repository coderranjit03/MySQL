

# 🔗 UNION vs UNION ALL in SQL

## 📝 What are UNION and UNION ALL?

Both `UNION` and `UNION ALL` are used to **combine the result sets** of two or more `SELECT` queries.

* Each query must have the **same number of columns**.
* The columns must have **compatible data types**.
* The column names in the final result are taken from the **first SELECT** statement.

---

## 📌 Difference Between UNION and UNION ALL

| Feature         | UNION ✅                                  | UNION ALL ⚡                                      |
| --------------- | ---------------------------------------- | ------------------------------------------------ |
| **Duplicates**  | Removes duplicates (DISTINCT)            | Keeps duplicates                                 |
| **Performance** | Slower (extra step to remove duplicates) | Faster (no deduplication)                        |
| **Use case**    | When you need a unique combined dataset  | When you need all results (including duplicates) |

---

## 📊 Example

### Tables

**table1**

| id | name    |
| -- | ------- |
| 1  | Alice   |
| 2  | Bob     |
| 3  | Charlie |

**table2**

| id | name    |
| -- | ------- |
| 2  | Bob     |
| 3  | Charlie |
| 4  | David   |

---

### Example 1: UNION (removes duplicates)

```sql
SELECT name FROM table1
UNION
SELECT name FROM table2;
```

✅ Output:

| name    |
| ------- |
| Alice   |
| Bob     |
| Charlie |
| David   |

📌 Here, duplicates (`Bob`, `Charlie`) are removed automatically.

---

### Example 2: UNION ALL (keeps duplicates)

```sql
SELECT name FROM table1
UNION ALL
SELECT name FROM table2;
```

✅ Output:

| name    |
| ------- |
| Alice   |
| Bob     |
| Charlie |
| Bob     |
| Charlie |
| David   |

📌 Here, `Bob` and `Charlie` appear **twice** because they exist in both tables.

---

### Example 3: Using UNION with ORDER BY

```sql
SELECT name FROM table1
UNION
SELECT name FROM table2
ORDER BY name;
```

✅ Output: Sorted list of unique names:
`Alice, Bob, Charlie, David`

📌 Note: `ORDER BY` must be applied **after the final UNION**, not inside each SELECT.

---

### Example 4: UNION with Different Columns (same number of columns required)

```sql
SELECT id, name FROM table1
UNION
SELECT id, name FROM table2;
```

✅ Works fine because both queries return **2 columns** of the same type.

But ❌ this will fail:

```sql
SELECT id FROM table1
UNION
SELECT id, name FROM table2;
```

Error: *"Operand should contain 1 column(s)"*

---

## 🚀 When to Use?

* **UNION** → When you want a **distinct merged result** (removes duplicates).
* **UNION ALL** → When you want **all rows** (including duplicates) for analysis, performance, or when duplicates are meaningful.

---

## 🧠 Key Takeaways

* `UNION` = Merge results + **remove duplicates**.
* `UNION ALL` = Merge results + **keep duplicates**.
* Both require the **same number of columns** with **compatible data types**.
* `UNION ALL` is usually **faster** because it skips deduplication.

---

