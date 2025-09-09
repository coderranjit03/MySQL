
---

# 🔍 Subqueries in SQL (MySQL)

## 📝 What is a Subquery?

A **subquery** (also called an *inner query* or *nested query*) is a query inside another SQL query.

* The **inner query (subquery)** provides data to the **outer query (main query)**.
* A subquery is always enclosed in **parentheses `()`**.
* Subqueries can be placed in `SELECT`, `FROM`, `WHERE`, `HAVING`, and `EXISTS` clauses.

---

## 📌 Types of Subqueries

1. **Single-row subquery**

   * Returns exactly one value (scalar result).
   * Used with operators like `=`, `<`, `>`, `<=`, `>=`.

   ```sql
   SELECT * FROM products
   WHERE price > (SELECT AVG(price) FROM products);
   ```

   ✅ Finds products more expensive than the **average price**.

---

2. **Multi-row subquery**

   * Returns multiple rows.
   * Used with `IN`, `ANY`, `ALL`.

   ```sql
   SELECT * FROM customers
   WHERE customer_id IN (SELECT DISTINCT customer_id FROM orders);
   ```

   ✅ Finds customers who placed orders.

---

3. **Multi-column subquery**

   * Returns multiple columns.
   * Often used with tuple comparison.

   ```sql
   SELECT email, state
   FROM customers c
   WHERE (c.customer_id, c.city) IN (
       SELECT o.customer_id, 'Houston' FROM orders o
   );
   ```

   ✅ Checks for multiple matching conditions.

---

4. **Correlated Subquery**

   * Executes once for **each row** of the outer query.
   * Depends on outer query values.
   * Slower but powerful.

   ```sql
   SELECT first_name, last_name
   FROM customers c
   WHERE EXISTS (
       SELECT 1 FROM orders o WHERE o.customer_id = c.customer_id
   );
   ```

   ✅ Finds customers who have placed at least one order.

---

5. **Scalar Subquery**

   * Returns a single value, often used in the `SELECT` list.

   ```sql
   SELECT first_name, 
          (SELECT COUNT(*) FROM orders o WHERE o.customer_id = c.customer_id) AS total_orders
   FROM customers c;
   ```

   ✅ Shows number of orders for each customer.

---

6. **Subqueries in FROM clause (Derived Tables)**

   * A subquery can act like a **temporary table**.

   ```sql
   SELECT AVG(total_spent) 
   FROM (SELECT customer_id, SUM(total_amount) AS total_spent 
         FROM orders GROUP BY customer_id) AS customer_total;
   ```

   ✅ Calculates the average spending across customers.

---

7. **Subqueries with HAVING**

   ```sql
   SELECT customer_id, SUM(total_amount) AS total_spent
   FROM orders
   GROUP BY customer_id
   HAVING SUM(total_amount) > (
       SELECT AVG(total_amount) FROM orders
   );
   ```

   ✅ Finds customers who spent more than the average order value.

---

8. **Subqueries with EXISTS / NOT EXISTS**

   ```sql
   -- Customers who placed orders
   SELECT * FROM customers c
   WHERE EXISTS (SELECT 1 FROM orders o WHERE c.customer_id = o.customer_id);

   -- Customers with no orders
   SELECT * FROM customers c
   WHERE NOT EXISTS (SELECT 1 FROM orders o WHERE c.customer_id = o.customer_id);
   ```

   ✅ `EXISTS` checks for row existence.

---

9. **Subqueries with ALL and ANY**

   ```sql
   -- Products more expensive than ALL books
   SELECT * FROM products
   WHERE price > ALL (SELECT price FROM products WHERE category = 'Books');

   -- Products more expensive than ANY book
   SELECT * FROM products
   WHERE price > ANY (SELECT price FROM products WHERE category = 'Books');
   ```

   ✅ `ALL` → must be greater than every value.
   ✅ `ANY` → must be greater than at least one value.

---

## ⚡ Subqueries vs JOINs

* **Subquery**: Easy to read, good for step-by-step filtering, but sometimes slower.
* **JOIN**: Usually faster, better for combining data across multiple tables.

Example (customers who ordered electronics):

👉 Using **JOIN**:

```sql
SELECT DISTINCT c.first_name, c.last_name
FROM customers c
JOIN orders o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE p.category = 'Electronics';
```

👉 Using **Subquery**:

```sql
SELECT first_name, last_name
FROM customers
WHERE customer_id IN (
    SELECT o.customer_id
    FROM orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN products p ON oi.product_id = p.product_id
    WHERE p.category = 'Electronics'
);
```

---

## 🚀 Performance Tips

* Subqueries inside `WHERE` can be slow for large datasets → prefer `JOIN` if possible.
* Use **EXISTS** instead of `IN` for better performance in some cases.
* Always give an **alias** when using subquery in `FROM`.

---

## 🧠 Key Takeaways

* Subqueries = **query inside a query**.
* Types: Single-row, Multi-row, Multi-column, Scalar, Correlated.
* Can be used in `SELECT`, `FROM`, `WHERE`, `HAVING`, `EXISTS`.
* `EXISTS` and `NOT EXISTS` are powerful for existence checks.
* Often interchangeable with `JOIN`, but choice depends on readability and performance.

---

