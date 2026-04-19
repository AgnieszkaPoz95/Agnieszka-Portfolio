-- ============================================================
-- PROJECT: World Layoffs – Data Cleaning in MySQL
-- Author:  Agnieszka Poznańska
-- Dataset: World Layoffs (Kaggle)
-- Tool:    MySQL Workbench
-- 
-- Steps:
--   1. Remove Duplicates
--   2. Standardize the Data
--   3. Handle NULL and Blank Values
--   4. Remove Unusable Rows and Columns
-- ============================================================


-- ============================================================
-- SETUP: Create staging table to preserve raw data
-- ============================================================

CREATE TABLE layoffs_staging
LIKE layoffs;

INSERT INTO layoffs_staging
SELECT *
FROM layoffs;


-- ============================================================
-- STEP 1: REMOVE DUPLICATES
-- ============================================================

-- Identify duplicates using ROW_NUMBER() partitioned by all key columns.
-- Rows with row_num > 1 are exact duplicates.

-- Note: We cannot DELETE directly from a CTE in MySQL,
-- so we create a second staging table with row_num as a physical column.

CREATE TABLE layoffs_staging2 (
  `company`               TEXT,
  `location`              TEXT,
  `industry`              TEXT,
  `total_laid_off`        INT DEFAULT NULL,
  `percentage_laid_off`   TEXT,
  `date`                  TEXT,
  `stage`                 TEXT,
  `country`               TEXT,
  `funds_raised_millions` INT DEFAULT NULL,
  `row_num`               INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

INSERT INTO layoffs_staging2
SELECT *,
  ROW_NUMBER() OVER(
    PARTITION BY company, location, industry,
                 total_laid_off, percentage_laid_off,
                 `date`, stage, country, funds_raised_millions
  ) AS row_num
FROM layoffs_staging;

-- Verify duplicates before deleting
SELECT *
FROM layoffs_staging2
WHERE row_num > 1;

-- Delete duplicates
DELETE FROM layoffs_staging2
WHERE row_num > 1;


-- ============================================================
-- STEP 2: STANDARDIZE THE DATA
-- ============================================================

-- 2a. Trim leading/trailing whitespace from company names
UPDATE layoffs_staging2
SET company = TRIM(company);

-- 2b. Unify inconsistent industry names
-- Found: 'Crypto', 'Crypto Currency', 'CryptoCurrency' → standardize to 'Crypto'
SELECT DISTINCT industry
FROM layoffs_staging2
ORDER BY 1;

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

-- 2c. Fix country name formatting (remove trailing dots)
-- Found: 'United States.' alongside 'United States'
SELECT DISTINCT country
FROM layoffs_staging2
ORDER BY 1;

UPDATE layoffs_staging2
SET country = TRIM(TRAILING '.' FROM country);

-- 2d. Convert date column from TEXT to DATE format
-- Raw format: 'MM/DD/YYYY' stored as text
SELECT `date`, STR_TO_DATE(`date`, '%m/%d/%Y')
FROM layoffs_staging2;

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;


-- ============================================================
-- STEP 3: HANDLE NULL AND BLANK VALUES
-- ============================================================

-- 3a. Convert blank strings to NULL for consistency
UPDATE layoffs_staging2
SET industry = NULL
WHERE industry = '';

-- 3b. Populate NULL industry values using a self-JOIN
-- If a company appears multiple times and one row has an industry value,
-- use it to fill NULL rows for the same company.

-- Preview what will be updated
SELECT t1.company, t1.industry, t2.industry AS industry_fill
FROM layoffs_staging2 t1
JOIN layoffs_staging2 t2
  ON t1.company = t2.company
WHERE t1.industry IS NULL
  AND t2.industry IS NOT NULL;

-- Apply the update
UPDATE layoffs_staging2 t1
JOIN layoffs_staging2 t2
  ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL
  AND t2.industry IS NOT NULL;

-- Verify remaining NULLs (companies with no industry data at all)
SELECT *
FROM layoffs_staging2
WHERE industry IS NULL;


-- ============================================================
-- STEP 4: REMOVE UNUSABLE ROWS AND COLUMNS
-- ============================================================

-- 4a. Remove rows where both layoff metrics are NULL
-- These records have no analytical value
SELECT *
FROM layoffs_staging2
WHERE total_laid_off IS NULL
  AND percentage_laid_off IS NULL;

DELETE FROM layoffs_staging2
WHERE total_laid_off IS NULL
  AND percentage_laid_off IS NULL;

-- 4b. Drop the helper column used for deduplication
ALTER TABLE layoffs_staging2
DROP COLUMN row_num;


-- ============================================================
-- FINAL CHECK: Preview cleaned dataset
-- ============================================================

SELECT *
FROM layoffs_staging2
ORDER BY company;

-- ============================================================
-- END OF DATA CLEANING
-- ============================================================
