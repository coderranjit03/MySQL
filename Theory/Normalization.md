

# 🔎 What is Normalization?

**Normalization** is a set of design techniques for relational databases that organizes tables and relationships to:

* **Reduce data redundancy** (no repeated data),
* **Avoid update/insert/delete anomalies**, and
* **Ensure data integrity** (via constraints and keys).

Normalization is achieved by decomposing tables into smaller, well-structured tables based on **functional dependencies** and **normal form** rules.

---

# 🔑 Key concepts (theory fundamentals)

* **Relation / Table** — a set of tuples (rows) with attributes (columns).
* **Functional Dependency (FD)** — For attributes X and Y, `X → Y` means *value of X uniquely determines Y*.
  Example: `product_id → product_name`. If two rows have same `product_id`, they must have same `product_name`.
* **Superkey** — a set of attributes that uniquely identifies a row.
* **Candidate key** — minimal superkey (no subset is also a key).
* **Primary key** — chosen candidate key for a table.
* **Partial dependency** — a non-key attribute depends on part of a composite key (bad for 2NF).
* **Transitive dependency** — A → B and B → C, so A → C transitively (bad for 3NF).
* **Multivalued dependency (MVD)** — A →→ B means for a given A there can be multiple B independent of other attributes.

---

# ⚠️ Why normalize? (Data anomalies)

Consider a single table storing orders, customers, and products together. You can face:

* **Update anomaly** — updating customer address requires changes in many rows; miss one and data is inconsistent.
* **Insert anomaly** — you cannot insert a product into the catalog without an order (if product exists only as part of orders).
* **Delete anomaly** — deleting the only order for a customer might delete the only record of that customer.

Normalization prevents these by separating distinct entities.

---

# 1NF → 2NF → 3NF → BCNF → 4NF → 5NF (step-by-step theory + examples)

We’ll start with an **unnormalized** example and progressively normalize it.

### UN-NORMALIZED example (bad)

A single `Orders` table:

| order\_id | order\_date | customer\_id | customer\_name | customer\_phone  | product\_id | product\_name | qty | price |
| --------- | ----------- | ------------ | -------------- | ---------------- | ----------- | ------------- | --- | ----- |
| 1         | 2025-09-01  | 101          | Alice          | 999-111, 999-222 | 1001        | Mouse         | 2   | 20.00 |
| 1         | 2025-09-01  | 101          | Alice          | 999-111, 999-222 | 1002        | Keyboard      | 1   | 45.00 |
| 2         | 2025-09-02  | 102          | Bob            | 888-333          | 1001        | Mouse         | 1   | 20.00 |

Problems:

* `customer_name` repeated for every order.
* `product_name` repeated for every order item.
* `customer_phone` has multiple phone numbers in one column (violates atomicity).

---

## ✅ First Normal Form (1NF)

**Rule:** All attribute values must be *atomic* (indivisible) and each column must hold values of a single type. No repeating groups or arrays in a column.

**Fixes:**

* Split multi-valued phone column into separate rows or a separate table.
* Represent each order item as separate row (already shown) — but ensure atomic columns.

**Example (1NF):** Keep the `Orders` rows as above but remove multi-valued fields. Move `customer_phone` to a separate table with one phone per row.

```sql
CREATE TABLE Customers (
  customer_id INT PRIMARY KEY,
  customer_name VARCHAR(100)
);

CREATE TABLE CustomerPhones (
  customer_id INT,
  phone VARCHAR(20),
  PRIMARY KEY (customer_id, phone),
  FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);
```

---

## ✅ Second Normal Form (2NF)

**Precondition:** Table must be in 1NF.

**Rule:** No **partial dependencies** — every non-key attribute must depend on the *entire* primary key. (Relevant only for tables with composite primary keys.)

**Typical violation example:**
Consider an `OrderItems` table with composite PK `(order_id, product_id)` and a column `product_name`:

| order\_id | product\_id | product\_name | qty |
| --------- | ----------- | ------------- | --- |
| 1         | 1001        | Mouse         | 2   |

Here `product_name` depends only on `product_id` (part of the composite key) → **partial dependency**.

**Fix:**
Move product-related attributes to a `Products` table.

