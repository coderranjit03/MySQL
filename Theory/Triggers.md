
---

# ⚡ Triggers in MySQL (Detailed)

## 🔹 What is a Trigger?

A **trigger** is a stored program in MySQL that executes **automatically** when a specific **INSERT**, **UPDATE**, or **DELETE** event occurs on a table.
Triggers ensure **automation, consistency, auditing, and business rule enforcement**.

---

## 🔹 Types of Triggers (6 total)

### 1️⃣ BEFORE INSERT Trigger

📘 **Theory**

* Fires **before new data is inserted** into the table.
* Used to **validate or modify values** before insertion.

📌 **Syntax**

```sql
CREATE TRIGGER trigger_name
BEFORE INSERT ON table_name
FOR EACH ROW
BEGIN
   -- logic before insert
END;
```

📌 **Example**
Automatically set a `created_at` timestamp:

```sql
CREATE TRIGGER before_insert_users
BEFORE INSERT ON users
FOR EACH ROW
BEGIN
   SET NEW.created_at = NOW();
END;
```

---

### 2️⃣ AFTER INSERT Trigger

📘 **Theory**

* Fires **after a new row is inserted**.
* Commonly used for **logging, notifications, and audits**.

📌 **Syntax**

```sql
CREATE TRIGGER trigger_name
AFTER INSERT ON table_name
FOR EACH ROW
BEGIN
   -- logic after insert
END;
```

📌 **Example**
Log newly created users:

```sql
CREATE TRIGGER after_insert_users
AFTER INSERT ON users
FOR EACH ROW
BEGIN
   INSERT INTO user_logs(user_id, action)
   VALUES (NEW.id, 'User Created');
END;
```

---

### 3️⃣ BEFORE UPDATE Trigger

📘 **Theory**

* Fires **before updating existing rows**.
* Used for **validations** (e.g., preventing unwanted changes).

📌 **Syntax**

```sql
CREATE TRIGGER trigger_name
BEFORE UPDATE ON table_name
FOR EACH ROW
BEGIN
   -- logic before update
END;
```

📌 **Example**
Prevent salary decrease:

```sql
CREATE TRIGGER before_update_salary
BEFORE UPDATE ON employees
FOR EACH ROW
BEGIN
   IF NEW.salary < OLD.salary THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Salary reduction is not allowed!';
   END IF;
END;
```

---

### 4️⃣ AFTER UPDATE Trigger

📘 **Theory**

* Fires **after updating data**.
* Used for **tracking changes** and **keeping history logs**.

📌 **Syntax**

```sql
CREATE TRIGGER trigger_name
AFTER UPDATE ON table_name
FOR EACH ROW
BEGIN
   -- logic after update
END;
```

📌 **Example**
Log salary changes:

```sql
CREATE TRIGGER after_update_salary
AFTER UPDATE ON employees
FOR EACH ROW
BEGIN
   INSERT INTO salary_logs(emp_id, old_salary, new_salary, updated_at)
   VALUES (OLD.emp_id, OLD.salary, NEW.salary, NOW());
END;
```

---

### 5️⃣ BEFORE DELETE Trigger

📘 **Theory**

* Fires **before a row is deleted**.
* Often used for **data integrity checks** (e.g., preventing accidental deletions).

📌 **Syntax**

```sql
CREATE TRIGGER trigger_name
BEFORE DELETE ON table_name
FOR EACH ROW
BEGIN
   -- logic before delete
END;
```

📌 **Example**
Prevent deleting admin accounts:

```sql
CREATE TRIGGER before_delete_admin
BEFORE DELETE ON users
FOR EACH ROW
BEGIN
   IF OLD.role = 'admin' THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Admins cannot be deleted!';
   END IF;
END;
```

---

### 6️⃣ AFTER DELETE Trigger

📘 **Theory**

* Fires **after a row is deleted**.
* Useful for **logging deleted data** or **archiving records**.

📌 **Syntax**

```sql
CREATE TRIGGER trigger_name
AFTER DELETE ON table_name
FOR EACH ROW
BEGIN
   -- logic after delete
END;
```

📌 **Example**
Archive deleted employees:

```sql
CREATE TRIGGER after_delete_employees
AFTER DELETE ON employees
FOR EACH ROW
BEGIN
   INSERT INTO deleted_employees(emp_id, name, deleted_at)
   VALUES (OLD.emp_id, OLD.name, NOW());
END;
```

---

## ✅ Summary Table

| Trigger Type      | When It Fires         | Use Case                   |
| ----------------- | --------------------- | -------------------------- |
| **BEFORE INSERT** | Before inserting data | Validate/modify input      |
| **AFTER INSERT**  | After inserting data  | Log or audit               |
| **BEFORE UPDATE** | Before updating data  | Prevent unwanted changes   |
| **AFTER UPDATE**  | After updating data   | Keep history/logs          |
| **BEFORE DELETE** | Before deleting data  | Block restricted deletions |
| **AFTER DELETE**  | After deleting data   | Archive or log             |

---

📌 **Key Notes**

* `NEW` → refers to new row values (`INSERT` / `UPDATE`).
* `OLD` → refers to old row values (`UPDATE` / `DELETE`).
* Triggers run **automatically** and ensure **business rules, logging, auditing, and consistency**.

---



## 🔹 Advantages

* ✅ Enforces business rules
* ✅ Useful for auditing & logging
* ✅ Cascades changes automatically

## 🔹 Disadvantages

* ⚠️ Can slow performance
* ⚠️ Debugging is harder (triggers run behind the scenes)
* ⚠️ Overuse may cause hidden dependencies

---

📌 **In short**:
Triggers = **automatic database reactions** to INSERT, UPDATE, or DELETE. Best for **logging, auditing, and enforcing rules**.

