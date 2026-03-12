-- Data cleaning project
USE world_layoffs;

SELECT * 
FROM layoffs
;

-- 1. Remove duplicates
-- 2. Standardize data
-- 3. NULL values or blank values
-- 4. Remove any columns or rows(If needed)

-- Create a duplicate table of raw data (DO NOT TOUCH ORIGINAL TABLE)
CREATE TABLE layoffs_staging
LIKE layoffs
;

SELECT * 
FROM layoffs_staging
;

-- Populate duplicate table with data
INSERT layoffs_staging 
SELECT * 
FROM layoffs
;

-- Identifying duplicates by assigning all rows a row number that resets at every unique entry
SELECT *, 
ROW_NUMBER() OVER(PARTITION BY company, industry, total_laid_off, percentage_laid_off, `date`) AS row_num
FROM layoffs_staging
;

-- Create a CTE
WITH duplicate_cte AS
(
SELECT *, 
ROW_NUMBER() OVER(PARTITION BY company, location, industry, 
total_laid_off, percentage_laid_off, `date`, 
stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging
)
-- If row number is > 1, it means there is a duplicate
SELECT * 
FROM duplicate_cte
WHERE row_num > 1;

-- Trying to delete duplicate columns
WITH duplicate_cte AS
(
SELECT *, 
ROW_NUMBER() OVER(PARTITION BY company, location, industry, 
total_laid_off, percentage_laid_off, `date`, 
stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging
)
-- Unable to delete columns as DELETE is not updateable
DELETE 
FROM duplicate_cte
WHERE row_num > 1;

-- Creating ANOTHER duplicate layoff_staging table
CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT -- Insert an extra column for row_num, to identify duplicates
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT * 
FROM layoffs_staging2
;

-- Inserts data from CTE table with extra row_num column into staging2 table
INSERT INTO layoffs_staging2
SELECT *, 
ROW_NUMBER() OVER(PARTITION BY company, location, industry, 
total_laid_off, percentage_laid_off, `date`, 
stage, country, funds_raised_millions) AS row_num
FROM layoffs_staging
;

-- identify duplicates where row_num > 1
SELECT * 
FROM layoffs_staging2
;

-- Delete the duplicates from staging2 table
DELETE 
FROM layoffs_staging2
WHERE row_num > 1
;

-- standardizing data

-- Removing white spaces at the ends of company names
SELECT company, TRIM(company)
FROM layoffs_staging2
;

-- update the staging2 table so that there are no white spaces at the ends of the company name
UPDATE layoffs_staging2
SET company = TRIM(company)
;

-- Take a look at the industry columns, find industry names that can be updated
SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY industry
;

-- we realised that crypto may need to be updated
SELECT *
FROM layoffs_staging2
WHERE industry LIKE 'crypto%'
ORDER BY industry DESC
;

-- updating all industries relating to crypto to 'Crypto' name
UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%'
;

-- Checking locations column for any errors
SELECT DISTINCT location
FROM layoffs_staging2
ORDER BY 1
;

-- Checking country column for any errors
SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY 1
;

-- Error found in 'United States' country column
SELECT *
FROM layoffs_staging2
WHERE country LIKE 'United States%'
ORDER BY 1
;

-- Update country column from 'United States.' to 'United States'
UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%'
;

-- Convert date column from string to date
SELECT `date`, STR_TO_DATE(`date`, '%m/%d/%Y') AS fixed_date
FROM layoffs_staging2
ORDER BY fixed_date
;

-- Update date column
UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y')
;

-- Only do this on staging tables, NEVER ON RAW DATA TABLE
-- modify `date` column data type from text to date
ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

-- Dealing with NULL values
SELECT *
FROM layoffs_staging2
;

SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL
;

SELECT *
FROM layoffs_staging2
WHERE industry IS NULL
OR industry = ''
;

-- Cross check other AirBnb records to see if industry column is filled - Yes, under 'Travel' industry
SELECT *
FROM layoffs_staging2
WHERE company LIKE 'Bally%'
;

SELECT * 
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
WHERE (t1.industry IS NULL OR t1.industry = '')
AND t2.industry IS NOT NULL
;

-- Do a update with self join to populate blank and null industry
UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE (t1.industry IS NULL OR t1.industry = '')
AND (t2.industry IS NOT NULL AND t2.industry != '')
;

SELECT *
FROM layoffs_staging2
;

-- Removal of uneeded rows (delete rows where total_laid_off and %_laid_off are NULL)
DELETE
FROM layoffs_staging2
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL
;

-- Alter table and remove row_num column (not needeed)
ALTER TABLE layoffs_staging2
DROP COLUMN row_num
;

-- COMPLETED DATA CLEEANING