# Adventure Works – Sales Analytics Dashboard in Power BI
 
## 📊 Project Overview
End-to-end data analytics project analyzing business data from the Adventure Works
dataset to uncover insights into sales, product performance, and customer behavior.
The analysis covers the period from **July 2005 to July 2008** across **6 countries**
and **3 product categories**, answering 5 key business questions through an
interactive 5-page Power BI dashboard.
 
**Key metrics analyzed:** Total Sales · Total Cost · Profit · Profit Margin ·
Total Transactions · Total Customers
 
---
 
## 🎯 Key Business Questions
 
1. Which product categories and subcategories generate the most revenue?
   What was the most popular product in 2005–2008?
2. How do sales trends vary by sales region and customer demographics?
3. What are the seasonal patterns in product demand?
4. When was the Peak Sales Period?
5. Did the temperature range have an impact on sales volume?
---
 
## 🛠️ Project Workflow
 
### Step 1 – Data Preparation in Excel
Extracted source data into Excel, with each table placed on a separate sheet
to enable transformation in Power Query Editor.
 
### Step 2 – Data Loading and Transformation (Power Query Editor)
- Selected relevant columns for analysis using *Choose Columns*
- Verified and corrected data types
- Removed empty rows
- Verified column quality for the entire model:
  **100% valid · 0% errors · 0% empty** across all columns
### Step 3 – Data Modeling (Snowflake Schema)
 
**Fact table:** Internet Sales (quantitative data: sales, cost, profit, profit margin)
 
**Dimension tables:** Product · Date · Sales Territory · Temperature · Customer
 
**Custom tables created using query merging:**
- **Geography** — duplicated from Customer, added Geography Key (index column),
  then merged back into Customer by CustomerCity, CustomerState, CustomerCountry
- **CategSubcateg** — duplicated from Product, added CategSubCateg Key,
  then merged back into Product by Category and SubCategory
**Schema structure (Snowflake):**
- CategSubcateg → Product → Internet Sales
- Geography → Customer → Internet Sales
Additional setup: Date table marked as official date table; active relationship
between Date and Internet Sales created via Order Date.
 
### Step 4 – Calculated Columns
 
| Table | Calculated Columns |
|---|---|
| **Customer** | Age, Age breakdown, Full name, Income breakdown, Last purchase date, Number of transactions, Sum of sales |
| **Internet Sales** | Sales amount as CC, Temperature key |
| **Sales Territory** | Total Transactions |
 
### Step 5 – DAX Measures
 
| Measure | DAX Formula |
|---|---|
| **Total Sales** | `SUM('Internet Sales'[Sales Amount])` |
| **Total Cost** | `SUM('Internet Sales'[Total Product Cost])` |
| **Profit** | `[Total Sales] - [Total Cost]` |
| **Profit Margin** | `DIVIDE([Profit], [Total Sales])` |
| **Total Customers** | `DISTINCTCOUNT('Customer'[Full Name])` |
| **Total Transactions** | `COUNTROWS('Internet Sales')` |
| **Total Sales PY (SPLY)** | `CALCULATE([Total Sales], SAMEPERIODLASTYEAR('Date'[Date]))` |
| **Total Transactions PY** | `CALCULATE([Total Transactions], SAMEPERIODLASTYEAR('Date'[Date]))` |
| **YTD Sales** | `TOTALYTD([Total Sales], 'Date'[Date])` |
| **YTD Sales PY (SPLY)** | `CALCULATE([YTD Sales], SAMEPERIODLASTYEAR('Date'[Date]))` |
 
**Time Intelligence functions used:** `CALCULATE` · `SAMEPERIODLASTYEAR` · `TOTALYTD`
 
### Step 6 – Data Visualization and Analysis
Built a 5-page interactive dashboard with synchronized navigation, drillthrough
capabilities, and multiple slicers for filtering and exploration.
 
---
 
## 📑 Dashboard Pages
 
