/*
CS31A, Winter 2023
Sangeet Satpathy
Assignment 6
*/

USE megastore;

/* Query 1: Averaging employee salaries under a specific manager*/
SELECT AVG(salary) AS Average
FROM employees
WHERE manager_id = 100;

/* Query 2: Using min/max functions with salaries, dates, and first/last names. */
SELECT MIN(salary) AS lowest_salary,
	   MAX(hire_date) AS recent_hire,
       MIN(last_name) AS f_last_name,
       MAX(last_name) AS l_last_name
FROM employees
WHERE dept_id IN(30, 60);

/* Query 3: Combine first and last name into one column along with their salaries. Restricts results to employees 
with a specific last name.*/
SELECT CONCAT(first_name, " ", last_name) AS "employee name",
	   salary AS Salary
FROM employees
WHERE last_name LIKE "%ar%";

/* Query 4: Display first last name and last last name under alphabetical order */
SELECT MIN(last_name) AS "first last name",
	   MAX(last_name) AS "last last name"
FROM employees;

/* Query 5: Display weekly salary based on employer id, formatted.*/
SELECT emp_id,
	   CONCAT("$", CAST(FORMAT(salary/52, 2) AS CHAR)) AS "weekly salary"
FROM employees;

/* Query 6: Display each product, along with its description in uppercase letters */
SELECT prod_id,
	   UPPER(prod_desc) AS "Prod_description"
FROM products;

/* Query 7: Display each customer and their rounded credit limit*/
SELECT cust_id,
	   first_name,
       last_name,
       ROUND(credit_limit, 0) AS balance
FROM customers;

/* Query 8: Displays each order, along with its customer and order_date, as well as a promotion expiration date.*/
SELECT ord_id,
	   orders.cust_id,
       first_name,
       last_name,
       ord_date,
       ADDDATE(ord_date, INTERVAL 20 DAY) AS promotion_date
FROM orders
JOIN customers
ON (orders.cust_id = customers.cust_id);

/* Query 9: Counts the number of orders placed on each product*/
SELECT prod_id,
	   COUNT(*) AS numorders
FROM order_details
GROUP BY prod_id
ORDER BY numorders DESC;

/* Query 10: Counts the number of distinct products a customer has bought. */
SELECT cust_id,
	   COUNT(DISTINCT prod_id) AS number_of_items
FROM orders
JOIN order_details
ON orders.ord_id = order_details.ord_id
GROUP BY cust_id
HAVING number_of_items > 1;

/* Query 11: Finds the number of products and average price for 
each product category that has more than 5 products*/
SELECT catg_id,
	   COUNT(*) AS number_of_products,
       FORMAT(AVG(prod_list_price), 6) AS "Average price of all the products"
FROM products
GROUP BY catg_id
HAVING number_of_products > 5;

/* Query 12: Displays each category and the average price of all the products in that category*/
SELECT FORMAT(AVG(prod_list_price), 6) AS avgPrice,
	   catg_id
FROM products
GROUP BY catg_id;

/* Query 13: Display orders with either a sporting goods product or a pet supply product or both.*/
SELECT ord_id,
	   order_details.prod_id,
       catg_id,
       prod_name
FROM order_details
JOIN products
ON order_details.prod_id = products.prod_id
WHERE catg_id = 'SPG'
UNION ALL
SELECT ord_id,
	   order_details.prod_id,
       catg_id,
       prod_name
FROM order_details
JOIN products
ON order_details.prod_id = products.prod_id
WHERE catg_id = 'PET';

/* Query 14: HW products purchased with either a Nov or Dec date */
SELECT order_details.prod_id,
	   catg_id,
       prod_name
FROM orders
JOIN order_details
ON orders.ord_id = order_details.ord_id
JOIN products
ON order_details.prod_id = products.prod_id
WHERE catg_id = 'HW' AND MONTH(ord_date) = 11
UNION
SELECT order_details.prod_id,
	   catg_id,
       prod_name
FROM orders
JOIN order_details
ON orders.ord_id = order_details.ord_id
JOIN products
ON order_details.prod_id = products.prod_id
WHERE catg_id = 'HW' AND MONTH(ord_date) = 12;