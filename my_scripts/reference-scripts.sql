-- List of SQL commands
USE sakila; -- Use a database

-- DROP TABLE newTable;

-- Makes an entirely new table with 6 columns. Needs to use () parentheses. Each column has a specific data type.
CREATE TABLE IF NOT EXISTS newtable(
	id INT,
    name VARCHAR(255),
    address VARCHAR(255),
    city VARCHAR(255),
    state CHAR(2),
    zip CHAR(10)
);

-- In tables, each row is another "record" -- think of them as different objects. Each column specifies an attribute of that object.

SHOW TABLES; -- Shows all the tables
DESCRIBE newtable; -- Shows all the fields of the table
SELECT * FROM address; -- Shows all the data from the table
-- NOTE: MySQL Workbench only shows the LAST display statement; which is why you use one query at a time.

INSERT INTO newtable VALUES (1, 'Kabul', 'AFG', 'Kabol', 1780000); -- Creates a new record into the table

-- You can run several different scripts, but if they are running on the same database, then the queries are CUMULATIVE
-- i.e. I made table newTable in the sakila database, but when I ran this file again, it wouldn't let me create newTable again as it was there
-- from previously running this file.

-- (in command prompt): 
-- SOURCE C:/.../sqlFile.sql; -- Runs the SQL file line by line
-- TEE C:/.../outputFile.txt; -- Logs the output of the SQL File into a text file. Needs to input "NOTEE" to stop the tee. 
-- The tee command CREATES this file on its own; If the file exists, it overwrites whatever is in that file.

-- Starting the sql server on cmd:
-- mysql -u root –p --force --comments –vvv
/*
	-u: username (which is followed by the value, in this case, root)
	-p: password (will ask you for password in next line)
    --force: Forces the queries to run, even if there are errors
    --comments: See the comments
    -vvv: Allows us to see the queries that are being run and the output formatted as rows and columns
*/