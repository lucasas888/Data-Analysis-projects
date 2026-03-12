-- Stored procedures
-- Basically, SQL version of functions

USE parks_and_recreation;

-- Not a good example, too simple
CREATE PROCEDURE large_salaries()
SELECT * 
FROM employee_salary
WHERE salary > 50000
;

CALL large_salaries();

-- Change delimiter from ; to $$ in order to stack multiple queries into one procedure
DELIMITER $$
CREATE PROCEDURE large_salaries2()
BEGIN
	SELECT *
    FROM employee_salary
    WHERE salary >= 50000;
    SELECT *
    FROM employee_salary
    WHERE salary >= 10000;
END $$ -- delimiter was changed to $$ above
DELIMITER ; -- must change back from $$ to ;

CALL large_salaries2();

-- procedures with parameters (functions with parameters)
DELIMITER $$
CREATE PROCEDURE large_salaries3(empID INT)
BEGIN
	SELECT salary
    FROM employee_salary
    WHERE employee_id = empID
    ;
END $$ -- delimiter was changed to $$ above
DELIMITER ; -- must change back from $$ to ;

CALL large_salaries3(5);