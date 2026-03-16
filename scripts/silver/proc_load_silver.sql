/*
====================================================================================
Stored Prodedure: Load silver Layer (Bronze -> silver)
====================================================================================
Script Objectives:
   ETL (Extract, Transform, Load) from 'Bronze schema'.
Which involves:
- Truncates Silver tables.
- Inserts transform and cleansed data from Bronze into Silver tables.

Parameters:
    None.
    This stored procedure does not accept any parameters or return any values

Usage Example:
    EXEC Silver.load_silver;
=====================================================================================
*/

CREATE OR ALTER PROCEDURE silver.load_silver AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '=================================================================================';
		PRINT 'Loading Silver Layer';
		PRINT '=================================================================================';

		PRINT '---------------------------------------------------------------------------------';
		PRINT 'Loading CRM Layer';
		PRINT '---------------------------------------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: silver.crm_customers_details';
		TRUNCATE TABLE silver.crm_customers_details;
		PRINT '>> Insert Data Into: silver.crm_customers_details';
		INSERT INTO silver.crm_customers_details 
		(
			customer_id,
			customer_unique_id,
			customer_zip_code_prefix,
			customer_city,
			customer_state)

		SELECT 
			customer_id,
			customer_unique_id,
			customer_zip_code_prefix,
			TRIM(customer_city),
			UPPER(TRIM(customer_state))
		FROM 
			bronze.crm_customers_details;
		SET @end_time = GETDATE();
		PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -----------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: silver.crm_geolocation';
		TRUNCATE TABLE bronze.crm_geolocation

		PRINT '>> Truncating Table: silver.crm_geolocation';
		TRUNCATE TABLE silver.crm_geolocation;
		PRINT '>> Insert Data Into: silver.crm_geolocation';
		INSERT INTO silver.crm_geolocation(

			geolocation_zip_code_prefix,
			geolocation_lat,
			geolocation_lng,
			geolocation_city,
			geolocation_state
		)
		SELECT

			geolocation_zip_code_prefix,
			geolocation_lat,
			geolocation_lng,
			geolocation_city,
			TRIM(geolocation_state)
		FROM bronze.crm_geolocation;
		SET @end_time = GETDATE();
		PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -----------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: silver.crm_order_reviews';
		TRUNCATE TABLE bronze.crm_order_reviews

		PRINT '>> Truncating Table: silver.crm_order_reviews';
		TRUNCATE TABLE silver.crm_order_reviews;
		PRINT '>> Insert Data Into: silver.crm_order_reviews';
		INSERT INTO silver.crm_order_reviews(

			review_id,
			order_id,
			review_score,
			review_comment_title,
			review_comment_message,
			review_creation_date,
			review_answer_timestamp
		)
		SELECT

			review_id,
			order_id,
			review_score,
			TRIM(review_comment_title),
			TRIM(review_comment_message),
			review_creation_date,
			review_answer_timestamp
		FROM bronze.crm_order_reviews;
		SET @end_time = GETDATE();
		PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -----------------------------------------';

		PRINT '---------------------------------------------------------------------------------';
		PRINT 'Loading ERP Layer';
		PRINT '---------------------------------------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: silver.erp_order_items';
		TRUNCATE TABLE bronze.erp_order_items

		PRINT '>> Truncating Table: silver.erp_order_items';
		TRUNCATE TABLE silver.erp_order_items;
		PRINT '>> Insert Data Into: silver.erp_order_items';
		INSERT INTO silver.erp_order_items 
		(
			order_id,
			order_item_id,
			product_id,
			seller_id,
			shipping_limit_date,
			price,
			freight_value
		)
		SELECT 
			order_id,
			order_item_id,
			product_id,
			seller_id,
			shipping_limit_date,
			price,
			freight_value
		FROM 
			bronze.erp_order_items;
		SET @end_time = GETDATE();
		PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -----------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: silver.erp_order_payments';
		TRUNCATE TABLE bronze.erp_order_payments

		PRINT '>> Truncating Table: silver.erp_order_payments';
		TRUNCATE TABLE silver.erp_order_payments;
		PRINT '>> Insert Data Into: silver.erp_order_payments';
		INSERT INTO silver.erp_order_payments(

			order_id,
			payment_sequential,
			payment_type,
			payment_installments,
			payment_value
		)
		SELECT

			order_id,
			payment_sequential,
			TRIM(payment_type),
			payment_installments,
			payment_value
		FROM bronze.erp_order_payments;
		SET @end_time = GETDATE();
		PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -----------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: silver.erp_orders';
		TRUNCATE TABLE bronze.erp_orders

		PRINT '>> Truncating Table: silver.erp_orders';
		TRUNCATE TABLE silver.erp_orders;
		PRINT '>> Insert Data Into: silver.erp_orders';
		INSERT INTO silver.erp_orders(

			order_id,
			customer_id,
			order_status,
			order_purchase_timestamp,
			order_approved_at,
			order_delivered_carrier_date,
			order_delivered_customer_date,
			order_estimated_delivery_date
		)
		SELECT

	
			order_id,
			customer_id,
			TRIM(order_status),
			order_purchase_timestamp,
			order_approved_at,
			order_delivered_carrier_date,
			order_delivered_customer_date,
			order_estimated_delivery_date
		FROM bronze.erp_orders;
		SET @end_time = GETDATE();
		PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -----------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: silver.erp_product_category_translation';
		TRUNCATE TABLE bronze.erp_products

		PRINT '>> Truncating Table: silver.erp_product_category_translation';
		TRUNCATE TABLE silver.erp_product_category_translation;
		PRINT '>> Insert Data Into: silver.erp_product_category_translation';
		INSERT INTO silver.erp_product_category_translation(

			product_category_name,
			product_category_name_english
		)
		SELECT

	
			TRIM(product_category_name),
			TRIM(product_category_name_english)
		FROM bronze.erp_product_category_translation;
		SET @end_time = GETDATE();
		PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -----------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: silver.erp_products';
		TRUNCATE TABLE silver.erp_products

		PRINT '>> Truncating Table: silver.erp_products';
		TRUNCATE TABLE silver.erp_products;
		PRINT '>> Insert Data Into: silver.erp_products';
		INSERT INTO silver.erp_products(

			product_id,
			product_category_name,
			product_name_length,
			product_description_length,
			product_photos_qty,
			product_weight_g,
			product_length_cm,
			product_height_cm,
			product_width_cm

		)
		SELECT

			product_id,
			TRIM(product_category_name),
			product_name_length,
			product_description_length,
			product_photos_qty,
			product_weight_g,
			product_length_cm,
			product_height_cm,
			product_width_cm
		FROM bronze.erp_products;
		SET @end_time = GETDATE();
		PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -----------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: silver.erp_products';
		TRUNCATE TABLE silver.erp_products

		PRINT '>> Truncating Table: silver.erp_sellers';
		TRUNCATE TABLE silver.erp_sellers;
		PRINT '>> Insert Data Into: silver.erp_sellers';
		INSERT INTO silver.erp_sellers(

			seller_id,
			seller_zip_code_prefix,
			seller_city,
			seller_state

		)
		SELECT

			seller_id,
			seller_zip_code_prefix,
			TRIM(seller_city),
			UPPER(TRIM(seller_state))
		FROM bronze.erp_sellers;
		SET @end_time = GETDATE();
		PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -----------------------------------------';

		SET @batch_end_time = GETDATE();
		PRINT '================================================='
		PRINT 'Loading Silver Layer is Completed';
		PRINT '  - Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
		PRINT '================================================='
	END TRY
	BEGIN CATCH
		PRINT '==================================================';
		PRINT 'ERROR OCCURED DURING LOADING Silver LAYER';
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '==================================================';
	END CATCH
END
GO
EXEC silver.load_silver

