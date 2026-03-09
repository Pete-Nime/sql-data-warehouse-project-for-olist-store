/* 
===============================================================================
DDL Script: Create Bronze Tables
===============================================================================
Script Purpose:
  The following script created bronze table by dropping bronze table if exist and recreated a new one.
  The script define the all sctructure of the bronze table.
  ===============================================================================
*/

IF OBJECT_ID ('bronze.crm_customers_details' , 'U') IS NOT NULL
	DROP TABLE bronze.crm_customers_details;
CREATE TABLE bronze.crm_customers_details (
    customer_id VARCHAR(50),
    customer_unique_id VARCHAR(50),
    customer_zip_code_prefix INT,
    customer_city VARCHAR(100),
    customer_state VARCHAR(10)
);

GO

IF OBJECT_ID ('bronze.crm_geolocation' , 'U') IS NOT NULL
	DROP TABLE bronze.crm_geolocation;
CREATE TABLE bronze.crm_geolocation (
    geolocation_zip_code_prefix varchar(20),
    geolocation_lat VARCHAR(50),
    geolocation_lng VARCHAR(50),
    geolocation_city VARCHAR(100),
    geolocation_state VARCHAR(10)
);

GO

IF OBJECT_ID ('bronze.crm_order_reviews' , 'U') IS NOT NULL
	DROP TABLE bronze.crm_order_reviews;
CREATE TABLE bronze.crm_order_reviews (
    review_id VARCHAR(50),
    order_id VARCHAR(50),
    review_score INT,
    review_comment_title VARCHAR(255),
    review_comment_message VARCHAR(MAX),
    review_creation_date DATETIME,
    review_answer_timestamp DATETIME
);

GO

IF OBJECT_ID ('bronze.erp_orders' , 'U') IS NOT NULL
	DROP TABLE bronze.erp_orders;
CREATE TABLE bronze.erp_orders (
    order_id VARCHAR(50),
    customer_id VARCHAR(50),
    order_status VARCHAR(20),
    order_purchase_timestamp DATETIME,
    order_approved_at DATETIME,
    order_delivered_carrier_date DATETIME,
    order_delivered_customer_date DATETIME,
    order_estimated_delivery_date DATETIME
);

GO

IF OBJECT_ID ('bronze.erp_order_items' , 'U') IS NOT NULL
	DROP TABLE bronze.erp_order_items;
CREATE TABLE bronze.erp_order_items (
    order_id VARCHAR(50),
    order_item_id INT,
    product_id VARCHAR(50),
    seller_id VARCHAR(50),
    shipping_limit_date DATETIME,
    price DECIMAL(10,2),
    freight_value DECIMAL(10,2)
);

GO

IF OBJECT_ID ('bronze.erp_order_payments' , 'U') IS NOT NULL
	DROP TABLE bronze.erp_order_payments;
CREATE TABLE bronze.erp_order_payments (
    order_id VARCHAR(50),
    payment_sequential INT,
    payment_type VARCHAR(30),
    payment_installments INT,
    payment_value DECIMAL(10,2)
);

GO

IF OBJECT_ID ('bronze.erp_products' , 'U') IS NOT NULL
	DROP TABLE bronze.erp_products;
CREATE TABLE bronze.erp_products (
    product_id VARCHAR(50),
    product_category_name VARCHAR(100),
    product_name_length INT,
    product_description_length INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT
);

GO

IF OBJECT_ID ('bronze.erp_sellers' , 'U') IS NOT NULL
	DROP TABLE bronze.erp_sellers;
CREATE TABLE bronze.erp_sellers (
    seller_id VARCHAR(50),
    seller_zip_code_prefix INT,
    seller_city VARCHAR(100),
    seller_state VARCHAR(10)
);

GO

IF OBJECT_ID ('bronze.erp_product_category_translation' , 'U') IS NOT NULL
	DROP TABLE bronze.erp_product_category_translation;
CREATE TABLE bronze.erp_product_category_translation (
    product_category_name VARCHAR(100),
    product_category_name_english VARCHAR(100)
);

