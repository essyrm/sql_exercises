-- Exercise 1
-- Return all the products: name, unit price, new price (unit price * 1.1)
SELECT name, unit_price, unit_price * 1.1 AS new_price
FROM products;

-- Exercise 2
-- Get the orders placed in 2018
SELECT * FROM orders
WHERE order_date >= '2018-01-01';

-- Exercise 3
-- 		From the order_items table, get the items that meet:
-- 		for order #6 where the total price is greater than 30
SELECT * FROM order_items
WHERE order_id = 6 AND (quantity * unit_price) > 30;

-- Exercise 4
-- 		Return products with quantity in stock equal to 49, 38, 72
-- Answer:	SELECT * FROM products
-- 			WHERE quantity_in_stock IN (49, 38, 72)
-- Exercise 5
-- 		Return customers born between 1/1/1990 and 1/1/2000
-- Answer:	SELECT * FROM customers
-- 			WHERE birth_date BETWEEN '1990-01-01' AND '2000-01-01'
-- Exercise 6
-- 		Get the customers whose:
-- 		i.	addresses contain trail or avenue
-- Answer:	SELECT * FROM customers
-- 			WHERE address LIKE '%trail%' OR address LIKE '%avenue%'
-- 		ii.	phone numbers end with 9
-- Answer:	SELECT * FROM customers
-- 			WHERE phone LIKE '%9'
-- Exercise 7
-- 		Get the customers whose:
-- 		i.	first names are ELKA or AMBUR
-- Answer:	SELECT * FROM customers
-- 			WHERE first_name REGEXP 'elka|ambur'
-- 		ii.	last names end with EY or ON
SELECT * FROM customers
WHERE last_name REGEXP 'ey$|on$';

SELECT * FROM customers
WHERE last_name REGEXP '^my|se'