```sql
CREATE TABLE Products (
  product_id INT PRIMARY KEY,
  product_name VARCHAR(100),
  price DECIMAL(10,2)
);

CREATE TABLE Orders (
  order_id INT PRIMARY KEY,
  order_date DATE,
  customer_id INT,
  FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE OrderItems (
  order_id INT,
  product_id INT,
  qty INT,
  PRIMARY KEY(order_id, product_id),
  FOREIGN KEY(order_id) REFERENCES Orders(order_id),
  FOREIGN KEY(product_id) REFERENCES Products(product_id)
);
```

Now `product_name` lives in `Products`, eliminating the partial dependency.

---

## ✅ Third Normal Form (3NF)

**Precondition:** Table must be in 2NF.

**Rule:** No **transitive dependencies** — non-key attributes must not depend on other non-key attributes. For any non-key attributes A, B, C, if `A → B` and `B → C`, then A→C is transitive and must be removed.

**Example (transitive dependency):**
`Employees` table:

| emp\_id | emp\_name | dept\_id | dept\_name | dept\_head |
| ------- | --------- | -------- | ---------- | ---------- |
| 1       | Alice     | 10       | HR         | Carol      |

Here `dept_name` and `dept_head` depend on `dept_id`, and `dept_id` is stored alongside employee info. `dept_name` & `dept_head` are transitively dependent on `emp_id` via `dept_id`.

**Fix:**
Split out `Departments` table.

```sql
CREATE TABLE Departments (
  dept_id INT PRIMARY KEY,
  dept_name VARCHAR(100),
  dept_head VARCHAR(100)
);

CREATE TABLE Employees (
  emp_id INT PRIMARY KEY,
  emp_name VARCHAR(100),
  dept_id INT,
  FOREIGN KEY(dept_id) REFERENCES Departments(dept_id)
);
```

Now `Employees` only stores dept\_id; department details are in `Departments`.

---

## ✅ Boyce–Codd Normal Form (BCNF)

**Stronger than 3NF.**

**Rule:** For every non-trivial functional dependency `X → Y` in the relation, `X` must be a **superkey**. BCNF handles edge cases where 3NF may allow non-key determinants if they’re part of candidate keys.

**Example of BCNF violation:**
Table `R(Student, Course, Instructor)` with FDs:

* `(Student, Course)` is the PK.
* `Course → Instructor` (a course has single instructor).
  `Course` is not a superkey (it does not uniquely identify rows), yet it determines `Instructor`. This violates BCNF.

**Fix:** Decompose into:

* `CourseInstructor (course, instructor)`
* `StudentCourse (student, course)`

Now `Course` → `Instructor` is allowed in `CourseInstructor` where `Course` is a key.

---

## ✅ Fourth Normal Form (4NF)

**Deals with multivalued dependencies (MVDs).**

**Rule:** No table should have more than one independent multivalued dependency — every non-trivial MVD must be a consequence of the candidate key.

**Example:**
`EmployeeLanguagesPhones(employee_id, language, phone)` where:

* `employee_id →→ language` (employee may have multiple languages)
* `employee_id →→ phone` (employee may have multiple phones)

These two sets are independent. Storing both in same table forms Cartesian product of languages × phones causing redundancy.

**Fix:** Split into:

* `EmployeeLanguages(employee_id, language)`
* `EmployeePhones(employee_id, phone)`

---

## ✅ Fifth Normal Form (5NF / PJNF)

5NF deals with **join dependencies** — decompositions that can be joined losslessly and capture all constraints. Rare in practice. The idea: decompose relations so that reconstructing original table requires only joins and no spurious tuples.

---

# ✅ Lossless Join & Dependency Preservation

* **Lossless-join decomposition:** When you decompose a relation into R1 and R2, joining R1 and R2 must give back the original relation without spurious rows. A sufficient condition: `(R1 ∩ R2)` is a key for at least one of R1 or R2.

* **Dependency preservation:** After decomposition, you should be able to enforce original FDs by enforcing constraints on child tables (without having to join). Sometimes BCNF decompositions break dependency preservation — you must then enforce constraints via triggers or application logic.

Trade-off: Perfect normalization (BCNF) might require extra joins or lose dependency preservation — choose based on use-case.

---

# Practical, step-by-step normalization example (Orders → Customers, Products, OrderItems)

### 1) Unnormalized table:

```sql
-- imagine single table OrdersFull (bad design)
```

