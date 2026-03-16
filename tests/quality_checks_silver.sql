/*
===============================================================================
Quality Checks
===============================================================================
Script Purpose:
    This script performs various quality checks for data consistency, accuracy, 
    and standardization across the 'silver' layer. It includes checks for:
    - Null or duplicate primary keys.
    - Unwanted spaces in string fields.
    - Data standardization and consistency.
    - Invalid date ranges and orders.
    - Data consistency between related fields.

Usage Notes:
    - Run these checks after data loading Silver Layer.
    - Investigate and resolve any discrepancies found during the checks.
===============================================================================
*/


-- ====================================================================
-- Checking 'silver.crm_customers_details'
-- ====================================================================

-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results
SELECT 
    customer_id,
    COUNT(*) 
FROM silver.crm_customers_details
GROUP BY customer_id
HAVING COUNT(*) > 1 OR customer_id IS NULL;


-- Check for Unwanted Spaces
-- Expectation: No Results
SELECT 
   customer_city 
FROM silver.crm_customers_details
WHERE customer_city != TRIM(customer_city);


-- Data Standardization & Consistency
SELECT DISTINCT 
   customer_state 
FROM silver.crm_customers_details
ORDER BY customer_state;



-- ====================================================================
-- Checking 'silver.erp_products'
-- ====================================================================

-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results
SELECT 
    product_id,
    COUNT(*) 
FROM silver.erp_products
GROUP BY product_id
HAVING COUNT(*) > 1 OR product_id IS NULL;


-- Check for Unwanted Spaces
-- Expectation: No Results
SELECT 
    product_category_name
FROM silver.erp_products
WHERE product_category_name != TRIM(product_category_name);


-- Check for NULLs or Negative Values in Product Dimensions
-- Expectation: No Results
SELECT 
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm
FROM silver.erp_products
WHERE product_weight_g < 0 
   OR product_length_cm < 0
   OR product_height_cm < 0
   OR product_width_cm < 0;


-- Data Standardization & Consistency
SELECT DISTINCT 
    product_category_name
FROM silver.erp_products
ORDER BY product_category_name;



-- ====================================================================
-- Checking 'silver.erp_orders'
-- ====================================================================

-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results
SELECT 
    order_id,
    COUNT(*) 
FROM silver.erp_orders
GROUP BY order_id
HAVING COUNT(*) > 1 OR order_id IS NULL;


-- Check for Invalid Date Orders
-- Expectation: No Results
SELECT 
    *
FROM silver.erp_orders
WHERE order_approved_at < order_purchase_timestamp
   OR order_delivered_customer_date < order_approved_at;



-- ====================================================================
-- Checking 'silver.erp_order_items'
-- ====================================================================

-- Check for NULLs in Critical Fields
-- Expectation: No Results
SELECT 
    *
FROM silver.erp_order_items
WHERE order_id IS NULL
   OR product_id IS NULL
   OR seller_id IS NULL;


-- Check for Invalid Prices or Freight Values
-- Expectation: No Results
SELECT 
    price,
    freight_value
FROM silver.erp_order_items
WHERE price <= 0
   OR freight_value < 0
   OR price IS NULL
   OR freight_value IS NULL;



-- ====================================================================
-- Checking 'silver.erp_order_payments'
-- ====================================================================

-- Check for NULLs or Negative Payment Values
-- Expectation: No Results
SELECT 
    payment_value,
    payment_installments
FROM silver.erp_order_payments
WHERE payment_value <= 0
   OR payment_installments <= 0
   OR payment_value IS NULL;



-- ====================================================================
-- Checking 'silver.crm_order_reviews'
-- ====================================================================

-- Check for Invalid Review Scores
-- Expectation: Scores between 1 and 5
SELECT DISTINCT 
    review_score
FROM silver.crm_order_reviews
WHERE review_score < 1
   OR review_score > 5
   OR review_score IS NULL;



-- ====================================================================
-- Checking 'silver.erp_sellers'
-- ====================================================================

-- Check for NULLs or Duplicates in Primary Key
-- Expectation: No Results
SELECT 
    seller_id,
    COUNT(*) 
FROM silver.erp_sellers
GROUP BY seller_id
HAVING COUNT(*) > 1 OR seller_id IS NULL;


-- Data Standardization & Consistency
SELECT DISTINCT 
    seller_state
FROM silver.erp_sellers
ORDER BY seller_state;



-- ====================================================================
-- Checking 'silver.erp_product_category_translation'
-- ====================================================================

-- Check for Unwanted Spaces
-- Expectation: No Results
SELECT 
    *
FROM silver.erp_product_category_translation
WHERE product_category_name != TRIM(product_category_name)
   OR product_category_name_english != TRIM(product_category_name_english);


-- Data Standardization & Consistency
SELECT DISTINCT 
    product_category_name_english
FROM silver.erp_product_category_translation
ORDER BY product_category_name_english;



-- ====================================================================
-- Checking Business Rule Consistency
-- ====================================================================

-- Check Data Consistency: Payment Value vs Order Item Value
-- Expectation: Few or No Results

SELECT
    oi.order_id,
    SUM(oi.price + oi.freight_value) AS order_total,
    SUM(op.payment_value) AS payment_total
FROM silver.erp_order_items oi
JOIN silver.erp_order_payments op
    ON oi.order_id = op.order_id
GROUP BY oi.order_id
HAVING SUM(oi.price + oi.freight_value) != SUM(op.payment_value);
