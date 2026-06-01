-- ============================================
-- E-Commerce Sales Analysis
-- views.sql — Views & stored procedure
-- ============================================

USE ecommerce_db;

-- View 1: Monthly revenue
CREATE VIEW vw_monthly_revenue AS
SELECT
    DATE_FORMAT(InvoiceDate, '%Y-%m')       AS month,
    COUNT(DISTINCT InvoiceNo)               AS total_orders,
    ROUND(SUM(Quantity * UnitPrice), 2)     AS revenue
FROM retail_clean
GROUP BY month
ORDER BY month;

-- View 2: Top customers
CREATE VIEW vw_top_customers AS
SELECT
    CustomerID,
    Country,
    COUNT(DISTINCT InvoiceNo)               AS total_orders,
    ROUND(SUM(Quantity * UnitPrice), 2)     AS total_spent
FROM retail_clean
GROUP BY CustomerID, Country
ORDER BY total_spent DESC;

-- View 3: Product performance
CREATE VIEW vw_product_performance AS
SELECT
    StockCode,
    Description,
    SUM(Quantity)                           AS units_sold,
    ROUND(SUM(Quantity * UnitPrice), 2)     AS revenue
FROM retail_clean
GROUP BY StockCode, Description
ORDER BY revenue DESC;

-- Stored procedure: get top N customers
DELIMITER $$
CREATE PROCEDURE GetTopCustomers(IN n INT)
BEGIN
    SELECT
        CustomerID,
        Country,
        COUNT(DISTINCT InvoiceNo)           AS total_orders,
        ROUND(SUM(Quantity * UnitPrice), 2) AS total_spent
    FROM retail_clean
    GROUP BY CustomerID, Country
    ORDER BY total_spent DESC
    LIMIT n;
END $$
DELIMITER ;