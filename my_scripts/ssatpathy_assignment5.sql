USE megastore;

/*
CS31A Programming Assignment 5
Sangeet Satpathy
2/11/23
*/

/* Query 1: Matches each order to its customer in one table*/
SELECT ord_id,
	   ord_date,
       orders.cust_id,
       first_name,
       last_name
FROM orders
JOIN customers
ON (orders.cust_id = customers.cust_id);

/* Query 2: Matches each order to its customer, but narrows down to orders on a specific date. */
SELECT ord_id,
       orders.cust_id,
       first_name,
       last_name,
       ord_date
FROM orders
JOIN customers
ON (orders.cust_id = customers.cust_id)
WHERE ord_date = "2014-04-04";

/* Query 3: Displays the customer information for orders that are NOT on a specific date.*/
SELECT orders.cust_id,
       first_name,
       last_name
FROM orders
JOIN customers
ON (orders.cust_id = customers.cust_id)
WHERE ord_date != "2014-04-04";

/* Query 4: Describes each order, including information about the product being ordered.*/
SELECT order_details.ord_id,
	   ord_date,
       order_details.prod_id,
       prod_desc,
       catg_id
FROM order_details
JOIN orders
ON order_details.ord_id = orders.ord_id
JOIN products
ON order_details.prod_id = products.prod_id
ORDER BY catg_id, order_details.ord_id;

/* Query 5: Matches each order to its customer, but narrow down to orders by a specific customer that aren't transporting 
an electric pancake griddle. */
SELECT orders.ord_id,
       ord_date,
       first_name,
       last_name
FROM orders
JOIN customers
ON (orders.cust_id = customers.cust_id)
JOIN order_details
ON (order_details.ord_id = orders.ord_id)
JOIN products
ON (products.prod_id = order_details.prod_id)
WHERE first_name = "Samuel" 
	AND last_name = "Morse"
    AND prod_desc NOT LIKE "%Electric Pancake griddle%";
    
/* Query 6: Combines the order details, customer details, and details of the product ordered. */
SELECT orders.cust_id,
	   last_name AS Customer,
       orders.ord_id,
       order_details.prod_id,
       prod_name
FROM order_details
JOIN products
ON (order_details.prod_id = products.prod_id)
JOIN orders
ON (order_details.ord_id = orders.ord_id)
JOIN customers
ON (orders.cust_id = customers.cust_id)
LIMIT 10;

/* Query 7: Combines the order details, customer details, and details of the product ordered,
but it narrows down the results to products in the "MUS" category. */
SELECT orders.cust_id,
	   last_name AS Customer,
       orders.ord_id,
       order_details.prod_id,
       prod_name
FROM order_details
JOIN products
ON (order_details.prod_id = products.prod_id)
JOIN orders
ON (order_details.ord_id = orders.ord_id)
JOIN customers
ON (orders.cust_id = customers.cust_id)
WHERE catg_id = "MUS";

/* Query 8: Combines the customer's credit limit as well as their rating. */
SELECT cust_id,
	   credit_limit,
       rating
FROM customers
JOIN credit_ratings
ON (credit_limit < credit_ratings.high_limit AND credit_limit > credit_ratings.low_limit);

/* Query 9:
Display product ID, product description, and order ID in the category ‘MUS’*/
SELECT order_details.prod_id,
       prod_desc,
       catg_id,
       order_details.ord_id
FROM order_details
JOIN orders
ON order_details.ord_id = orders.ord_id
JOIN products
ON order_details.prod_id = products.prod_id
WHERE catg_id = "MUS";

/* Query 10:
For every customer, display their orders. If multiple orders, display them in new rows.
If they do not have any orders, then display null under order_id.*/
SELECT customers.cust_id,
	   last_name,
       ord_id
FROM customers
LEFT JOIN orders
ON orders.cust_id = customers.cust_id
UNION
SELECT customers.cust_id,
	   last_name,
       ord_id
FROM customers
RIGHT JOIN orders
ON orders.cust_id = customers.cust_id;

/* Query 11:
Combines product id, name, and the description of its category. */
SELECT prod_id,
	   prod_name,
       catg_desc
FROM products
JOIN categories
ON products.catg_id = categories.catg_id
ORDER BY products.catg_id, prod_id;

/* Query 12:
Combines each employee with their manager, if they have one. */
SELECT n.first_name,
	   n.last_name,
       e.first_name,
       e.last_name
FROM employees as n
LEFT JOIN employees as e
ON n.manager_id = e.emp_id;