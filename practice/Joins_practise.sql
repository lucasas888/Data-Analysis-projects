-- JOINS in SQL
USE parks_and_recreation;

SELECT *
FROM employee_demographics
;

SELECT *
FROM employee_salary
;

SELECT *
FROM employee_demographics ed
JOIN employee_salary es
	ON ed.employee_id = es.employee_id
;

-- OUTER JOINS
SELECT *
FROM employee_demographics ed
RIGHT JOIN employee_salary es
	ON ed.employee_id = es.employee_id
;

-- SELF JOIN
SELECT emp1.employee_id AS emp_santa,
emp1.first_name AS fname_santa,
emp1.last_name AS lname_santa,
emp2.employee_id AS emp_name,
emp2.first_name AS fname_emp,
emp2.last_name AS lname_emp
FROM employee_salary emp1
JOIN employee_salary emp2
	ON emp1.employee_id + 1 = emp2.employee_id
;

-- JOINING MULTIPLE TABLES
SELECT *
FROM parks_departments;

SELECT *
FROM employee_demographics ed
JOIN employee_salary es
	ON ed.employee_id = es.employee_id
JOIN parks_departments pd
	ON es.dept_id = pd.department_id
;