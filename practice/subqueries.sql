-- Subquery
USE parks_and_recreation;

-- subquery in WHERE statement
SELECT *
FROM employee_demographics
WHERE employee_id IN 					-- employee_id from demographics table matches with employee_id from salary table
				(SELECT employee_id
					FROM employee_salary
                    WHERE dept_id = 1)
;

-- subquery in SELECT statement
-- Comparing to avg salary of everyone
SELECT first_name, salary, 
(SELECT AVG(salary) 
	FROM employee_salary)
FROM employee_salary
;

-- subquery in FROM statement
SELECT gender, AVG(age), MAX(age), MIN(age), COUNT(age)
FROM employee_demographics
GROUP BY gender;
;

SELECT AVG (max_age)
FROM
(SELECT gender,
AVG(age) avg_age, 
MAX(age) max_age, 
MIN(age) min_age, 
COUNT(age) 
FROM employee_demographics
GROUP BY gender) AS Agg_Table
;