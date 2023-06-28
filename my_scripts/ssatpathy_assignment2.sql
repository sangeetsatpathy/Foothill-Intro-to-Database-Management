/* Assignment2.sql 
  Sangeet Satpathy
   CS 31A, Winter 2022
*/

/* put the database name into this command */
USE megastore;

/* Query 1 */
SELECT prod_id, 
	   prod_name, 
       prod_desc 
FROM products;

/* Query 2 */
SELECT *
FROM orders;

/* Query 3 */
SELECT first_name, 
	   last_name
FROM customers
WHERE credit_limit >= 750;

/* Query 4 */
SELECT *
FROM orders
WHERE cust_id = 403000 AND ord_date = "2013-10-02";

/* Query 5 */
SELECT ord_id, 
	   prod_id,
       quoted_price AS PRICE,
       quantity_ordered AS QUANTITY,
       (quoted_price*quantity_ordered) AS ExtCost
FROM order_details;

/* Query 6 */
SELECT ord_id AS "order id",
	   ord_date AS "order date"
FROM orders
WHERE ord_date < "2013-10-28";


/* Query 7 */
SELECT *
FROM products
ORDER BY prod_id;

/* Query 8 */
SELECT last_name,
	   first_name,
       cust_id
FROM customers
WHERE cust_id = 403100;

/* Query 9 */
SELECT DISTINCT cust_id
FROM orders;

/*  Query 10 */
SELECT ord_id,
	   ord_date,
       sales_rep_id,
       shipping_mode
FROM orders
WHERE shipping_mode IS NULL;


/*Query 11*/
SELECT ord_id,
	   ord_date,
       sales_rep_id,
       shipping_mode
FROM orders
WHERE shipping_mode IS NOT NULL
LIMIT 5;

/* Query 12 */
SELECT *
FROM locations
WHERE loc_country_id = "US";