/*
📊 Gold Layer – DDL Scripts (Views)

🧾 Purpose

This script defines the Gold layer views, representing the final analytics-ready data model structured as a star schema.
It transforms curated Silver data into business-friendly dimensions and fact views for reporting and insights.

⚙️ Usage

Execute after Silver layer tables are fully loaded and validated

Creates or updates (CREATE OR ALTER VIEW) all Gold views

Designed for consumption in BI tools (e.g., Power BI, dashboards)

Ensures consistent business logic and aggregation rules

🧱 Scope

Dimension Views: dim_customers, dim_products, dim_sellers, dim_geolocation

Fact View: fact_orders

Implements surrogate keys, joins, and aggregations

🔑 Notes

Follows Star Schema design principles

Uses LEFT JOINs to preserve data completeness

Business keys retained alongside surrogate keys for traceability
*/



CREATE OR ALTER VIEW gold.dim_sellers AS
WITH parent_sellers AS (
    SELECT
        ROW_NUMBER() OVER (ORDER BY seller_id) AS seller_key,
        seller_id,
        seller_zip_code_prefix,
        seller_city,
        seller_state
    FROM silver.erp_sellers
)
SELECT *
FROM parent_sellers;

CREATE OR ALTER VIEW gold.dim_products AS
WITH parent_products AS (
    SELECT
        ROW_NUMBER() OVER (ORDER BY product_id) AS product_key,
        product_id,
        product_category_name,
        product_name_length,
        product_description_length,
        product_photos_qty,
        product_weight_g,
        product_length_cm,
        product_height_cm,
        product_width_cm
    FROM silver.erp_products
)
SELECT *
FROM parent_products;

CREATE OR ALTER VIEW gold.dim_geolocation AS
WITH parent_geolocation AS (
    SELECT
        ROW_NUMBER() OVER (ORDER BY geolocation_zip_code_prefix) AS geolocation_key,
        geolocation_zip_code_prefix,
        geolocation_lat,
        geolocation_lng,
        geolocation_city,
        geolocation_state
    FROM silver.crm_geolocation
)
SELECT *
FROM parent_geolocation;

CREATE OR ALTER VIEW gold.fact_orders AS
SELECT
    ROW_NUMBER() OVER (ORDER BY o.order_id) AS order_key, -- surrogate key for fact table
    o.order_id,
    
    c.customer_key,
    p.product_key,
    s.seller_key,
    g.geolocation_key,

    o.order_status,
    o.order_purchase_timestamp,
    o.order_approved_at,
    o.order_delivered_carrier_date,
    o.order_delivered_customer_date,
    o.order_estimated_delivery_date,
    
    pay.payment_type,
    pay.payment_installments,
    pay.payment_value,
    
    r.review_id,
    r.review_score,
    r.review_comment_title,
    r.review_comment_message,
    r.review_creation_date,
    r.review_answer_timestamp

FROM silver.erp_orders o

-- Customers
LEFT JOIN gold.dim_customers c
    ON o.customer_id = c.customer_unique_id

-- Order Items → Products & Sellers
LEFT JOIN silver.erp_order_items oi
    ON oi.order_id = o.order_id
LEFT JOIN gold.dim_products p
    ON oi.product_id = p.product_id
LEFT JOIN gold.dim_sellers s
    ON oi.seller_id = s.seller_id

-- Payments
LEFT JOIN silver.erp_order_payments pay
    ON pay.order_id = o.order_id

-- Reviews
LEFT JOIN silver.crm_order_reviews r
    ON r.order_id = o.order_id

-- Geolocation (customer zip)
LEFT JOIN gold.dim_geolocation g
    ON g.geolocation_zip_code_prefix = c.customer_zip_code_prefix;
