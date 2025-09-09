
-- Create database for triggers practice
CREATE DATABASE db_triggers;
USE db_triggers;

-- Users table
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    salary DECIMAL(10,2),
    created_at TIMESTAMP
);

-- Log table
CREATE TABLE user_logs (
    log_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    action VARCHAR(50),
    log_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Deleted users table
CREATE TABLE deleted_users (
    id INT,
    name VARCHAR(100),
    deleted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- BEFORE INSERT trigger: set created_at
DELIMITER //
CREATE TRIGGER before_insert_users
BEFORE INSERT ON users
FOR EACH ROW
BEGIN
   SET NEW.created_at = NOW();
END;
//
DELIMITER ;

-- AFTER INSERT trigger: log user creation
DELIMITER //
CREATE TRIGGER after_insert_users
AFTER INSERT ON users
FOR EACH ROW
BEGIN
   INSERT INTO user_logs(user_id, action)
   VALUES (NEW.id, 'User Created');
END;
//
DELIMITER ;

-- BEFORE UPDATE trigger: prevent salary reduction
DELIMITER //
CREATE TRIGGER before_update_salary
BEFORE UPDATE ON users
FOR EACH ROW
BEGIN
   IF NEW.salary < OLD.salary THEN
      SIGNAL SQLSTATE '45000'
      SET MESSAGE_TEXT = 'Salary reduction is not allowed!';
   END IF;
END;
//
DELIMITER ;

-- AFTER DELETE trigger: log deleted users
DELIMITER //
CREATE TRIGGER after_delete_users
AFTER DELETE ON users
FOR EACH ROW
BEGIN
   INSERT INTO deleted_users(id, name)
   VALUES (OLD.id, OLD.name);
END;
//
DELIMITER ;

-- Insert data to test
INSERT INTO users (name, salary) VALUES ('Alice', 5000);
INSERT INTO users (name, salary) VALUES ('Bob', 6000);

-- Update salary (valid)
UPDATE users SET salary = 7000 WHERE name = 'Alice';

-- Update salary (invalid, should fail)
-- UPDATE users SET salary = 4000 WHERE name = 'Alice';

-- Delete a user
DELETE FROM users WHERE name = 'Bob';

-- Check logs
SELECT * FROM user_logs;
SELECT * FROM deleted_users;
SELECT * FROM users;
