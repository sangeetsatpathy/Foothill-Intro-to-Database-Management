USE megastore;

/* Query 1 */

SELECT prod_id AS "product id",
	   warehouse_id AS "warehouse id",
       quantity_on_hand AS "quantity onhand"
FROM inventory
WHERE quantity_on_hand BETWEEN 50 AND 100.00;

/* Query 2 */
SELECT prod_id AS "product id",
	   warehouse_id AS "warehouse id",
       quantity_on_hand AS "quantity onhand"
FROM inventory
WHERE quantity_on_hand IN (50, 100, 150, 200, 250);

/* Query 3 */
SELECT prod_id AS "item id",
	   prod_name AS "item name"
FROM products
WHERE prod_name LIKE "C%";

/* Query 4 */
SELECT prod_id AS "item id",
	   prod_name AS "item name"
FROM products
WHERE prod_name LIKE "%o%";

/* Query 5 */
SELECT customer_id AS "customer ID",
	   address_line_1 AS "street address",
       zip_code AS "postal code"
FROM cust_address
WHERE city = "San Mateo" AND address_line_2 = "WY";

/* Query 6 */
SELECT customer_id AS "customer ID",
	   address_line_1 AS "street address",
       zip_code AS "postal code"
FROM cust_address
WHERE city != "Oakland";

/* Query 7 */
SELECT prod_id,
	   prod_desc,
       catg_id
FROM products
WHERE catg_id IN ("PET", "HD");

/* Query 8 */
SELECT cust_id,
	   first_name,
       last_name
FROM customers
WHERE last_name IN ("Morise", "Morris", "Morse");

/* Query 9 */
SELECT cust_id,
	   first_name,
       last_name
FROM customers
WHERE last_name LIKE "%s";

/* Query 10 */
SELECT prod_id,
	   prod_desc,
       catg_id
FROM products
WHERE catg_id IN ("MUS", "SPG") AND prod_desc LIKE "%ball%";

/* Query 11 */
SELECT first_name,
	   last_name,
       salary
FROM employees
WHERE salary NOT IN (3400, 3000, 6000) AND first_name LIKE "S%";

/* Query 12 */
SELECT prod_id,
	   prod_name,
       prod_desc
FROM products
WHERE prod_name LIKE "_at%"
ORDER BY prod_id DESC;

/* Query 13 */
SELECT prod_id,
	   prod_desc,
       catg_id
FROM products
WHERE catg_id NOT IN ("PET", "HW");