USE parks_and_recreation;

SELECT *
FROM employee_salary
WHERE salary >= 45000;

-- using % and _ in strings
-- % means any character
-- _ means fixed number of characters

-- Using % before and after 'e' to find any names with 'e' inside it
SELECT *
FROM employee_demographics
WHERE first_name LIKE '%e%';

-- Using _ before and after 'e' to find 1 character before and after it
SELECT *
FROM employee_demographics
WHERE first_name LIKE '_e_';