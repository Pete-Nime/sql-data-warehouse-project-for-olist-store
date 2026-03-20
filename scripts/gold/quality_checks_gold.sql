/* ✅ Gold Layer – Data Quality Checks
  
🧾 Purpose

This script validates the integrity, consistency, and reliability of the Gold layer (dimensions and fact tables).
It ensures that the star schema is correctly structured, with no duplicate records, broken relationships, or invalid key mappings.

⚙️ Usage

Run after Gold tables/views are created and loaded

Execute periodically to validate data health

Use results to identify:

Missing joins

Duplicate records

Data inconsistencies

🔑 Notes

All checks follow data warehouse best practices

Focus on:

  - rimary Key uniqueness

  - Foreign Key integrity

  - Fact-to-dimension consistency

Expected result for most checks: 0 rows returned (no issues)
*/

🧱 Dimension Table Checks
🔹 1. dim_customers – Duplicate Check
SELECT customer_unique_id, COUNT(*) 
FROM gold.dim_customers
GROUP BY customer_unique_id
HAVING COUNT(*) > 1;

🔹 2. dim_products – Duplicate Check
SELECT product_id, COUNT(*) 
FROM gold.dim_products
GROUP BY product_id
HAVING COUNT(*) > 1;

🔹 3. dim_sellers – Duplicate Check
SELECT seller_id, COUNT(*) 
FROM gold.dim_sellers
GROUP BY seller_id
HAVING COUNT(*) > 1;

🔹 4. dim_geolocation – Duplicate Check
SELECT geolocation_zip_code_prefix, COUNT(*) 
FROM gold.dim_geolocation
GROUP BY geolocation_zip_code_prefix
HAVING COUNT(*) > 1;

🔹 5. NULL Key Check (All Dimensions)
SELECT *
FROM gold.dim_customers
WHERE customer_key IS NULL;

(Repeat for other dimension tables if needed)

📦 Fact Table Checks
🔹 6. fact_orders – Duplicate Order Check
SELECT order_id, COUNT(*) 
FROM gold.fact_orders
GROUP BY order_id
HAVING COUNT(*) > 1;

🔹 7. Foreign Key Integrity – Customers
SELECT f.customer_key
FROM gold.fact_orders f
LEFT JOIN gold.dim_customers d
    ON f.customer_key = d.customer_key
WHERE d.customer_key IS NULL;

🔹 8. Foreign Key Integrity – Products
SELECT f.product_key
FROM gold.fact_orders f
LEFT JOIN gold.dim_products d
    ON f.product_key = d.product_key
WHERE f.product_key IS NOT NULL
AND d.product_key IS NULL;

🔹 9. Foreign Key Integrity – Sellers
SELECT f.seller_key
FROM gold.fact_orders f
LEFT JOIN gold.dim_sellers d
    ON f.seller_key = d.seller_key
WHERE f.seller_key IS NOT NULL
AND d.seller_key IS NULL;

🔹 10. Foreign Key Integrity – Geolocation
SELECT f.geolocation_key
FROM gold.fact_orders f
LEFT JOIN gold.dim_geolocation d
    ON f.geolocation_key = d.geolocation_key
WHERE f.geolocation_key IS NOT NULL
AND d.geolocation_key IS NULL;

🔹 11. NULL Key Check (Critical Fields)
SELECT *
FROM gold.fact_orders
WHERE customer_key IS NULL;
🔗 Relationship Checks (Parent → Child)
  
🔹 12. Customers Without Orders
SELECT d.customer_key
FROM gold.dim_customers d
LEFT JOIN gold.fact_orders f
    ON d.customer_key = f.customer_key
WHERE f.customer_key IS NULL;

🔹 13. Orders Without Related Data (Optional Insight)
SELECT *
FROM gold.fact_orders
WHERE product_key IS NULL
   OR seller_key IS NULL;

🏆 Expected Results
Check Type	        Expected Result
Duplicate Checks	      0 rows
FK Integrity Checks   	0 rows
NULL Key Checks	        0 rows (for required fields)
Relationship Checks	May  return rows (valid business case)
  
 ✅ Summary

These quality checks ensure:

✔️ No duplicate dimension records

✔️ Valid relationships between fact and dimensions

✔️ Clean and reliable analytical dataset

✔️ Readiness for BI tools and reporting
