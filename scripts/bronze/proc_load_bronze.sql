/*
=======================================================================================
Stored Prcedure: Load Bronze Layer (Source -> Bronze)
=======================================================================================
Script Purpose:
  The following script load data from csv source file on to 'bronze schema'.

It performas the following functions;
- Truncate the brone tables before loading data.
- Use the 'BULK INSERT' command to load data from csv Files to bronze tables. 

parameters:
  None.
  This stored procedure does not accept any parameters or returnany values. 

Usage Example:
  EXEC bronze.load_broze;
==========================================================================================
*/

-- =============================================
-- Create or Alter the Bronze Load Procedure
-- =============================================
CREATE OR ALTER PROCEDURE bronze.load_bronze AS 
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT '=================================================================================';
		PRINT 'Loading Bronze Layer';
		PRINT '=================================================================================';

		PRINT '---------------------------------------------------------------------------------';
		PRINT 'Loading CRM Layer';
		PRINT '---------------------------------------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_customers_details';
		TRUNCATE TABLE bronze.crm_customers_details

		PRINT '>> Inserting Data Into: bronze.crm_customers_details';
		BULK INSERT bronze.crm_customers_details
		FROM 'C:\Users\Hp\OneDrive\Desktop\Data_Warehouse_Projects_04\olist_customers_dataset.csv'
		WITH (
				FORMAT = 'csv',
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				ROWTERMINATOR = '\n',
				TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -----------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_geolocation';
		TRUNCATE TABLE bronze.crm_geolocation

		PRINT '>> Inserting Data Into: bronze.crm_geolocation';
		BULK INSERT bronze.crm_geolocation
		FROM 'C:\Users\Hp\OneDrive\Desktop\Data_Warehouse_Projects_04\olist_geolocation_dataset.csv'
		WITH (
				FORMAT = 'csv',
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				ROWTERMINATOR = '\n',
				TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -----------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_order_reviews';
		TRUNCATE TABLE bronze.crm_order_reviews

		PRINT '>> Inserting Data Into: bronze.crm_order_reviews';
		BULK INSERT bronze.crm_order_reviews
		FROM 'C:\Users\Hp\OneDrive\Desktop\Data_Warehouse_Projects_04\olist_order_reviews_dataset.csv'
		WITH (
				FORMAT = 'csv',
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				ROWTERMINATOR = '\n',
				TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -----------------------------------------';

		PRINT '---------------------------------------------------------------------------------';
		PRINT 'Loading ERP Layer';
		PRINT '---------------------------------------------------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_order_items';
		TRUNCATE TABLE bronze.erp_order_items

		PRINT '>> Inserting Data Into: bronze.erp_order_items';
		BULK INSERT bronze.erp_order_items
		FROM 'C:\Users\Hp\OneDrive\Desktop\Data_Warehouse_Projects_04\olist_order_items_dataset.csv'
		WITH (
				FORMAT = 'csv',
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				ROWTERMINATOR = '\n',
				TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -----------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_order_payments';
		TRUNCATE TABLE bronze.erp_order_payments

		PRINT '>> Inserting Data Into: bronze.erp_order_payments';
		BULK INSERT bronze.erp_order_payments
		FROM 'C:\Users\Hp\OneDrive\Desktop\Data_Warehouse_Projects_04\olist_order_payments_dataset.csv'
		WITH (
				FORMAT = 'csv',
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				ROWTERMINATOR = '\n',
				TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -----------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_orders';
		TRUNCATE TABLE bronze.erp_orders

		PRINT '>> Inserting Data Into: bronze.erp_orders';
		BULK INSERT bronze.erp_orders
		FROM 'C:\Users\Hp\OneDrive\Desktop\Data_Warehouse_Projects_04\olist_orders_dataset.csv'
		WITH (
				FORMAT = 'csv',
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				ROWTERMINATOR = '\n',
				TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -----------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_products';
		TRUNCATE TABLE bronze.erp_products

		PRINT '>> Inserting Data Into: bronze.erp_products';
		BULK INSERT bronze.erp_products
		FROM 'C:\Users\Hp\OneDrive\Desktop\Data_Warehouse_Projects_04\olist_products_dataset.csv'
		WITH (
				FORMAT = 'csv',
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				ROWTERMINATOR = '\n',
				TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -----------------------------------------';

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_sellers';
		TRUNCATE TABLE bronze.erp_sellers

		PRINT '>> Inserting Data Into: bronze.erp_sellers';
		BULK INSERT bronze.erp_sellers
		FROM 'C:\Users\Hp\OneDrive\Desktop\Data_Warehouse_Projects_04\olist_sellers_dataset.csv'
		WITH (
				FORMAT = 'csv',
				FIRSTROW = 2,
				FIELDTERMINATOR = ',',
				ROWTERMINATOR = '\n',
				TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration:' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		PRINT '>> -----------------------------------------';

		SET @batch_end_time = GETDATE();
		PRINT '================================================='
		PRINT 'Loading Bronze Layer is Completed';
		PRINT '  - Total Load Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
		PRINT '================================================='
	END TRY
	BEGIN CATCH
		PRINT '==================================================';
		PRINT 'ERROR OCCURED DURING LOADING BROZE LAYER';
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '==================================================';
	END CATCH
END
GO

-- =============================================
-- Execute the procedure in a new batch
-- =============================================
EXEC bronze.load_bronze
GO
