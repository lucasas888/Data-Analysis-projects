-- LIMIT & ALIASING 
USE parks_and_recreation;

SELECT *
FROM employee_demographics
ORDER BY age DESC
LIMIT 2, 3
;

SELECT first_name fname, last_name lname, age
FROM employee_demographics
WHERE age > 36
ORDER BY age, fname
;