Rows shown earlier — contains customer repeated, product repeated.

### 2) Normalize to 1NF, 2NF, 3NF

**Create normalized schema:**

```sql
CREATE TABLE Customers (
  customer_id INT PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100)
);

CREATE TABLE Products (
  product_id INT PRIMARY KEY,
  product_name VARCHAR(100),
  price DECIMAL(10,2)
);

CREATE TABLE Orders (
  order_id INT PRIMARY KEY,
  order_date DATE,
  customer_id INT,
  FOREIGN KEY(customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE OrderItems (
  order_id INT,
  product_id INT,
  qty INT,
  PRIMARY KEY(order_id, product_id),
  FOREIGN KEY(order_id) REFERENCES Orders(order_id),
  FOREIGN KEY(product_id) REFERENCES Products(product_id)
);
```

**Insert sample data:**

```sql
INSERT INTO Customers VALUES (101,'Alice','alice@example.com'), (102,'Bob','bob@example.com');

INSERT INTO Products VALUES (1001,'Mouse',20.00), (1002,'Keyboard',45.00);

INSERT INTO Orders VALUES (1,'2025-09-01',101), (2,'2025-09-02',102);

INSERT INTO OrderItems VALUES (1,1001,2), (1,1002,1), (2,1001,1);
```

**Query: Get full order details (join)**

```sql
SELECT o.order_id, o.order_date, c.name AS customer, p.product_name, oi.qty, p.price
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
JOIN OrderItems oi ON o.order_id = oi.order_id
JOIN Products p ON oi.product_id = p.product_id
ORDER BY o.order_id;
```

**Output:**

| order\_id | order\_date | customer | product\_name | qty | price |
| --------- | ----------- | -------- | ------------- | --- | ----- |
| 1         | 2025-09-01  | Alice    | Mouse         | 2   | 20.00 |
| 1         | 2025-09-01  | Alice    | Keyboard      | 1   | 45.00 |
| 2         | 2025-09-02  | Bob      | Mouse         | 1   | 20.00 |

This normalized design avoids repeating customer and product info and prevents the anomalies.

---

# Practical rules / algorithm to normalize a table

1. **List all attributes** of your table.
2. **Identify candidate keys** (what uniquely identifies a row).
3. **List functional dependencies** (X → Y).
4. Apply normal forms incrementally:

   * Ensure atomicity → 1NF.
   * Remove partial dependencies → 2NF.
   * Remove transitive dependencies → 3NF.
   * Enforce BCNF if needed (check every FD).
   * Handle multivalued dependencies → 4NF.
5. Decompose tables ensuring **lossless join** (test using intersection keys).
6. Check **dependency preservation**; if lost, consider tradeoffs.

---

# When to stop normalizing? (Practical trade-offs)

* For **OLTP (transactional)** systems: normalize to **3NF or BCNF** to preserve integrity and reduce redundancy.
* For **read-heavy/analytic (OLAP)** systems: denormalization often used for performance (fewer joins). Use materialized views, aggregated tables, or star/snowflake schemas.
* **Denormalize** only when profiling shows joins are the performance bottleneck and after careful consideration of update complexity.

---

# Denormalization techniques (when needed)

* Add redundant columns (store computed or lookup values).
* Use materialized views / summary tables.
* Precompute aggregates.
* Use caching layers (Redis) for hot data.
* Partitioning (horizontal) or sharding for scale.

Trade-off: improved read performance vs increased update complexity and storage.

---

# Best practices & tips

* Model entities and relationships using an **ER diagram** before creating tables.
* Prefer **surrogate keys (auto-increment)** for PKs unless a natural key is stable and small.
* Index **foreign keys** and columns used for joins and filtering.
* Document **functional dependencies** — helps future maintenance.
* Use **CHECK constraints** and **foreign keys** for integrity.
* Normalize to **3NF** as a baseline for OLTP; move to BCNF only if needed.
* For reporting/data warehousing, use denormalized star schema.

---

# Short checklist (quick)

* [ ] No repeating groups → 1NF
* [ ] No partial dependencies → 2NF
* [ ] No transitive dependencies → 3NF
* [ ] Every determinant is a superkey → BCNF
* [ ] No independent multivalued dependencies → 4NF
* [ ] Decomposed into minimal joins → 5NF (rare)

---

