-- case statements
USE parks_and_recreation;

SELECT first_name,
last_name,
age,
CASE
	WHEN age <= 30 THEN 'Young'
    WHEN age BETWEEN 31 AND 50 THEN 'Old'
    WHEN age >= 50 THEN 'Dying Soon'
END AS Age_Bracket
FROM employee_demographics
;

-- Pay Increase and Bonus
-- < 50000 = 5% increase
-- > 50000 = 7% increase
-- Finance Dept = 10% bonus

SELECT * 
FROM employee_salary
;

SELECT * 
FROM parks_departments
;

SELECT first_name, last_name, salary,
CASE
	WHEN salary < 50000 THEN salary + (salary * 0.05)
    WHEN salary > 50000 THEN salary + (salary * 0.07)
END AS New_Salary,
CASE 
	WHEN dept_id = 6 THEN salary * 0.1
END AS Finance_Bonus
FROM employee_salary
;