## Product Demand Analysis using SQL

### Project Overview
This project focuses on analyzing product demand using SQL. The goal is to understand which products are in high demand, how demand varies over time, and how different customer and regional factors influence product sales.
This is a portfolio-ready SQL project designed for GitHub and suitable for Data Analyst roles.

### Dataset Used
Dataset Name: Online Retail Dataset
Source: UCI Machine Learning Repository / Kaggle
Link (Kaggle): https://www.kaggle.com/datasets/carrie1/ecommerce-data

### Dataset Description
* This dataset contains transactional data for an online retail store.
* Key Columns:
* InvoiceNo – Unique invoice number
* StockCode – Product ID
* Description – Product name
* Quantity – Units purchased
* InvoiceDate – Date of transaction
* UnitPrice – Price per unit
* CustomerID – Customer identifier
* Country – Customer country

### Business Questions

1. Which products have the highest demand?
2. Which products generate the most revenue?
3. How does product demand change monthly?
4. Which countries contribute most to product demand?
5. What are the low-demand products?
6. What is the average order quantity per product?
7. Identify seasonal trends in product demand

### Database Schema

CREATE TABLE online_retail (
invoice_no VARCHAR(20),
stock_code VARCHAR(20),
description TEXT,
quantity INT,
invoice_date TIMESTAMP,
unit_price DECIMAL(10,2),
customer_id INT,
country VARCHAR(50)
);

### Data Cleaning 

#### Remove cancelled orders

DELETE FROM online_retail
WHERE invoice_no LIKE 'C%';

#### Remove negative or zero quantities

DELETE FROM online_retail
WHERE quantity <= 0 OR unit_price <= 0;

#### Handling missing product descriptions

UPDATE online_retail
SET description = 'Unknown Product'
WHERE description IS NULL;

## SQL Analysis 

### Top 10 products by demand

SELECT description, SUM(quantity) AS total_units_sold
FROM online_retail
GROUP BY description
ORDER BY total_units_sold DESC
LIMIT 10;

### Top 10 products by revenue

SELECT description,
SUM(quantity * unit_price) AS total_revenue
FROM online_retail
GROUP BY description
ORDER BY total_revenue DESC
LIMIT 10;

### Monthly product demand trend

SELECT DATE_TRUNC('month', invoice_date) AS month,
SUM(quantity) AS total_quantity
FROM online_retail
GROUP BY month
ORDER BY month;

### Country-wise product demand

SELECT country, SUM(quantity) AS total_demand
FROM online_retail
GROUP BY country
ORDER BY total_demand DESC;

### Low-demand products

SELECT description, SUM(quantity) AS total_quantity
FROM online_retail
GROUP BY description
HAVING SUM(quantity) < 50
ORDER BY total_quantity ASC;

### Average order per product

SELECT description,
AVG(quantity) AS avg_quantity_per_order
FROM online_retail
GROUP BY description
ORDER BY avg_quantity_per_order DESC;

### Seasonal demand analysis

SELECT EXTRACT(MONTH FROM invoice_date) AS month,
SUM(quantity) AS total_quantity
FROM online_retail
GROUP BY month
ORDER BY month;

### Key Insights

* A small number of products contribute to a large portion of total demand
* Demand peaks during certain months, indicating seasonality
* UK contributes the majority of total product demand
* Several products show consistently low demand and may be discontinued

### Recommendations

* Focus inventory planning on high-demand products to prevent stockouts and lost sales.
* Use seasonal demand trends to optimize procurement and promotions during peak months.
* Review low-demand products for potential discontinuation, bundling, or targeted marketing.
* Prioritize key high-performing regions while exploring growth opportunities in underperforming markets.
* Continuously monitor product demand using SQL dashboards to support data-driven decision-making.

