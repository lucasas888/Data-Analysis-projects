-- temporary tables
-- using temp tables is good for heavy calculation
-- temp tables clear when you close the SQL workbench
USE parks_and_recreation;

CREATE TEMPORARY TABLE temp_table
(first_name varchar(50),
last_name varchar(50),
fav_movie varchar(100)
);

INSERT INTO temp_table
VALUES ('Lucas', 'Chew', 'Avengers')
;

SELECT * 
FROM temp_table
;

-- You can create a temp table of an existing table
CREATE TEMPORARY TABLE salary_over_50k
SELECT * 
FROM employee_salary
WHERE salary > 50000
;

SELECT * 
FROM salary_over_50k
;