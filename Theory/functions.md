
---

# **SQL Functions – Complete Guide**

---

## **1. STRING FUNCTIONS**

**Theory:**
String functions manipulate textual data. They help in formatting, extracting, searching, or modifying strings.

| Function                     | Theory                                                               | Example                                        | Output        |
| ---------------------------- | -------------------------------------------------------------------- | ---------------------------------------------- | ------------- |
| `CONCAT()`                   | Combines two or more strings into one.                               | `SELECT CONCAT('Hello', ' ', 'World');`        | `Hello World` |
| `LENGTH()` / `CHAR_LENGTH()` | Returns the number of characters in a string.                        | `SELECT LENGTH('Hello');`                      | `5`           |
| `UPPER()`                    | Converts a string to uppercase.                                      | `SELECT UPPER('hello');`                       | `HELLO`       |
| `LOWER()`                    | Converts a string to lowercase.                                      | `SELECT LOWER('HELLO');`                       | `hello`       |
| `SUBSTRING()` / `SUBSTR()`   | Extracts part of a string from a specific position.                  | `SELECT SUBSTRING('Hello World',7,5);`         | `World`       |
| `TRIM()`                     | Removes leading and trailing spaces from a string.                   | `SELECT TRIM('   Hello   ');`                  | `Hello`       |
| `REPLACE()`                  | Replaces a substring with another string.                            | `SELECT REPLACE('Hello World','World','SQL');` | `Hello SQL`   |
| `LEFT()`                     | Returns a specified number of characters from the start of a string. | `SELECT LEFT('Hello',3);`                      | `Hel`         |
| `RIGHT()`                    | Returns a specified number of characters from the end of a string.   | `SELECT RIGHT('Hello',2);`                     | `lo`          |
| `INSTR()` / `LOCATE()`       | Finds the position of a substring in a string.                       | `SELECT INSTR('Hello World','World');`         | `7`           |
| `REVERSE()`                  | Reverses the string.                                                 | `SELECT REVERSE('Hello');`                     | `olleH`       |
| `LPAD()` / `RPAD()`          | Pads a string with characters on left/right.                         | `SELECT LPAD('Hi',5,'*');`                     | `***Hi`       |

**Use cases:** Data cleaning, formatting names, preparing dynamic text reports.

---

## **2. NUMERIC FUNCTIONS**

**Theory:**
Numeric functions operate on numbers, performing calculations, rounding, power, and trigonometric operations.

| Function                    | Theory                                       | Example                   | Output   |
| --------------------------- | -------------------------------------------- | ------------------------- | -------- |
| `ABS()`                     | Returns absolute value of a number.          | `SELECT ABS(-10);`        | `10`     |
| `ROUND(num, decimals)`      | Rounds a number to specified decimal places. | `SELECT ROUND(12.567,2);` | `12.57`  |
| `CEIL()` / `CEILING()`      | Returns smallest integer ≥ number.           | `SELECT CEIL(12.3);`      | `13`     |
| `FLOOR()`                   | Returns largest integer ≤ number.            | `SELECT FLOOR(12.7);`     | `12`     |
| `POWER(x,y)`                | Returns x raised to the power of y.          | `SELECT POWER(2,3);`      | `8`      |
| `SQRT()`                    | Returns the square root of a number.         | `SELECT SQRT(16);`        | `4`      |
| `MOD(x,y)`                  | Returns remainder of x divided by y.         | `SELECT MOD(10,3);`       | `1`      |
| `RAND()`                    | Returns a random decimal between 0 and 1.    | `SELECT RAND();`          | `0.7312` |
| `EXP()`                     | Returns e raised to the power x.             | `SELECT EXP(2);`          | `7.389`  |
| `LOG()`                     | Returns natural logarithm.                   | `SELECT LOG(10);`         | `2.302`  |
| `LOG10()`                   | Returns logarithm base 10.                   | `SELECT LOG10(100);`      | `2`      |
| `SIN()` / `COS()` / `TAN()` | Trigonometric functions in radians.          | `SELECT SIN(PI()/2);`     | `1`      |

**Use cases:** Mathematical calculations, statistical operations, financial computations.

---

## **3. DATE & TIME FUNCTIONS**

**Theory:**
Date functions allow manipulation and extraction of date/time information, calculating differences, formatting, and conversions.