### Page 1 – Sales Overview
![Sales Overview](screenshots/01_sales_overview.png)
 
High-level view of sales trends by time, temperature range, and geography.
 
- **Sales by Time and Temperature Range** (clustered bar chart)
- **Sales by Time and Sales Territory Country** (waterfall chart, max breakdown: 4)
- **Sales by Time** (area chart with Calendar hierarchy: Year → Quarter → Month)
- **Sales by Sales Territory Country** (filled map with conditional formatting —
  red for lowest sales, green for highest)
- Page Navigator Buttons for quick navigation between report pages
- Slicers: Year · Quarter · Month
### Page 2 – Performance
![Performance](screenshots/02_performance.png)
 
Financial KPIs and year-over-year comparisons.
 
- **KPI Cards:** Total Sales ($29.36M) · Total Cost ($17.28M) · Profit ($12.08M) ·
  Profit Margin (41.15%) · Total Transactions (60K) · Total Customers (18K)
- **Sales vs Sales PY** (yearly comparison)
- **YTD Sales vs YTD Sales PY** (monthly YTD trend)
- **Sales vs Sales PY (Month)** – KPI gauge: value vs prior-year target
- **Sales vs Sales PY (Quarter)** – KPI gauge: value vs prior-year target
- **Profit Margin by Sales Territory Country**
- **Sales and Profit by Sales Territory Country**
- **Total Transactions by Sales Territory Country** (pie chart)
- Slicers: Year · Quarter · Month
### Page 3 – Product Details
![Product Details](screenshots/03_product_details.png)
 
Granular product-level analysis.
 
- **Sales by Product Category** (donut chart)
- **Top 5 Product Subcategories** (bar chart)
- **Sales by Time and Product SubCategory** (streamgraph)
- **Sales by Product Name and Months** (matrix table)
- Slicers: Year · Quarter · Month · Color
### Page 4 – Customer
![Customer](screenshots/04_customer.png)
 
Customer segmentation and demographic analysis.
 
- **Sales by Customer Occupation** (horizontal bar chart)
- **Sales by Customer Demography** (donut chart with Geography hierarchy:
  Country → State → City)
- **Profit by Customer Demography** (map)
- **Sales by Gender in Time** (clustered bar chart)
- Slicers: Year · Quarter · Month · Age breakdown · Income breakdown
- Note: Slicers are intentionally NOT synchronized across pages to maintain
  independent filtering per analysis context
### Page 5 – Sales Territory Country (Drillthrough)
![Drillthrough](screenshots/05_drillthrough_territory.png)
 
Dedicated drillthrough page — accessible by right-clicking any country in other pages.
 
- Page type set to **Drillthrough** (drill through from: Sales Territory Country)
- Country-level KPI cards: Total Sales · Total Cost · Profit · Profit Margin ·
  Total Transactions · Total Customers
- **Sales by Year** (horizontal bar chart)
- **Number of Transactions by Year**
- **Sales by Occupation and Quarter** (treemap)
- **Sales vs Sales PY** (bar chart)
- **Sales vs Sales PY (Month)** – KPI gauge
- **Back button** for navigation back to the source page
---
 
## 🔍 Key Findings
 
### 1. Peak Sales Period – 2008 Shows Strongest Growth
Total sales between 2005 and 2008 reached **$29.36M**. The highest sales were
recorded in 2007 ($9.79M) and 2008 ($9.77M). Since 2008 data covers only
January–July, a fair comparison required calculating average monthly sales:
 
| Year | Total Sales | Months | Average Monthly Sales |
|---|---|---|---|
| 2007 | $9,791,060 | 12 | **$815,922** |
| 2008 | $9,770,900 | 7 | **$1,395,843** |
 
**Conclusion:** Average monthly sales in 2008 were **71% higher** than in 2007,
indicating strong growth momentum. Sales peaked at $1.95M in June 2008.
 
