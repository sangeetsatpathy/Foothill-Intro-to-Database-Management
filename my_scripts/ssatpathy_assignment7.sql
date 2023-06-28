/*
Sangeet Satpathy
Assignment 7
CS31A, Winter 2023
*/

USE megastore;

/* Query 1: Finding items with the lowest price */
SELECT prod_id,
	   prod_desc,
       prod_list_price
FROM products
WHERE prod_list_price = 
(SELECT MIN(prod_list_price) 
FROM products);

/* Query 2 : Selects customers who have an order on a specific date WITHOUT using a join.*/
SELECT cust_id,
	   first_name,
       last_name
FROM customers
WHERE cust_id IN 
(SELECT cust_id 
FROM orders 
WHERE ord_date = "2013-10-01"); 

/* Query 3: Repeat query 2, but this time, use the EXISTS operator in your answer. */
SELECT cust_id,
	   first_name,
       last_name
FROM customers
WHERE EXISTS 
(SELECT * 
FROM orders 
WHERE orders.cust_id = customers.cust_id
AND ord_date = "2013-10-01");

/* Query 4: Displays the order id's and dates for William Morris*/
SELECT ord_id,
	   ord_date
FROM orders
WHERE cust_id IN 
(SELECT cust_id 
FROM customers 
WHERE first_name = "William" 
AND last_name = "Morris");

/* Query 5: Select products that have a list price greater than every pet product.*/
SELECT prod_id,
	   prod_desc,
       catg_id,
       prod_list_price
FROM products
WHERE prod_list_price > ALL (SELECT prod_list_price FROM products WHERE catg_id = "PET");

/* Query 6:
Display all those employees who have a salary greater than that of an employee whose last name is 
Davies and are in the same department as an employee whose last name is Bell.*/
SELECT emp_id,
	   last_name,
       first_name,
       manager_id AS emp_mng,
       dept_id,
       hire_date,
       salary,
       job_id
FROM employees
WHERE salary > ALL 
(SELECT salary 
FROM employees 
WHERE last_name = "Davies")
AND dept_id IN 
(SELECT dept_id 
FROM employees 
WHERE last_name = "Bell");

/* Query 7: Displays the department ID and minimum salary of all employees, grouped by department ID. 
This minimum salary must be greater than the minimum salary of those employees whose department ID is not equal to 50. */
SELECT dept_id,
       MIN(salary) AS "Min minimum"
FROM employees
GROUP BY dept_id
HAVING MIN(salary) > ALL 
(SELECT MIN(salary) 
FROM employees 
WHERE dept_id <> 50);

/* Query 8:  finds the last names of all employees whose salaries are the same as the minimum salary
 for any department.*/
SELECT last_name
FROM employees
WHERE salary IN 
(SELECT MIN(salary) 
FROM employees 
GROUP BY dept_id);

/* Query 9:
pair-wise subquery listing the last name, first name, department ID, and manager ID for 
all employees that have the same department ID and manager ID as employee with ID 107. 
Exclude employee 107 from the result set. */
SELECT last_name,
	   first_name,
       dept_id,
       manager_id AS emp_mng
FROM employees
WHERE (dept_id, manager_id) = 
(SELECT dept_id, 
		manager_id 
FROM employees 
WHERE emp_id = 107)
AND emp_id <> 107;

/* Query 10: Same as #9, but non pairwise*/
SELECT last_name,
	   first_name,
       dept_id,
       manager_id AS emp_mng
FROM employees
WHERE dept_id = 
(SELECT dept_id 
FROM employees 
WHERE emp_id = 107)
AND manager_id = 
(SELECT manager_id 
FROM employees 
WHERE emp_id = 107)
AND emp_id <> 107;

/* Query 11: Displays highest earners in each department */
SELECT last_name,
	   dept_id,
       salary
FROM employees
WHERE salary IN 
(SELECT MAX(salary) 
FROM employees 
GROUP BY dept_id);

/* Query 12 : Display all customers who bought product 1050 and product 1060*/
SELECT cust_id,
	   last_name
FROM customers
WHERE cust_id IN 
(SELECT cust_id 
FROM orders
JOIN order_details ON (orders.ord_id = order_details.ord_id)
WHERE prod_id = 1060)
AND cust_id IN
(SELECT cust_id 
FROM orders
JOIN order_details ON (orders.ord_id = order_details.ord_id)
WHERE prod_id = 1050)
ORDER BY cust_id DESC;

/* Query 13: Displays products that do not appear in any orders.*/
SELECT catg_id AS catg, 
	   prod_id,
       prod_desc AS description,
       prod_list_price AS price
FROM products
WHERE prod_id NOT IN 
(SELECT prod_id 
FROM order_details);