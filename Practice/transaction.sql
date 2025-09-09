

-- =============================================
-- MySQL Transactions Practice
-- =============================================

-- Create database
CREATE DATABASE IF NOT EXISTS bank_db;
USE bank_db;

-- Create accounts table
CREATE TABLE IF NOT EXISTS accounts (
    account_id INT PRIMARY KEY AUTO_INCREMENT,
    account_name VARCHAR(50),
    balance DECIMAL(10,2)
);

-- Insert sample data
INSERT INTO accounts (account_name, balance) VALUES
('Alice', 5000.00),
('Bob', 3000.00);

-- =============================================
-- Example 1: Simple Transaction
-- Transfer 1000 from Alice to Bob
-- =============================================
START TRANSACTION;

UPDATE accounts SET balance = balance - 1000 WHERE account_name = 'Alice';
UPDATE accounts SET balance = balance + 1000 WHERE account_name = 'Bob';

COMMIT;

-- Check result
SELECT * FROM accounts;

-- =============================================
-- Example 2: Transaction with Rollback
-- =============================================
START TRANSACTION;

UPDATE accounts SET balance = balance - 6000 WHERE account_name = 'Alice';

-- Check for negative balance
SELECT balance FROM accounts WHERE account_name = 'Alice';

-- Rollback due to insufficient funds
ROLLBACK;

-- Check result
SELECT * FROM accounts;

-- =============================================
-- Example 3: Using Savepoints
-- =============================================
START TRANSACTION;

UPDATE accounts SET balance = balance - 500 WHERE account_name = 'Alice';
SAVEPOINT sp1;

UPDATE accounts SET balance = balance + 500 WHERE account_name = 'Bob';

-- Suppose an error occurs here
ROLLBACK TO sp1;

-- Commit the rest
COMMIT;

-- Check final balances
SELECT * FROM accounts;
