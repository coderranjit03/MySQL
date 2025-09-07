
# 📘 SQL Data Types (Detailed Notes)

Data types in SQL define the **kind of data** that can be stored in a column. Choosing the right data type ensures efficiency, accuracy, and consistency.

---

## 1️⃣ Numeric Data Types

### 🔹 Integer Types
- **INT / INTEGER** → Whole numbers (-2,147,483,648 to 2,147,483,647)
- **SMALLINT** → Smaller range integers (-32,768 to 32,767)
- **BIGINT** → Very large integers (up to ±9 quintillion)
- **TINYINT** → Very small integers (0 to 255 in MySQL)

✅ **Use Case:**  
- `INT` → Student ID, Employee ID  
- `BIGINT` → Bank account numbers, population count  
- `TINYINT` → Boolean flags (0 = false, 1 = true)

```sql
CREATE TABLE Employees (
    emp_id INT PRIMARY KEY,
    is_active TINYINT DEFAULT 1
);
```

---

### 🔹 Decimal / Floating Types
- **DECIMAL(p,s) / NUMERIC(p,s)** → Fixed precision numbers  
  - `p` = precision (total digits), `s` = scale (digits after decimal)
- **FLOAT / REAL** → Approximate floating-point numbers (less precise, faster)
- **DOUBLE / DOUBLE PRECISION** → Higher precision floating-point numbers

✅ **Use Case:**  
- `DECIMAL` → Storing currency (e.g., `DECIMAL(10,2)` → up to 99999999.99)  
- `FLOAT` → Scientific calculations where slight rounding is okay

```sql
CREATE TABLE Products (
    price DECIMAL(8,2),
    weight FLOAT
);
```

---

## 2️⃣ Character / String Data Types

- **CHAR(n)** → Fixed-length string (always uses `n` characters)  
- **VARCHAR(n)** → Variable-length string (up to `n` characters)  
- **TEXT / CLOB** → Large text (paragraphs, documents)  
- **ENUM** (MySQL only) → Predefined list of values  
- **SET** (MySQL only) → Multiple choice from predefined values

✅ **Use Case:**  
- `CHAR(10)` → Storing fixed codes (like country codes "IND", "USA")  
- `VARCHAR(255)` → Names, addresses, emails  
- `TEXT` → Storing blog posts or descriptions  
- `ENUM('Male','Female','Other')` → Gender column  

```sql
CREATE TABLE Students (
    name VARCHAR(100),
    gender ENUM('Male','Female','Other')
);
```

---

## 3️⃣ Date and Time Data Types

- **DATE** → Stores only date (YYYY-MM-DD)  
- **TIME** → Stores only time (HH:MM:SS)  
- **DATETIME** → Stores both date and time  
- **TIMESTAMP** → Stores date & time with timezone info (auto updates)  
- **YEAR** → Stores year in 4-digit format  

✅ **Use Case:**  
- `DATE` → Birth date, joining date  
- `DATETIME` → Logging events (2025-09-07 18:30:00)  
- `TIMESTAMP` → Track last updated records  

```sql
CREATE TABLE Orders (
    order_id INT PRIMARY KEY,
    order_date DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

---

## 4️⃣ Boolean Data Type

- **BOOLEAN / BOOL** → Stores `TRUE` or `FALSE` (internally stored as `TINYINT` in MySQL).  

✅ **Use Case:**  
- Active/inactive status, yes/no flags

```sql
CREATE TABLE Users (
    user_id INT PRIMARY KEY,
    is_admin BOOLEAN DEFAULT FALSE
);
```

---

## 5️⃣ Binary Data Types

- **BLOB (Binary Large Object)** → Stores images, videos, audio, PDFs  
- **BINARY(n)** → Fixed-length binary data  
- **VARBINARY(n)** → Variable-length binary data  

✅ **Use Case:**  
- Storing images, digital signatures, encrypted passwords

```sql
CREATE TABLE Files (
    file_id INT PRIMARY KEY,
    file_data BLOB
);
```

---

## 6️⃣ Special Data Types

- **JSON** → Stores JSON data (MySQL 5.7+, PostgreSQL supported)  
- **XML** → Stores XML data (Oracle, SQL Server)  
- **UUID / UNIQUEIDENTIFIER** → Unique values across systems (used for distributed systems)  
- **GEOMETRY / POINT** → Stores spatial data (GIS applications)  

✅ **Use Case:**  
- `JSON` → Storing API responses or flexible data structures  
- `UUID` → Instead of numeric IDs in distributed databases  
- `GEOMETRY` → Mapping apps (coordinates, shapes)

```sql
CREATE TABLE Configurations (
    config_id UUID PRIMARY KEY,
    config_data JSON
);
```

---

# 🔑 Summary Table

| Data Type Category | Examples | Use Cases |
|--------------------|----------|-----------|
| Numeric            | INT, BIGINT, DECIMAL, FLOAT | IDs, money, measurements |
| String             | CHAR, VARCHAR, TEXT, ENUM | Names, descriptions, categories |
| Date/Time          | DATE, TIME, TIMESTAMP | Birthdays, logs, events |
| Boolean            | BOOLEAN, TINYINT(1) | Flags, status, true/false |
| Binary             | BLOB, VARBINARY | Images, files, encrypted data |
| Special            | JSON, UUID, GEOMETRY | APIs, distributed IDs, spatial data |

---

# ✅ Key Notes
- Use **INT** for IDs (auto increment).  
- Use **DECIMAL** for money (not FLOAT due to rounding errors).  
- Use **VARCHAR** for names, emails, and variable text.  
- Use **TEXT** for long content like blogs.  
- Use **TIMESTAMP** for audit trails (last modified, created at).  
- Use **BLOB** for storing media files.  
- Use **JSON** when schema flexibility is required.

