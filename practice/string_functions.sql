-- String functions
USE parks_and_recreation;

-- Output should show the amount of letters in 'skyfall' = 7
SELECT length('Skyfall');

SELECT first_name AS fname, LENGTH(first_name) AS length
FROM employee_demographics
ORDER BY 2; -- order by 2 = 2nd column

-- Make all upper/lower case
SELECT UPPER('sky'); -- makes all upper case
SELECT LOWER('SKY'); -- makes all lower case

-- Removing white spaces with TRIM
SELECT TRIM('                sky            '); -- Removes white spaces on both left and right side
SELECT LTRIM('                sky            '); -- Removes white spaces on left side
SELECT RTRIM('                sky            '); -- Removes white spaces on right side


SELECT first_name, 
LEFT(first_name, 4), -- Takes 4 characters of the string on the left
RIGHT(first_name, 4), -- Takes 4 characters of the string on the right
SUBSTRING(first_name, 3, 2),  -- Starts at 3rd character and takes 2 characters
birth_date,
SUBSTRING(birth_date, 6, 2) AS birth_month -- Takes only the birthday month
FROM employee_demographics
;

-- REPLACE 
SELECT first_name, REPLACE(first_name, 'a', 'z') -- replace all lower case 'a' with lower case 'z' -- REPLACE is case sensitive
FROM employee_demographics
;

-- LOCATE
SELECT LOCATE('c', 'Lucas'); --  locates the position of 'c' in 'Lucas'

SELECT first_name, LOCATE('n', first_name) -- locates position of 'n' in all first names
FROM employee_demographics
;

-- CONCAT
SELECT first_name, last_name,
CONCAT(first_name,' ', last_name) AS full_name -- Combines both fname and lname together with a space in between
FROM employee_demographics
;