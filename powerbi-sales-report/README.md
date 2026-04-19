# Adventure Works – Sales Analytics Dashboard in Power BI
 
## Project Overview
Built a multi-page interactive sales dashboard using the Adventure Works dataset,
covering sales data from 2005 to 2008 across 6 countries.
 
The goal was to analyze sales performance, product trends, customer demographics,
and regional profitability — and to present the findings in a clear, interactive format
for business stakeholders.
 
## Dataset
- Source: Adventure Works (Microsoft sample dataset)
- Loaded and transformed in Power Query
- Data covers: sales transactions, products, customers, territories (2005–2008)
## Dashboard Pages
 
### 1. Sales Overview
High-level view of sales trends over time and by geography.
- Sales by time and temperature range (grouped bar chart)
- Cumulative sales growth by territory and year (waterfall chart)
- Geographic sales distribution (map)
- Interactive slicers: Year, Quarter, Month
### 2. Performance
Financial KPIs and year-over-year comparisons.
- KPI cards: Total Sales ($29.36M), Total Cost ($17.28M), Profit ($12.08M),
  Profit Margin (41.15%), Total Transactions (60K), Total Customers (18K)
- Sales vs Sales Previous Year (yearly comparison)
- YTD Sales vs YTD Sales Previous Year (monthly trend)
- Profit Margin by Sales Territory Country
- Sales vs Sales PY by Month and Quarter (gauge visuals)
### 3. Product Details
Granular product-level analysis with category and subcategory breakdown.
- Sales by product category (donut chart)
- Top 5 subcategories by sales (bar chart)
- Sales evolution by subcategory over time (streamgraph)
- Sales by product name and month (matrix table)
- Slicer: Color filter
### 4. Customer
Customer segmentation and demographic analysis.
- Sales by customer occupation (horizontal bar chart)
- Sales by customer country (donut chart)
- Geographic distribution of customers (map)
- Sales by gender over time (clustered bar chart)
- Slicers: Year, Quarter, Month, Age breakdown, Income breakdown
### 5. Sales Territory Country (Drillthrough)
Dedicated drillthrough page — accessible by right-clicking any country in other pages.
- Country-level KPI cards
- Sales and transactions by year
- Sales by occupation and quarter (treemap)
- Sales vs Previous Year comparison
- Back button navigation
## Key Power BI Features Used
- **DAX measures:** Total Sales, Total Cost, Profit, Profit Margin,
  Sales PY, Sales vs PY, YTD Sales, YTD Sales PY (SPLY)
- **Drillthrough** page navigation between report pages
- **Custom navigation buttons** in the sidebar
- **Advanced visuals:** Waterfall chart, Streamgraph, Treemap, KPI gauge
- **Multiple synchronized slicers** across pages
- **Geographic map** visualizations
## Key Findings
 
1. **Strong revenue growth:** Total sales grew from ~$3.4M in 2005 to ~$9.8M in 2008,
   representing nearly 3x growth over 4 years.
2. **United States is the dominant market:** The US accounts for 35.34% of total
   transactions and generates the highest absolute profit, though profit margins
   are consistent across all territories (40.68%–41.96%).
3. **Bikes drive almost all revenue:** The Bikes category represents 96.46% of
   total sales ($28.32M out of $29.36M). Road Bikes alone account for $14.52M.
   Accessories and Clothing are negligible in comparison.
4. **Professional customers are the most valuable segment:** The Professional
   occupation group generates $9.91M (33.75% of total sales), significantly
   outperforming other segments.
5. **Warm climate correlates with higher sales:** In the Sales by Temperature Range
   chart, Warm category consistently shows the highest sales values, particularly
   visible in 2007 and 2008.
6. **Sales plateau in 2007–2008:** Despite overall growth, the YTD comparison
   shows that growth slowed between 2007 and 2008, suggesting market saturation
   or seasonal effects worth investigating further.
## Tools
Power BI Desktop · Power Query · DAX · Excel · Adventure Works Dataset
