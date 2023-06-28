USE megastore;
/* Questions 1-2 */
CREATE TABLE IF NOT EXISTS global_locations (
	id INT(4),
    loc_name VARCHAR(20),
    address VARCHAR(20),
    city VARCHAR(20),
    zip_postal_code VARCHAR(20),
    phone VARCHAR(15),
    email VARCHAR(15) UNIQUE,
    manager_id INT(4),
    emergency_contact VARCHAR(20),
    PRIMARY KEY (id)
);
DESCRIBE global_locations;

/* Question 3 */
ALTER TABLE global_locations
ADD date_opened DATE;
DESCRIBE global_locations;

/* Question 4:*/
DESCRIBE global_locations;

/* Question 5 */
ALTER TABLE global_locations
DROP date_opened;

/* Question 6 */
ALTER TABLE global_locations 
RENAME TO global_locations_backup;

/* Question 7 */
CREATE TABLE employee_pay (
	employee_id INT PRIMARY KEY,
    ssn CHAR(11) UNIQUE,
    salary NUMERIC NOT NULL,
    hire_date DATE NOT NULL
);

/* Question 8 */
INSERT INTO employee_pay
VALUES (184167702, "744-04-9444", 5500, "2011-03-15");
SELECT * FROM employee_pay;


/* Question 9 */
ALTER TABLE employee_pay
ADD e_address VARCHAR(30) NULL; 

/*Question 10*/
SHOW TABLES FROM megastore;

/*Question 11*/
ALTER TABLE employee_pay
DROP e_address;

/*Question 12*/
DROP TABLE global_locations_backup;
SHOW TABLES FROM megastore;

/* Question 13 */
INSERT INTO categories
VALUES ("FU", "feurniture");
SELECT * FROM categories;

/* Question 14 */
UPDATE categories
SET catg_desc = "furniture"
WHERE catg_id = "FU";