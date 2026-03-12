-- Triggers and Events
USE parks_and_recreation;

SELECT *
FROM employee_salary
;

SELECT *
FROM employee_demographics
;

DELIMITER $$
CREATE TRIGGER employee_insert -- creeate trigger
	AFTER INSERT ON employee_salary -- after data is inserteed into employee salary
    FOR EACH ROW -- for each row that is added, insert into demographics table
BEGIN
	INSERT INTO employee_demographics (employee_id, first_name, last_name)
    VALUES (NEW.employee_id, NEW.first_name, NEW.last_name)
    ;
END $$
DELIMITER ;

-- Test the trigger
INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES (13, 'Luis', 'Suarez', 'Barcelona Striker', 520000, NULL)
;


-- EVENTS
-- Use for scheduled automation e.g daily/weekly/monthly reports

SELECT *
FROM employee_demographics
;

-- create event
DELIMITER $$
DROP EVENT IF EXISTS delete_retirees;
CREATE EVENT delete_retirees
ON SCHEDULE EVERY 30 SECOND
DO
BEGIN
	DELETE
    FROM employee_demographics
    WHERE age >= 60;
END $$
DELIMITER ;


    