| Function                          | Theory                                                        | Example                                                | Output                       |
| --------------------------------- | ------------------------------------------------------------- | ------------------------------------------------------ | ---------------------------- |
| `NOW()` / `CURRENT_TIMESTAMP()`   | Returns current date and time.                                | `SELECT NOW();`                                        | `2025-09-07 21:30:00`        |
| `CURDATE()`                       | Returns current date.                                         | `SELECT CURDATE();`                                    | `2025-09-07`                 |
| `CURTIME()`                       | Returns current time.                                         | `SELECT CURTIME();`                                    | `21:30:00`                   |
| `DATE()`                          | Extracts date from datetime.                                  | `SELECT DATE('2025-09-07 21:30:00');`                  | `2025-09-07`                 |
| `YEAR()` / `MONTH()` / `DAY()`    | Extract year, month, or day from date.                        | `SELECT YEAR('2025-09-07');`                           | `2025`                       |
| `DATEDIFF(date1, date2)`          | Returns difference in days.                                   | `SELECT DATEDIFF('2025-09-10','2025-09-07');`          | `3`                          |
| `DATE_ADD(date, INTERVAL n unit)` | Adds days/months/years to date.                               | `SELECT DATE_ADD('2025-09-07', INTERVAL 5 DAY);`       | `2025-09-12`                 |
| `DATE_SUB(date, INTERVAL n unit)` | Subtracts days/months/years from date.                        | `SELECT DATE_SUB('2025-09-07', INTERVAL 3 MONTH);`     | `2025-06-07`                 |
| `STR_TO_DATE(string, format)`     | Converts string to date.                                      | `SELECT STR_TO_DATE('07-09-2025','%d-%m-%Y');`         | `2025-09-07`                 |
| `DATE_FORMAT(date, format)`       | Formats date to specified pattern.                            | `SELECT DATE_FORMAT('2025-09-07','%W, %M %d, %Y');`    | `Sunday, September 07, 2025` |
| `TIMESTAMPDIFF(unit, start, end)` | Difference between two timestamps in unit (DAY, MONTH, YEAR). | `SELECT TIMESTAMPDIFF(DAY,'2025-09-01','2025-09-07');` | `6`                          |

**Use cases:** Age calculation, scheduling, reporting, timelines, analytics.

---

## **4. AGGREGATE FUNCTIONS**

**Theory:**
Aggregate functions summarize data from multiple rows into a single result. Often used with `GROUP BY` for grouping.

| Function      | Theory                             | Example                              | Output  |
| ------------- | ---------------------------------- | ------------------------------------ | ------- |
| `COUNT(*)`    | Counts number of rows.             | `SELECT COUNT(*) FROM employees;`    | `10`    |
| `SUM(column)` | Adds numeric column values.        | `SELECT SUM(salary) FROM employees;` | `50000` |
| `AVG(column)` | Returns average of numeric column. | `SELECT AVG(salary) FROM employees;` | `5000`  |
| `MIN(column)` | Returns minimum value.             | `SELECT MIN(salary) FROM employees;` | `3000`  |
| `MAX(column)` | Returns maximum value.             | `SELECT MAX(salary) FROM employees;` | `10000` |

**Example with GROUP BY:**

```sql
SELECT department, COUNT(*) AS emp_count, AVG(salary) AS avg_salary
FROM employees
GROUP BY department;
```

**Use cases:** Reports, summaries, dashboards, business analytics.

---

## **5. CONDITIONAL & CONTROL FLOW FUNCTIONS**

| Function                              | Theory                            | Example                                                                   | Output  |
| ------------------------------------- | --------------------------------- | ------------------------------------------------------------------------- | ------- |
| `IF(condition, true_val, false_val)`  | Returns value based on condition. | `SELECT IF(salary>5000,'High','Low') FROM employees;`                     | `High`  |
| `CASE WHEN ... THEN ... ELSE ... END` | More flexible conditional logic.  | `SELECT CASE WHEN salary>5000 THEN 'High' ELSE 'Low' END FROM employees;` | `High`  |
| `COALESCE(col1, col2, ...)`           | Returns first non-null value.     | `SELECT COALESCE(NULL, NULL, 'Hello');`                                   | `Hello` |
| `IFNULL(col, value)`                  | Returns value if column is NULL.  | `SELECT IFNULL(NULL, 0);`                                                 | `0`     |

**Use cases:** Handling nulls, conditional labels, data transformation.

---

## **6. CONVERSION FUNCTIONS**

| Function                    | Theory                                            | Example                               | Output       |
| --------------------------- | ------------------------------------------------- | ------------------------------------- | ------------ |
| `CAST(expression AS type)`  | Converts data type.                               | `SELECT CAST('123' AS INT);`          | `123`        |
| `CONVERT(expression, type)` | Alternative syntax for type conversion.           | `SELECT CONVERT('2025-09-07', DATE);` | `2025-09-07` |
| `FORMAT(number, decimals)`  | Format number with decimal places and separators. | `SELECT FORMAT(12345.678,2);`         | `12,345.68`  |
| `BIN() / HEX() / OCT()`     | Converts numbers to binary, hex, octal.           | `SELECT BIN(10);`                     | `1010`       |

---

✅ This covers **all major SQL functions**, their **theory**, **example queries**, and **expected outputs**, with use cases.

---

