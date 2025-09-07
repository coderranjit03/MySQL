# 🐬 MySQL Learning Repository

[![GitHub Repo Size](https://img.shields.io/github/repo-size/<your-username>/MySQL)](https://github.com/<your-username>/MySQL)
[![License](https://img.shields.io/badge/license-MIT-green)](LICENSE)
[![Language](https://img.shields.io/badge/Language-SQL-blue)](https://www.mysql.com/)
[![Last Commit](https://img.shields.io/github/last-commit/<your-username>/MySQL)](https://github.com/<your-username>/MySQL)

A **comprehensive MySQL repository** combining **theory notes** and **practice SQL scripts** for learners, students, and interview preparation.

---

## 📂 Repository Overview

| Folder          | Description                          | Files                                                              | Last Update                                                                                    |
| --------------- | ------------------------------------ | ------------------------------------------------------------------ | ---------------------------------------------------------------------------------------------- |
| 📝 **Theory**   | Markdown notes covering SQL concepts | ![Theory files](https://img.shields.io/badge/files-10-brightgreen) | ![Last update](https://img.shields.io/github/last-commit/<your-username>/MySQL?label=Theory)   |
| 💻 **Practice** | SQL scripts for hands-on practice    | ![Practice files](https://img.shields.io/badge/files-8-blue)       | ![Last update](https://img.shields.io/github/last-commit/<your-username>/MySQL?label=Practice) |

---

## 📖 Table of Contents

### **📝 Theory**

* 🧩 [SQL\_DataTypes.md](Theory/SQL_DataTypes.md) – Overview of MySQL data types
* 🛠 [SQL\_Roadmap.md](Theory/SQL_Roadmap.md) – SQL learning roadmap
* 🔣 [Functions.md](Theory/Functions.md) – String, Numeric, Date, Aggregate functions
* ⚡ [Commands-Queries.md](Theory/Commands-Queries.md) – Basic SQL commands
* ⏱ [Limit\&Offset.md](Theory/Limit&Offset.md) – LIMIT & OFFSET explanation
* 📊 [Order\_By\_Clause.md](Theory/Order_By_Clause.md) – Sorting data with ORDER BY
* 🎭 [Aliases.md](Theory/Aliases.md) – Column and table aliases
* ✨ [Distinct.md](Theory/distinct.md) – DISTINCT keyword usage
* 📚 [SqlBasics.md](Theory/SqlBasics.md) – SQL basics and syntax
* 🖼 [image.png](Theory/image.png) – Visual representation of SQL concepts

### **💻 Practice**

* 🧩 [aliases.sql](Practice/aliases.sql) – Practice column/table aliases
* ✨ [distinct.sql](Practice/distinct.sql) – Practice DISTINCT queries
* 🔣 [functions.sql](Practice/functions.sql) – Practice SQL functions
* ⏱ [limit.sql](Practice/limit.sql) – LIMIT & OFFSET exercises
* ⚡ [logical\_ops.sql](Practice/logical_ops.sql) – Practice logical operators
* 📊 [order\_by.sql](Practice/oeder_by.sql) – Sorting queries
* 🔍 [select.sql](Practice/select.sql) – SELECT statements practice
* 🎯 [where\_clause.sql](Practice/where_clause.sql) – Filtering with WHERE

---

## 🎯 Purpose

* Designed for **students, beginners, and interview preparation**
* Combines **conceptual understanding** with **practical exercises**
* Helps learners **practice SQL queries effectively** while understanding theory

---

## 🛠 Technologies Used

* **MySQL** – for executing queries
* **Markdown** – for theory notes
* **SQL scripts** – for hands-on practice

---

## 🚀 How to Use

1. **Clone the repository**

```bash
git clone https://github.com/<your-username>/MySQL.git
```

2. **Explore Theory Notes**
   Open the `Theory` folder and read Markdown files to understand concepts.

3. **Practice SQL Scripts**
   Run SQL files from the `Practice` folder on your local MySQL server to practice queries.

---

## 💡 Example SQL Snippets

### **Select Query**

```sql
SELECT first_name, last_name
FROM employees
WHERE department = 'Sales';
```

### **Aggregate Function**

```sql
SELECT department, COUNT(*) AS emp_count
FROM employees
GROUP BY department;
```

### **Join Example**

```sql
SELECT e.first_name, d.department_name
FROM employees e
JOIN departments d ON e.department_id = d.department_id;
```

---

## 💡 Tips

* Commit often when modifying scripts or adding new theory notes.
* Combine reading theory with practicing SQL scripts for maximum understanding.
* Use this repository as a reference for interview preparation and self-study.