### 2. Bikes Dominate Revenue – 96.46% of All Sales
The Bikes category generated nearly all revenue ($28.32M out of $29.36M).
In 2005 and 2006, Bikes represented 100% of sales — Accessories and Clothing
were only introduced in 2007.
 
**Top 3 subcategories:**
- Road Bikes: $14.52M
- Mountain Bikes: $9.95M
- Touring Bikes: $3.84M (introduced in 2007)
**Best-selling product:** Mountain-200 Black, 46 with $1.37M in sales.
 
**Interesting shift:** In 2005–2006, Road Bikes were #1; in 2007–2008,
Mountain Bikes took the lead.
 
### 3. United States and Australia Lead All Markets
| Country | Total Sales | % of Transactions | Profit Margin |
|---|---|---|---|
| United States | $9.39M | 35.34% | 41.54% |
| Australia | $9.06M | 22.1% | 40.68% |
| Canada | $1.98M | lowest | 41.96% (highest) |
 
Profit margins were consistent across all territories (~40–42%), suggesting
efficient cost structure regardless of market size.
 
### 4. Professional Customers Drive the Most Revenue – With Demographic Nuances
Overall, Professional occupations generated 33.75% of total sales ($9.91M),
followed by Skilled Manual (21.94%). However, segmentation reveals important patterns:
 
- **Ages 35–44:** Manual occupations dominated (~50% of sales in this group)
- **Ages 45–54:** Professional led (28.56%), then Skilled Manual (25.61%)
- **Ages 55+:** Professional led (35.79%), then Management (21.39%)
**Income segmentation:** For customers earning >$100K, Management occupation
generated ~60% of sales. For $50–100K income bracket, Professional led (54.83%).
 
### 5. Seasonal Demand Patterns
Peak demand months: **May, June, and December**.
A significant spike occurred in December 2007 ($1.73M), followed by a January 2008
dip ($1.34M), before rebounding to an all-time peak in June 2008 ($1.95M).
 
### 6. Temperature Impacts Sales Volume
Warm temperature range consistently correlated with the highest sales across
all years (2005–2008). Hot temperature range showed the lowest sales volumes.
 
### 7. Year-over-Year Sales Comparison
- **Q3 2006 – Q2 2007:** Current-year sales slightly lower than prior year
- **Q3 2007 – Q2 2008:** Current-year sales significantly higher than prior year
The business showed a clear inflection point in Q3 2007, after which growth
accelerated consistently.
 
---
 
## ✨ Key Power BI Features Used
- **DAX Time Intelligence:** SAMEPERIODLASTYEAR, TOTALYTD, CALCULATE
- **Drillthrough** page navigation (right-click on any country)
- **Custom Page Navigator Buttons** in the sidebar
- **Snowflake schema** data model with custom tables
- **Advanced visuals:** Waterfall chart · Streamgraph · Treemap · KPI gauge · Filled map
- **Conditional formatting** on geographic maps
- **Multiple slicers** with intentional non-synchronization across pages
- **Calendar hierarchy** (Year → Quarter → Month)
- **Geography hierarchy** (Country → State → City)
- **Query merging** to create custom dimension tables
---
 
## 🧰 Tools
Power BI Desktop · Power Query · DAX · Excel · Adventure Works Dataset
 
---
 
## 📁 Files in This Repository
 
| File | Description |
|---|---|
| `adventure_works_sales_dashboard.pbix` | Power BI project file |
| `adventure_works_raw_data.xlsx` | Source data (Excel) |
| `adventure_works_project_description.docx` | Detailed project documentation |
| `screenshots/` | Dashboard screenshots (all 5 pages) |
| `README.md` | This file |
 
---
 
## 📝 Note on Time Period
Sales data covers **July 2005 to July 2008**. The analysis uses **calendar years**
(January–December), not fiscal years. Year-over-year comparisons at the quarter
and month level were prioritized to ensure fair comparisons given the partial-year
data in 2005 and 2008.
