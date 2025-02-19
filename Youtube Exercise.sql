/* Exercise 1
Return all the products: name, unit price, new price (unit price * 1.1) */
USE	sql_store;
SELECT
	name,
	unit_price,
	unit_price * 1.1 AS new_price
FROM	products;

/* Exercise 2
Get the orders placed in 2018 */
USE	sql_store;
SELECT	*
FROM	orders
WHERE	order_date >= '2018-01-01';

/* Exercise 3
From the order_items table, get the items that meet:
	for order #6 where the total price is greater than 30 */
USE 	sql_store;
SELECT	*
FROM	order_items
WHERE 	order_id = 6 AND (quantity * unit_price) > 30;

/* Exercise 4
Return products with quantity in stock equal to 49, 38, 72 */
USE 	sql_store;
SELECT 	*
FROM 	products
WHERE 	quantity_in_stock IN (49, 38, 72);

/* Exercise 5
Return customers born between 1/1/1990 and 1/1/2000 */
USE 	sql_store;
SELECT 	* 
FROM 	customers
WHERE 	birth_date BETWEEN '1990-01-01' AND '2000-01-01';

/* Exercise 6
Get the customers whose:
i.	addresses contain trail or avenue
ii.	phone numbers end with 9 */
USE 	sql_store;
SELECT 	*
FROM	customers
WHERE 	address LIKE '%trail%'
		OR address LIKE '%avenue%';
USE 	sql_store;
SELECT 	*
FROM 	customers
WHERE 	phone LIKE '%9';

/* Exercise 7
Get the customers whose:
i.	first names are ELKA or AMBUR
ii.	last names end with EY or ON
iii.  last names start with MY or contains SE
iv.  last names contain B followed by R or U */
USE 	sql_store;
SELECT 	*
FROM	customers
WHERE 	first_name REGEXP 'elka|ambur';
USE 	sql_store;
SELECT 	*
FROM 	customers
WHERE 	last_name REGEXP 'ey$|on$';
USE 	sql_store;
SELECT 	*
FROM 	customers
WHERE 	last_name REGEXP '^my|se';
USE 	sql_store;
SELECT 	*
FROM 	customers
WHERE 	last_name REGEXP 'b[ru]';

/* Exercise 8
Get the orders that are not shipped */
USE 	sql_store;
SELECT 	*
FROM 	orders
WHERE 	shipped_date IS NULL AND shipper_id IS NULL;

/* Exercise 9
Write a query to select all the items for order with
ID = 2 and sort them by their total price in descending order. */
USE 	sql_store;
SELECT 	*
FROM 	order_items
WHERE 	order_id = 2
ORDER BY
	quantity * unit_price DESC;

/* Exercise 10
Get the top 3 loyal customers */
USE 	sql_store;
SELECT 	*
FROM 	customers
ORDER BY 
	points DESC
LIMIT 3;

/* Exercise 11
Write a query and join the order items table with the products table
so for each order, return product id, name, quantity, and unit price. */
USE 	sql_store;
SELECT 	order_id,
	o.product_id,
	name,
	quantity,
	o.unit_price
FROM 	order_items o INNER JOIN products p
		ON o.product_id = p.product_id;

/* Exercise 12
Write a query and join payments, clients, and payment_methods table
from sql_invoicing database. Produce a report that shows the payments
with more details such as the name of the client and the payment method. */
USE 	sql_invoicing;
SELECT 	date,
	invoice_id,
	c.name,
	amount, 
	pm.name AS payment_methods
FROM 	payments p INNER JOIN clients c
		ON p.client_id = c.client_id
    	INNER JOIN payment_methods pm
    		ON p.payment_method = pm.payment_method_id;

/* Exercise 13
Write a query that produces product_id, name of the product,
and quantity from order_items_table. */
USE 	sql_store;
SELECT 	p.product_id,
	p.name, 
	oi.quantity
FROM 	order_items oi RIGHT JOIN products p
		ON oi.product_id = p.product_id
ORDER BY 
	p.product_id;

/* Exercise 14
Write a query that produces order date, order id, first name, shipper name, 
and status name then order by the status. */
USE 	sql_store;
SELECT 	o.order_date, 
	o.order_id, 
	c.first_name AS customer, 
	s.name AS shipper, 
	os.name AS status
FROM 	orders o LEFT JOIN customers c
		ON o.customer_id = c.customer_id
	LEFT JOIN shippers s
		ON o.shipper_id = s.shipper_id
	LEFT JOIN order_statuses os
		ON o.status = os.order_status_id
ORDER BY 
	status;

/* Exercise 15
Write a query to select the payments table and produces data
that consists date, client, amount, and payment method name. */
USE 	sql_invoicing;
SELECT 	date, 
    	c.name AS client, 
    	amount, 
    	pm.name AS payment_name
FROM
	payments p LEFT JOIN clients c
    		USING (client_id)
    	LEFT JOIN payment_methods pm
    		ON p.payment_method = pm.payment_method_id;

/* Exercise 16
Do a cross join between shippers and products using
the implicit syntax and then the explicit syntax. */
-- IMPLICIT
USE	sql_store;
SELECT 	*
FROM	shippers, products;
-- EXPLICIT
USE	sql_store;
SELECT 	*
FROM	shippers, products;

/* Exercise 17
Write a query that returns customer_id, first_name, points, and type,
then order it by first_name.
Type is a column that define the status of each customer based on their points:
- Bronze	points < 2000
- Silver 	2000 <= points <= 3000
- Gold		points > 3000 */
USE 	sql_store;
SELECT	customer_id, 
	first_name, 
        points,
        'Bronze' AS type
FROM 	customers
WHERE	points < 2000
UNION
SELECT	customer_id, 
	first_name, 
        points,
        'Silver' AS type
FROM 	customers
WHERE	points BETWEEN 2000 AND 3000
UNION
SELECT	customer_id, 
	first_name, 
        points,
        'Gold' AS type
FROM 	customers
WHERE	points > 3000
ORDER BY first_name;

/* Exercise 18
Insert three rows in the products table. */
USE	sql_store;
INSERT INTO	products
VALUES	(DEFAULT, 'Cireng Bakar', 23, 2.54),
	(DEFAULT, 'Cimol Goreng', 45, 4.07),
	(DEFAULT, 'Batagor Kukus', 21, 3.21);

/* Exercise 19
Create a copy of the records from invoices table into invoices_archived table
where we replace the client_id as client_name, and get only ones that do have
a payment. */
USE 	sql_invoicing;
CREATE TABLE
	invoices_archived AS
SELECT	invoice_id, 
	number,
        name,
        invoice_total,
        payment_total,
        invoice_date,
        due_date,
        payment_date
FROM	invoices i LEFT JOIN clients c USING (client_id)
WHERE	payment_date IS NOT NULL;

/* Exercise 20
Write a SQL statement to give any customers born before 1990
an additional 50 extra points. */
USE	sql_store;
UPDATE	customers
SET 	points = points + 50
WHERE	birth_date < '1990-01-01';

/* Exercise 21
Write a SQL statement to update the comments on orders
for customers who have more than 3000 points by 'Gold customer'. */
USE	sql_store;
UPDATE	orders
SET 	comments = 'Gold customer'
WHERE	customer_id IN
		(SELECT customer_id
        	FROM customers
        	WHERE points > 3000);
