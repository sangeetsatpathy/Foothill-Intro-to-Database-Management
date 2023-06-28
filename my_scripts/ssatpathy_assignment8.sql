/*
Sangeet Satpathy
Assignment 8
CS31A, Winter 2023
3/11/23
*/


USE megastore;

/* Query 1: Displays each employee, along with their salary, along with the max salary in their department.*/
SELECT last_name,
	   salary,
       e.dept_id,
       max_salary
FROM employees e
JOIN (SELECT dept_id, MAX(salary) AS max_salary FROM employees GROUP BY dept_id) AS dept_table
ON e.dept_id = dept_table.dept_id;

/* Query 2: Display customers with crdit limits over 100*/
CREATE OR REPLACE VIEW major_customer AS
(SELECT cust_id,
	   first_name,
       last_name,
       credit_limit
FROM customers
WHERE credit_limit >= 100);
SELECT * FROM major_customer;

/* Query 3: Makes a view of different orders and the items associated with them */
CREATE OR REPLACE VIEW item_ordered AS
SELECT products.prod_id,
	   prod_desc,
       prod_list_price,
       orders.ord_id,
       ord_date,
       quantity_ordered,
       quoted_price
FROM order_details
JOIN orders ON order_details.ord_id = orders.ord_id
JOIN products ON order_details.prod_id = products.prod_id;
SELECT * FROM item_ordered;

/* Query 4: Get data on orders where the prices are above $100. */
SELECT prod_id,
	   prod_desc,
       ord_id,
       quoted_price
FROM item_ordered
WHERE quoted_price > 100;

/* Query 5: Create a copy of the department table*/
CREATE TABLE my_departments AS
SELECT * FROM departments;
SELECT * FROM my_departments;

/* Query 6: Creates a table with aggregate statistics of the salaries in each department*/
CREATE VIEW v_salaries AS
(SELECT MAX(salary) AS Highestsal, 
	   MIN(salary) AS lowestsal,
       AVG(salary) AS Avgsal,
       department_name
FROM employees
JOIN departments
ON employees.dept_id = departments.dept_id
GROUP BY employees.dept_id);
SELECT * FROM v_salaries;

/* Query 7: Create a view with the product attributes of products in specific categories*/
CREATE VIEW prod_hw_apl AS
SELECT prod_id,
	   prod_name,
       prod_list_price
FROM products
WHERE catg_id IN ("APL", "HW");
SELECT * FROM prod_hw_apl;

/* Query 8: Create a view named CUST_ORDERS. It consists of the order ID, order date, 
customer ID, category ID, and product ID for all ordered products.*/
CREATE VIEW cust_orders AS
SELECT order_details.ord_id,
	   ord_date,
       cust_id,
       catg_id,
       order_details.prod_id
FROM order_details
JOIN orders ON orders.ord_id = order_details.ord_id
JOIN products ON order_details.prod_id = products.prod_id;
SELECT * FROM cust_orders;

/* Query 9: Creates a view with the total price for each order.*/
CREATE OR REPLACE VIEW ord_total AS
SELECT ord_id,
	   SUM(quoted_price * quantity_ordered) AS "total due"
FROM order_details
GROUP BY ord_id;
SELECT * FROM ord_total;
	   