-- ============================================
-- E-Commerce Sales Analysis
-- schema.sql — Database setup & data cleaning
-- ============================================

CREATE DATABASE IF NOT EXISTS ecommerce_db;
USE ecommerce_db;

-- Raw data table
CREATE TABLE online_retail (
    InvoiceNo       VARCHAR(20),
    StockCode       VARCHAR(20),
    Description     VARCHAR(255),
    Quantity        INT,
    InvoiceDate     VARCHAR(30),
    UnitPrice       DECIMAL(10,2),
    CustomerID      VARCHAR(20),
    Country         VARCHAR(100)
);

-- Add proper datetime column
ALTER TABLE online_retail ADD COLUMN InvoiceDatetime DATETIME;

SET SQL_SAFE_UPDATES = 0;
UPDATE online_retail
SET InvoiceDatetime = STR_TO_DATE(InvoiceDate, '%m/%d/%Y %H:%i');
SET SQL_SAFE_UPDATES = 1;

-- Clean analysis table
CREATE TABLE retail_clean AS
SELECT
    InvoiceNo,
    StockCode,
    Description,
    Quantity,
    InvoiceDatetime  AS InvoiceDate,
    UnitPrice,
    CustomerID,
    Country
FROM online_retail
WHERE CustomerID IS NOT NULL
  AND Quantity > 0
  AND UnitPrice > 0
  AND InvoiceNo NOT LIKE 'C%';