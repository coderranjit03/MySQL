
---

# ⚡ **Transactions in SQL**

## 🔹 **Definition**

A **transaction** is a **sequence of one or more SQL statements** executed as a **single logical unit of work**.

* Either **all statements succeed**, or **none of them take effect**.
* Transactions ensure **data integrity** in the database.

**Analogy:** Think of a bank transfer:

* Deduct money from one account ✅
* Add money to another account ✅
  If any step fails, **the whole operation should be canceled**.

---

## 🔹 **Properties of Transactions – ACID**

Transactions are governed by the **ACID properties**:

| Property        | Description                                                                                         |
| --------------- | --------------------------------------------------------------------------------------------------- |
| **Atomicity**   | The transaction is **all-or-nothing**. If any part fails, the whole transaction is rolled back.     |
| **Consistency** | Database moves from one **valid state** to another, maintaining integrity constraints.              |
| **Isolation**   | Transactions execute **independently**, preventing interference from other concurrent transactions. |
| **Durability**  | Once a transaction is committed, its changes are **permanent**, even in case of system failure.     |

---

## 🔹 **Transaction States**

1. **Active:** Transaction has started; SQL statements are being executed.
2. **Partially Committed:** Last statement executed successfully but transaction not yet committed.
3. **Failed:** Error occurs; transaction cannot continue.
4. **Aborted (Rollback):** Database returns to previous consistent state.
5. **Committed:** All changes are permanent.

---

## 🔹 **SQL Commands for Transactions**

| Command                       | Description                                                             |
| ----------------------------- | ----------------------------------------------------------------------- |
| `START TRANSACTION` / `BEGIN` | Begin a new transaction.                                                |
| `COMMIT`                      | Save all changes made by the transaction permanently.                   |
| `ROLLBACK`                    | Undo changes made in the current transaction.                           |
| `SAVEPOINT`                   | Set a **marker** within a transaction to roll back to a specific point. |
| `RELEASE SAVEPOINT`           | Remove a previously defined savepoint.                                  |
| `SET TRANSACTION`             | Set isolation levels or transaction properties.                         |

---

## 🔹 **Transaction Isolation Levels**

Isolation determines how **concurrent transactions** interact. MySQL supports:

| Level                                  | Description                                                                 | Example Problems Prevented                                            |
| -------------------------------------- | --------------------------------------------------------------------------- | --------------------------------------------------------------------- |
| **READ UNCOMMITTED**                   | Transactions can read **uncommitted changes** from others.                  | Prevents nothing; may cause dirty reads.                              |
| **READ COMMITTED**                     | Can only read **committed data** from others.                               | Prevents dirty reads, but non-repeatable reads may occur.             |
| **REPEATABLE READ** (Default in MySQL) | Ensures multiple reads of same row within transaction **return same data**. | Prevents dirty reads & non-repeatable reads; phantom reads may occur. |
| **SERIALIZABLE**                       | Highest isolation; transactions execute **sequentially**.                   | Prevents dirty reads, non-repeatable reads, phantom reads.            |

---

## 🔹 **Types of Transaction Control**

1. **Implicit Transactions:**

   * Each SQL statement is a separate transaction (autocommit mode).
   * Default behavior in MySQL unless you disable autocommit.

2. **Explicit Transactions:**

   * You manually control transaction using `START TRANSACTION`, `COMMIT`, and `ROLLBACK`.

---

## 🔹 **Example Database Setup**

```sql
-- Create a bank database
CREATE DATABASE bank_db;
USE bank_db;

-- Create accounts table
CREATE TABLE accounts (
    account_id INT PRIMARY KEY,
    account_name VARCHAR(50),
    balance DECIMAL(10,2)
);

-- Insert sample data
INSERT INTO accounts VALUES 
(1, 'Alice', 5000.00),
(2, 'Bob', 3000.00);
```

---

## 🔹 **Example 1: Simple Transaction**

### Scenario: Transfer \$1000 from Alice to Bob

```sql
-- Start Transaction
START TRANSACTION;

-- Deduct from Alice
UPDATE accounts SET balance = balance - 1000 WHERE account_name = 'Alice';

-- Add to Bob
UPDATE accounts SET balance = balance + 1000 WHERE account_name = 'Bob';

-- Commit transaction
COMMIT;
```

✅ Result: Both updates happen together.
❌ If error occurs before `COMMIT`, nothing is updated.

---

## 🔹 **Example 2: Transaction with Rollback**

```sql
START TRANSACTION;

UPDATE accounts SET balance = balance - 6000 WHERE account_name = 'Alice';

-- Check for negative balance
SELECT balance FROM accounts WHERE account_name = 'Alice';
-- Suppose balance < 0, rollback
ROLLBACK;
```

✅ Result: Alice’s balance stays unchanged.

---

## 🔹 **Example 3: Using Savepoints**

```sql
START TRANSACTION;

UPDATE accounts SET balance = balance - 1000 WHERE account_name = 'Alice';
SAVEPOINT sp1;

UPDATE accounts SET balance = balance + 1000 WHERE account_name = 'Bob';

-- Suppose an error occurs here
ROLLBACK TO sp1;

-- Commit the rest
COMMIT;
```

* Only changes **before savepoint** are kept if you rollback to it.

---

## 🔹 **Advantages of Transactions**

* Ensures **data consistency and integrity**.
* Supports **complex operations** as a single unit.
* Allows recovery from **failures and errors**.
* Provides **concurrency control** in multi-user systems.

---

## 🔹 **Disadvantages**

* Can **reduce performance** due to locking and logging.
* Requires careful management of **isolation levels**.
* Overusing savepoints and nested transactions can **complicate logic**.

---

## 🔹 **Best Practices**

* Use **explicit transactions** for **critical operations** (banking, inventory, etc.).
* Avoid **long transactions** to reduce locks.
* Always handle **errors** with rollback.
* Set appropriate **isolation levels** based on use-case.

---

## 🔹 **Summary**

* **Transaction = atomic unit of work**.
* **ACID properties** ensure consistency, reliability, and durability.
* Commands: `START TRANSACTION`, `COMMIT`, `ROLLBACK`, `SAVEPOINT`.
* Crucial for **banking, e-commerce, inventory, and multi-user systems**.
* Can control **concurrency** via isolation levels.

---

