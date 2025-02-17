-- Exercise 1
-- Return all the products: name, unit price, new price (unit price * 1.1)
USE sql_store;
SELECT name, unit_price, unit_price * 1.1 AS new_price
FROM products;

-- Exercise 2
-- Get the orders placed in 2018
USE sql_store;
SELECT * FROM orders
WHERE order_date >= '2018-01-01';

-- Exercise 3
-- From the order_items table, get the items that meet: for order #6 where the total price is greater than 30
USE sql_store;
SELECT * FROM order_items
WHERE order_id = 6 AND (quantity * unit_price) > 30;

-- Exercise 4
-- Return products with quantity in stock equal to 49, 38, 72
USE sql_store;
SELECT * FROM products
WHERE quantity_in_stock IN (49, 38, 72);

-- Exercise 5
-- Return customers born between 1/1/1990 and 1/1/2000
USE sql_store;
SELECT * FROM customers
WHERE birth_date BETWEEN '1990-01-01' AND '2000-01-01';

-- Exercise 6
-- Get the customers whose:
USE sql_store;
-- i.	addresses contain trail or avenue
SELECT * FROM customers
WHERE address LIKE '%trail%' OR address LIKE '%avenue%';
-- ii.	phone numbers end with 9
SELECT * FROM customers
WHERE phone LIKE '%9';

-- Exercise 7
-- Get the customers whose:
USE sql_store;
-- i.	first names are ELKA or AMBUR
SELECT * FROM customers
WHERE first_name REGEXP 'elka|ambur';
-- ii.	last names end with EY or ON
SELECT * FROM customers
WHERE last_name REGEXP 'ey$|on$';
-- iii.  last names start with MY or contains SE
SELECT * FROM customers
WHERE last_name REGEXP '^my|se';
-- iv.  last names contain B followed by R or U
SELECT * FROM customers
WHERE last_name REGEXP 'b[ru]';

-- Exercise 8
-- Get the orders that are not shipped
USE sql_store;
SELECT * FROM orders
WHERE shipped_date IS NULL AND shipper_id IS NULL;

-- Exercise 9
-- Write a query to select all the items for order with ID=2 and sort them by their total price in descending order.
USE sql_store;
SELECT * FROM order_items
WHERE order_id = 2
ORDER BY quantity * unit_price DESC;

-- Exercise 10
-- Get the top 3 loyal customers
USE sql_store;
SELECT * FROM customers
ORDER BY points DESC
LIMIT 3;

-- Exercise 11
-- Write a query and join the order items table with the products table so for each order, return product id, name, quantity, and unit price.
USE sql_store;
SELECT order_id, o.product_id, name, quantity, o.unit_price
FROM order_items o INNER JOIN products p
	ON o.product_id = p.product_id;

-- Exercise 12
-- Write a query and join payments, clients, and payment_methods table from sql_invoicing database. Produce a report that shows the payments with more details such as the name of the client and the payment method.
USE sql_invoicing;
SELECT date, invoice_id, c.name, amount, pm.name AS payment_methods
FROM payments p INNER JOIN clients c
	ON p.client_id = c.client_id
    INNER JOIN payment_methods pm
    ON p.payment_method = pm.payment_method_id;

-- Exercise 13
-- Write a query that produces product_id, name of the product, and quantity from order_items_table.
USE sql_store;
SELECT p.product_id, p.name, oi.quantity
FROM order_items oi RIGHT JOIN products p
	ON oi.product_id = p.product_id
ORDER BY p.product_id;
