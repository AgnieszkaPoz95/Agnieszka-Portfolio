# World Layoffs – Data Cleaning in SQL

## Project Overview
Cleaned and standardized a real-world dataset containing global tech 
layoffs data (2020–2023) using MySQL. The goal was to prepare raw, 
messy data for further analysis.

## Dataset
- Source: Kaggle – World Layoffs Dataset
- ~2,000 records of company layoffs worldwide

## Data Cleaning Steps

### 1. Removed Duplicates
Used ROW_NUMBER() with PARTITION BY across all key columns 
to identify and delete exact duplicate records.

### 2. Standardized Data
- Trimmed whitespace from company names
- Unified inconsistent industry names 
  (e.g. 'Crypto Currency', 'CryptoCurrency' → 'Crypto')
- Fixed country name formatting (removed trailing dots)
- Converted date column from TEXT to proper DATE format 
  using STR_TO_DATE()

### 3. Handled Null & Blank Values
- Converted blank strings to NULL for consistency
- Used self-JOIN to populate NULL industry values 
  where the same company had the value in another row

### 4. Removed Unusable Rows
- Deleted records where both total_laid_off 
  and percentage_laid_off were NULL (no useful data)

## Key SQL Techniques Used
- CTEs (WITH clause)
- Window Functions (ROW_NUMBER, PARTITION BY)
- Self JOIN for data population
- STR_TO_DATE, TRIM, ALTER TABLE
- Staging tables pattern (raw → staging → cleaned)

## Tools
MySQL · MySQL Workbench
