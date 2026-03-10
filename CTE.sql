-- CTEs
USE parks_and_recreation;

-- CTEs are cleaner and easier to reuse compared to subqueries
-- CTEs are like temp views
WITH CTE_Example AS
(
	SELECT gender, AVG(salary) avg_sal, MAX(salary) max_sal, MIN(salary) min_sal, COUNT(salary) count_sal
    FROM employee_demographics dem
    JOIN employee_salary sal
		ON dem.employee_id = sal.employee_id
	GROUP BY gender
)

SELECT AVG(avg_sal)
FROM CTE_Example
;