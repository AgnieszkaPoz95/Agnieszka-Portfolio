
-- ============================================================
-- PROJECT: World Layoffs – Exploratory Data Analysis (EDA) in MySQL
-- Author:  Agnieszka Poznańska
-- Dataset: World Layoffs (Kaggle, 2020–2023)
-- Tool:    MySQL Workbench
-- 
-- Note:    This project uses the cleaned dataset (layoffs_staging2) 
--          produced in the "World Layoffs – Data Cleaning" project.
-- 
-- Goals:
--   1. Identify scale of layoffs (companies, industries, countries)
--   2. Analyze trends over time
--   3. Rank top companies and industries
--   4. Calculate rolling totals to detect waves of layoffs
-- ============================================================


-- ============================================================
-- STEP 1: INITIAL OVERVIEW – Understanding the dataset
-- ============================================================

-- Preview the cleaned data
SELECT *
FROM layoffs_staging2;

-- Check the time range covered by the dataset
SELECT MIN(`date`) AS earliest_date, 
       MAX(`date`) AS latest_date
FROM layoffs_staging2;

-- Check the maximum scale of layoffs
-- total_laid_off: largest single layoff event
-- percentage_laid_off: 1.00 means 100% workforce cut (company shutdown)
SELECT MAX(total_laid_off) AS max_layoffs, 
       MAX(percentage_laid_off) AS max_percentage
FROM layoffs_staging2;


-- ============================================================
-- STEP 2: COMPANIES THAT LAID OFF 100% OF THEIR WORKFORCE
-- ============================================================

-- Companies that completely shut down – ordered by funds raised
-- This helps identify how much money was lost in failed ventures
SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY funds_raised_millions DESC;

-- Same companies – ordered by absolute number of employees laid off
SELECT *
FROM layoffs_staging2
WHERE percentage_laid_off = 1
ORDER BY total_laid_off DESC;


-- ============================================================
-- STEP 3: AGGREGATIONS – Layoffs by Company, Industry, Country
-- ============================================================

-- Total layoffs by company (largest layoff events overall)
SELECT company, 
       SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY company
ORDER BY total_layoffs DESC;

-- Total layoffs by industry (which sectors were hit hardest)
SELECT industry, 
       SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY industry
ORDER BY total_layoffs DESC;

-- Total layoffs by country
SELECT country, 
       SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY country
ORDER BY total_layoffs DESC;

-- Total layoffs by company stage (Series A, B, Post-IPO, etc.)
-- Reveals which growth stages were most affected
SELECT stage, 
       SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY stage
ORDER BY total_layoffs DESC;

-- Average percentage of workforce laid off per company
SELECT company, 
       AVG(percentage_laid_off) AS avg_percentage_laid_off
FROM layoffs_staging2
GROUP BY company
ORDER BY avg_percentage_laid_off DESC;


-- ============================================================
-- STEP 4: TRENDS OVER TIME
-- ============================================================

-- Total layoffs by year
SELECT YEAR(`date`) AS year, 
       SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY YEAR(`date`)
ORDER BY year DESC;

-- Total layoffs by month (YYYY-MM format)
-- Reveals month-by-month dynamics across the entire period
SELECT SUBSTRING(`date`, 1, 7) AS `month`, 
       SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
GROUP BY `month`
ORDER BY `month` ASC;


-- ============================================================
-- STEP 5: ROLLING TOTAL OF LAYOFFS (Window Function)
-- ============================================================

-- Cumulative sum of layoffs month by month
-- Uses a CTE + SUM() OVER() window function
-- Shows how the layoff wave built up over time
WITH Rolling_Total AS (
    SELECT SUBSTRING(`date`, 1, 7) AS `month`, 
           SUM(total_laid_off) AS total_off
    FROM layoffs_staging2
    WHERE SUBSTRING(`date`, 1, 7) IS NOT NULL
    GROUP BY `month`
)
SELECT `month`, 
       total_off, 
       SUM(total_off) OVER (ORDER BY `month`) AS rolling_total
FROM Rolling_Total
ORDER BY `month` ASC;


-- ============================================================
-- STEP 6: TOP 5 COMPANIES BY LAYOFFS PER YEAR
-- ============================================================

-- Two-step CTE analysis using DENSE_RANK with PARTITION BY:
--   1. Aggregate layoffs by company and year
--   2. Rank companies within each year, return top 5

-- Layoffs by company and year (intermediate step)
SELECT company, 
       YEAR(`date`) AS year, 
       SUM(total_laid_off) AS total_layoffs
FROM layoffs_staging2
GROUP BY company, YEAR(`date`)
ORDER BY total_layoffs DESC;

-- Top 5 companies with the largest layoffs in each year
WITH Company_Year (company, years, total_laid_off) AS (
    SELECT company, 
           YEAR(`date`), 
           SUM(total_laid_off)
    FROM layoffs_staging2
    GROUP BY company, YEAR(`date`)
),
Company_Year_Rank AS (
    SELECT *, 
           DENSE_RANK() OVER (PARTITION BY years ORDER BY total_laid_off DESC) AS ranking
    FROM Company_Year
    WHERE years IS NOT NULL
)
SELECT *
FROM Company_Year_Rank
WHERE ranking <= 5
ORDER BY years, ranking;


-- ============================================================
-- KEY SQL TECHNIQUES USED IN THIS PROJECT
-- ============================================================
-- - Aggregations: SUM, MAX, MIN, AVG, COUNT
-- - GROUP BY with multiple columns
-- - ORDER BY with multiple sorting criteria
-- - Date functions: YEAR(), SUBSTRING()
-- - WHERE filtering with conditions
-- - CTEs (Common Table Expressions) – single and multi-step
-- - Window Functions: SUM() OVER() for rolling totals
-- - DENSE_RANK() with PARTITION BY for ranking within groups
-- - Filtering ranked results (Top N pattern)
-- ============================================================


-- ============================================================
-- END OF EXPLORATORY DATA ANALYSIS
-- ============================================================
