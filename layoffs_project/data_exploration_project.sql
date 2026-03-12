-- Exploratory data analysis on world_layoffs
-- Look at layoffs_staging2 table (cleaned in previous data cleaning project)

USE world_layoffs;

SELECT * 
FROM layoffs_staging2;

-- what was the HIGHEST total layoffs and the % of layoff? (not 100% accuratee as some companies did not include values)
SELECT MAX(total_laid_off), MAX(percentage_laid_off)
FROM layoffs_staging2;

-- See which companies did a 100% layoff (Business that went under)
SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY country;

-- Which country had the most businesses shut down?
SELECT country, COUNT(country) AS Companies_closed
FROM layoffs_staging2
WHERE percentage_laid_off = 1
GROUP BY country
ORDER BY country;

-- Number of layoffs for each company
SELECT company, SUM(total_laid_off) AS Total_LayOffs
FROM layoffs_staging2
GROUP BY company
ORDER BY 2 DESC;

-- Show the date range when these layoffs started
SELECT MIN(`date`), MAX(`date`)
FROM layoffs_staging2;

-- Which industry had the most layoffs?
SELECT industry, SUM(total_laid_off) AS Total_LayOffs
FROM layoffs_staging2
GROUP BY industry
ORDER BY 2 DESC;

-- Which country had the most layoffs?
SELECT country, SUM(total_laid_off) AS Total_LayOffs
FROM layoffs_staging2
GROUP BY country
ORDER BY 2 DESC;

-- Which year had the most layoffs?
SELECT YEAR(`date`), SUM(total_laid_off) AS Total_LayOffs
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY 1 DESC;

-- Which stage had the most layoffs?
SELECT stage, SUM(total_laid_off) AS Total_LayOffs
FROM layoffs_staging2
GROUP BY stage
ORDER BY 2 DESC;

-- How many laid off per month?
SELECT SUBSTR(`date`, 1, 7)  AS `month`, SUM(total_laid_off) AS laid_off
FROM layoffs_staging2
WHERE SUBSTR(`date`, 1, 7) IS NOT NULL
GROUP BY `month`
ORDER BY `month`;

-- Do a rolling total of laid off per month?
WITH rolling_total AS
(
SELECT SUBSTR(`date`, 1, 7)  AS `month`, SUM(total_laid_off) AS laid_off
FROM layoffs_staging2
WHERE SUBSTR(`date`, 1, 7) IS NOT NULL
GROUP BY `month`
ORDER BY 1 ASC
)
SELECT `month`, laid_off, SUM(laid_off) OVER(ORDER BY `month`) AS rolling_total
FROM rolling_total;

-- Companies laying off per year
SELECT company, YEAR(`date`), SUM(total_laid_off) AS Total_LayOffs
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY 3 DESC;

WITH company_year (company, years, total_laid_off) AS
(
SELECT company, YEAR(`date`), SUM(total_laid_off) AS Total_LayOffs
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
), company_year_rank AS
(
SELECT *, DENSE_RANK() OVER(PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
FROM company_year
WHERE years IS NOT NULL
)
SELECT * 
FROM company_year_rank
WHERE ranking <= 5;