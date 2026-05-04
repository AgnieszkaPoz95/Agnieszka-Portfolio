# World Layoffs – Exploratory Data Analysis (EDA) in SQL

## Project Overview
Performed exploratory data analysis on a cleaned dataset of global tech 
layoffs (2020–2023) using MySQL. The goal was to identify trends, rank top 
contributors to layoffs, and detect waves of workforce reductions over time.

This project is a continuation of the **World Layoffs – Data Cleaning** project.
It uses the cleaned dataset (`layoffs_staging2`) as the input.

## Dataset
- Source: Kaggle – World Layoffs Dataset
- ~2,000 records of company layoffs worldwide (2020–2023)

## Analysis Steps

### 1. Initial Overview
- Time range covered by the dataset
- Maximum scale of layoffs (largest single event, full-shutdown companies)

### 2. Companies That Shut Down (100% Layoffs)
- Identified companies that laid off 100% of workforce
- Sorted by funds raised – revealing how much capital was lost in failed ventures
- Sorted by total employees affected – measuring human impact

### 3. Aggregations: Where Layoffs Happened
- Total layoffs by company (largest layoff events overall)
- Total layoffs by industry (which sectors were hit hardest)
- Total layoffs by country (geographic concentration)
- Total layoffs by company stage (Series A, B, Post-IPO, etc.)
- Average percentage of workforce laid off per company

### 4. Trends Over Time
- Total layoffs by year
- Total layoffs by month (YYYY-MM format)

### 5. Rolling Total of Layoffs (Window Function)
- Cumulative sum of layoffs month by month using `SUM() OVER()`
- Shows how the layoff wave built up over time

### 6. Top 5 Companies by Layoffs Per Year
- Two-step CTE analysis using `DENSE_RANK()` with `PARTITION BY`
- Identifies which companies were the biggest contributors each year

## Key SQL Techniques Used

| Technique | Example in Project |
|---|---|
| **Aggregations** | SUM, MAX, MIN, AVG, COUNT |
| **GROUP BY** | Multi-column grouping (company + year) |
| **Date Functions** | `YEAR()`, `SUBSTRING()` for month extraction |
| **CTEs** | Multi-step CTE chains for complex analysis |
| **Window Functions** | `SUM() OVER()` for rolling totals |
| **Ranking** | `DENSE_RANK() OVER (PARTITION BY ... ORDER BY ...)` |
| **Top N Pattern** | Filtering ranked results to top 5 per group |

## Tools
MySQL · MySQL Workbench

## Files
| File | Description |
|---|---|
| `Data_Exploratory_Analysis_Project.sql` | Full SQL script with all analysis queries |
| `README.md` | This file |

## Related Project
🔗 [World Layoffs – Data Cleaning in SQL](../sql-layoffs-project/) – the data 
preparation step that produced the input table for this analysis.
