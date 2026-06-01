-- ============================================
-- E-Commerce Sales Analysis
-- analysis.sql — All analysis queries
-- ============================================

USE ecommerce_db;

-- 1. Overall summary
SELECT
    COUNT(DISTINCT InvoiceNo)               AS total_orders,
    COUNT(DISTINCT CustomerID)              AS total_customers,
    ROUND(SUM(Quantity * UnitPrice), 2)     AS total_revenue
FROM retail_clean;

-- 2. Monthly revenue trend
SELECT
    DATE_FORMAT(InvoiceDate, '%Y-%m')       AS month,
    COUNT(DISTINCT InvoiceNo)               AS orders,
    ROUND(SUM(Quantity * UnitPrice), 2)     AS revenue
FROM retail_clean
GROUP BY month
ORDER BY month;

-- 3. Top 10 customers by spend
SELECT
    CustomerID,
    Country,
    COUNT(DISTINCT InvoiceNo)               AS total_orders,
    ROUND(SUM(Quantity * UnitPrice), 2)     AS total_spent
FROM retail_clean
GROUP BY CustomerID, Country
ORDER BY total_spent DESC
LIMIT 10;

-- 4. Top 10 best-selling products
SELECT
    StockCode,
    Description,
    SUM(Quantity)                           AS units_sold,
    ROUND(SUM(Quantity * UnitPrice), 2)     AS revenue
FROM retail_clean
GROUP BY StockCode, Description
ORDER BY revenue DESC
LIMIT 10;

-- 5. Revenue by country
SELECT
    Country,
    COUNT(DISTINCT CustomerID)              AS customers,
    ROUND(SUM(Quantity * UnitPrice), 2)     AS revenue
FROM retail_clean
GROUP BY Country
ORDER BY revenue DESC;

-- 6. Month-over-month growth
WITH monthly AS (
    SELECT
        DATE_FORMAT(InvoiceDate, '%Y-%m')       AS month,
        ROUND(SUM(Quantity * UnitPrice), 2)     AS revenue
    FROM retail_clean
    GROUP BY month
)
SELECT
    month,
    revenue,
    LAG(revenue) OVER (ORDER BY month)          AS prev_month_revenue,
    ROUND(
        (revenue - LAG(revenue) OVER (ORDER BY month))
        / LAG(revenue) OVER (ORDER BY month) * 100, 1
    )                                            AS mom_growth_pct
FROM monthly
ORDER BY month;

-- 7. Product revenue ranking
SELECT
    StockCode,
    Description,
    ROUND(SUM(Quantity * UnitPrice), 2)          AS revenue,
    RANK() OVER (ORDER BY SUM(Quantity * UnitPrice) DESC) AS revenue_rank
FROM retail_clean
GROUP BY StockCode, Description
LIMIT 20;

-- 8. Running total of revenue
WITH monthly AS (
    SELECT
        DATE_FORMAT(InvoiceDate, '%Y-%m')        AS month,
        ROUND(SUM(Quantity * UnitPrice), 2)      AS revenue
    FROM retail_clean
    GROUP BY month
)
SELECT
    month,
    revenue,
    ROUND(SUM(revenue) OVER (ORDER BY month), 2) AS running_total
FROM monthly;

-- 9. Customer purchase frequency segments
WITH customer_orders AS (
    SELECT
        CustomerID,
        COUNT(DISTINCT InvoiceNo)                AS order_count
    FROM retail_clean
    GROUP BY CustomerID
)
SELECT
    CASE
        WHEN order_count = 1  THEN '1 - One-time buyer'
        WHEN order_count <= 5 THEN '2 - Occasional buyer'
        WHEN order_count <= 10 THEN '3 - Regular buyer'
        ELSE '4 - Loyal buyer'
    END                                          AS segment,
    COUNT(CustomerID)                            AS customers
FROM customer_orders
GROUP BY segment
ORDER BY segment;

-- 10. Top country per month
WITH country_monthly AS (
    SELECT
        DATE_FORMAT(InvoiceDate, '%Y-%m')        AS month,
        Country,
        ROUND(SUM(Quantity * UnitPrice), 2)      AS revenue,
        RANK() OVER (
            PARTITION BY DATE_FORMAT(InvoiceDate, '%Y-%m')
            ORDER BY SUM(Quantity * UnitPrice) DESC
        )                                         AS rnk
    FROM retail_clean
    GROUP BY month, Country
)
SELECT month, Country, revenue
FROM country_monthly
WHERE rnk = 1
ORDER BY month;