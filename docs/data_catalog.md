## 📊 Gold Layer Data Catalogue (Analytics-Ready Schema)

### 🔍 Overview

The Gold layer represents the final, business-ready data model designed for analytics and reporting.
It follows a star schema design, consisting of:

Dimension tables: provide descriptive context (customers, products, sellers, geolocation)

Fact table: captures transactional data (orders) and links to dimensions via surrogate keys

### 🔑 Key Design Principles:

Surrogate keys (*_key) used as primary keys

Business keys retained for traceability

LEFT JOIN logic ensures no data loss

Aggregations and calculations prepared for reporting tools (e.g., Power BI)

### 🧱 1. gold.dim_customers
#### 🎯 Purpose
Stores customer-level attributes and acts as the central parent dimension for customer-related analysis.

| Column Name              | Data Type   | Description                                    |
| ------------------------ | ----------- | ---------------------------------------------- |
| customer_key             | INT         | Surrogate primary key                          |
| customer_unique_id       | VARCHAR(50) | Unique customer identifier (e.g., `a1b2c3xyz`) |
| customer_id              | VARCHAR(50) | Source system customer ID                      |
| customer_zip_code_prefix | VARCHAR(10) | ZIP code prefix (e.g., `1003`)                 |
| customer_city            | VARCHAR(50) | Customer city (e.g., `Auckland`)               |
| customer_state           | VARCHAR(10) | Customer state/region                          |


### 🧱 2. gold.dim_products
#### 🎯 Purpose
Provides product-level descriptive attributes for product analysis and reporting.

| Column Name                | Data Type    | Description                            |
| -------------------------- | ------------ | -------------------------------------- |
| product_key                | INT          | Surrogate primary key                  |
| product_id                 | VARCHAR(50)  | Unique product identifier              |
| product_category_name      | VARCHAR(100) | Product category (e.g., `electronics`) |
| product_name_length        | INT          | Length of product name                 |
| product_description_length | INT          | Length of product description          |
| product_photos_qty         | INT          | Number of product images               |
| product_weight_g           | INT          | Product weight in grams                |
| product_length_cm          | INT          | Product length in cm                   |
| product_height_cm          | INT          | Product height in cm                   |
| product_width_cm           | INT          | Product width in cm                    |


### 🧱 3. gold.dim_sellers
#### 🎯 Purpose
Stores seller-related attributes, enabling analysis of seller performance and distribution.

| Column Name            | Data Type   | Description                  |
| ---------------------- | ----------- | ---------------------------- |
| seller_key             | INT         | Surrogate primary key        |
| seller_id              | VARCHAR(50) | Unique seller identifier     |
| seller_zip_code_prefix | VARCHAR(10) | Seller ZIP prefix            |
| seller_city            | VARCHAR(50) | Seller city (e.g., `Sydney`) |
| seller_state           | VARCHAR(10) | Seller state code            |


### 🧱 4. gold.dim_geolocation
#### 🎯 Purpose
Provides geographical reference data for mapping and spatial analysis.

| Column Name                 | Data Type    | Description                             |
| --------------------------- | ------------ | --------------------------------------- |
| geolocation_key             | INT          | Surrogate primary key                   |
| geolocation_zip_code_prefix | VARCHAR(20)  | ZIP prefix used for joins               |
| geolocation_lat             | VARCHAR(50)  | Latitude coordinate (e.g., `-36.8485`)  |
| geolocation_lng             | VARCHAR(50)  | Longitude coordinate (e.g., `174.7633`) |
| geolocation_city            | VARCHAR(100) | City name                               |
| geolocation_state           | VARCHAR(10)  | State/region code                       |


### 📦 5. gold.fact_orders
#### 🎯 Purpose
Captures transactional order data, linking customers, products, sellers, and payments into a single analytical view.

#### 📏 Grain
One row per order (or order-item depending on joins applied)

| Column Name     | Data Type   | Description               |
| --------------- | ----------- | ------------------------- |
| order_key       | INT         | Surrogate primary key     |
| order_id        | VARCHAR(50) | Business order identifier |
| customer_key    | INT         | FK → dim_customers        |
| product_key     | INT         | FK → dim_products         |
| seller_key      | INT         | FK → dim_sellers          |
| geolocation_key | INT         | FK → dim_geolocation      |


### 📊 Order Details
| Column Name                   | Data Type   | Description                                 |
| ----------------------------- | ----------- | ------------------------------------------- |
| order_status                  | VARCHAR(20) | Order status (e.g., `delivered`, `shipped`) |
| order_purchase_timestamp      | DATETIME    | Date/time of purchase                       |
| order_approved_at             | DATETIME    | Approval timestamp                          |
| order_delivered_carrier_date  | DATETIME    | Carrier delivery date                       |
| order_delivered_customer_date | DATETIME    | Customer delivery date                      |
| order_estimated_delivery_date | DATETIME    | Estimated delivery                          |


### 💳 Payment Information
| Column Name          | Data Type     | Description                          |
| -------------------- | ------------- | ------------------------------------ |
| payment_type         | VARCHAR(30)   | Payment method (e.g., `credit_card`) |
| payment_installments | INT           | Number of installments               |
| payment_vaue         | DECIMAL(10,2) | Payment amount                       |


### ⭐ Review Information
| Column Name             | Data Type    | Description              |
| ----------------------- | ------------ | ------------------------ |
| review_id               | VARCHAR(50)  | Review identifier        |
| review_store            | INT          | Review score (e.g., `5`) |
| review_comment_title    | VARCHAR(225) | Review title             |
| review_comment_message  | VARCHAR(MAX) | Review text              |
| review_creation_date    | DATETIME     | Review creation date     |
| review_answer_timestamp | DATETIME     | Response timestamp       |


### 🧠 Additional Notes

Surrogate keys (*_key) are generated for performance and consistency

Business keys retained for traceability and debugging

Some columns may contain NULL values due to:

Missing joins

Incomplete source data

#### Data transformations applied:

TRIM, UPPER for cleaning

CAST for datatype alignment

#### Aggregations (if used in views):

COUNT(DISTINCT order_id) → total orders

COUNT(DISTINCT product_id) → product diversity










