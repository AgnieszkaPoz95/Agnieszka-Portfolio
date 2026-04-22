# World Layoffs – Data Cleaning in SQL
 
## Project Overview
Cleaned and standardized a real-world dataset containing global tech layoffs
data (2020–2023) using MySQL. The goal was to prepare raw, messy data for
further analysis.
 
## Dataset
- Source: Kaggle – World Layoffs Dataset
- ~2,000 records of company layoffs worldwide
## Data Cleaning Steps
 
### 1. Removed Duplicates
Identified and removed exact duplicate records using two complementary approaches:
 
- **CTE with ROW_NUMBER()** — used for duplicate identification.
  Clean and readable, but MySQL does not allow DELETE directly from a CTE.
- **Staging table with row_num column** — used for actual deletion.
  Chosen as the final solution because it allows both identification
  and deletion in a MySQL-compatible way.
Both approaches used `ROW_NUMBER()` with `PARTITION BY` across all key columns
to detect exact duplicates.
 
### 2. Standardized Data
- Trimmed whitespace from company names
- Unified inconsistent industry names
  (e.g. 'Crypto Currency', 'CryptoCurrency' → 'Crypto')
- Fixed country name formatting (removed trailing dots)
- Converted date column from TEXT to proper DATE format
  using `STR_TO_DATE()`
### 3. Handled Null & Blank Values
- Converted blank strings to NULL for consistency
- Used self-JOIN to populate NULL industry values where the same company
  had the value in another row
### 4. Removed Unusable Rows
- Deleted records where both `total_laid_off` and `percentage_laid_off`
  were NULL (no useful data)
## Technical Note: CTE vs Staging Table
 
MySQL does not support `DELETE` from a CTE directly. Two approaches were tested:
 
| Approach | Use Case | Chosen? |
|---|---|---|
| CTE with ROW_NUMBER() | Duplicate identification / preview | No (MySQL limitation) |
| Staging table with row_num column | Identification AND deletion | **Yes** (final solution) |
 
The staging table approach was chosen because it allows both identification
and deletion in a MySQL-compatible way. This decision demonstrates
an understanding of database engine constraints.
 
## Key SQL Techniques Used
- **CTEs** (WITH clause)
- **Window Functions** (ROW_NUMBER, PARTITION BY)
- **Self JOIN** for data population
- **String functions:** STR_TO_DATE, TRIM, TRIM TRAILING
- **DDL operations:** ALTER TABLE, MODIFY COLUMN, DROP COLUMN
- **Staging tables** pattern (raw → staging → cleaned)
## Tools
MySQL · MySQL Workbench
 
## Files
| File | Description |
|---|---|
| `Data Cleaning Project.sql` | Full SQL script with all cleaning steps |
| `README.md` | This file |
