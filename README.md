# 🛒 E-Commerce Sales Analysis — MySQL

## 📌 Project Overview
Analysis of **541,909 real retail transactions** from a UK-based online 
retailer using MySQL. The goal was to clean raw transactional data and 
extract actionable business insights across revenue, customers, and products.

- **Tool:** MySQL 8.0 & MySQL Workbench  
- **Dataset:** UCI Online Retail Dataset (Dec 2010 – Dec 2011)  
- **Records analysed:** 397,880 (after cleaning)

---

## ❓ Business Questions Answered
1. What are the monthly revenue trends across the year?
2. Which months drive the most sales?
3. Who are the top customers by lifetime spend?
4. Which products generate the most revenue?
5. How does revenue vary across countries?
6. What percentage of customers are one-time vs loyal buyers?
7. How does revenue grow month over month?

---

## 🗂️ Repository Structure
ecommerce-sql-analysis/
│
├── README.md
├── sql/
│   ├── schema.sql        # Table creation & data cleaning
│   ├── analysis.sql      # All analysis queries
│   └── views.sql         # Views & stored procedure

---

## 🧹 Data Cleaning
The raw dataset contained several issues that were resolved before analysis:

| Issue | Rows affected | Action taken |
|---|---|---|
| Missing CustomerID | ~135,000 | Removed |
| Cancelled orders (InvoiceNo starting with 'C') | ~8,000 | Removed |
| Negative quantities (returns) | ~1,000 | Removed |
| Zero or negative unit prices | ~400 | Removed |
| **Clean dataset** | **397,880** | Used for all analysis |

---

## 📊 Key Findings

### Revenue & Orders
- **Total revenue:** £8,911,407 across 18,532 orders
- **Unique customers:** 4,338
- **Average order value:** £481 — suggesting wholesale/B2B behaviour

### Sales Trends
- **Peak month:** November 2011 — £1,161,817 (holiday season demand)
- **Strongest quarter:** Oct–Nov 2011 contributed over £2.2M combined
- Revenue grew consistently from Jan 2011 onward, with a sharp Q4 spike

### Customer Insights
- **Top customer** (ID 14646, Netherlands) spent £280,206 — 3× more than the next highest
- Top 10 customers account for a disproportionate share of total revenue
- A significant portion of customers are one-time buyers — retention is a key opportunity

### Product Performance
- **Best product:** PAPER CRAFT LITTLE BIRDIE — £168,470 revenue
- **2nd best:** REGENCY CAKESTAND 3 TIER — £142,593
- Top product generates 19% more revenue than the second — over-reliance on one SKU is a risk

### Geographic Insights
- **United Kingdom:** £7,308,392 — 82% of total revenue
- **Netherlands:** £285,446 | **EIRE:** £265,546 | **Germany:** £228,867
- Top 5 non-UK countries contribute only 13.8% — international growth is a major opportunity

---

## 🛠️ SQL Concepts Used
- Data cleaning & transformation (`WHERE`, `NOT LIKE`, `NULLIF`)
- Aggregate functions (`SUM`, `COUNT`, `AVG`, `ROUND`)
- Date functions (`DATE_FORMAT`, `STR_TO_DATE`)
- Common Table Expressions — CTEs (`WITH`)
- Window functions (`LAG`, `RANK`, `SUM OVER`)
- Views (`CREATE VIEW`)
- Stored Procedures (`CREATE PROCEDURE`)

---

## 💡 Business Recommendations
1. **Invest in Q4 early** — plan inventory and marketing campaigns by September
2. **Diversify internationally** — UK dependency is a business risk; Germany and France show strong potential
3. **Reduce SKU concentration** — top product driving disproportionate revenue needs a backup strategy
4. **Focus on customer retention** — converting one-time buyers into repeat customers would significantly increase LTV

---

## 📁 Dataset
[UCI Online Retail Dataset](https://archive.ics.uci.edu/ml/datasets/online+retail) — 
Real transaction data from a UK-based online retailer.
