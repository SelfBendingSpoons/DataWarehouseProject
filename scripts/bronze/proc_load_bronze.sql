/*
================================================================================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
================================================================================================================================
Script Purpose:
  Creates a stored procedure to create the data for the bronze schema from external .csv files.
This procedure:
  -  Truncates existing data in tables (Be ware, this will lose any data stored)
  -  Imports data from the selected .csv files

IMPORTANT:
You'll need to paste in the file path for the associated .csv file locations in each of the FROM commands for this to work properly.

Usage:
EXEC bronze.load_bronze

*/
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME
	BEGIN TRY 
		SET @batch_start_time = GETDATE()
		PRINT '================================================';
		PRINT '>> Loading Bronze Layer';
		PRINT '================================================';
		
		PRINT '>> Loading CRM Tables';
		PRINT '================================================';
		
		SET @start_time = GETDATE();
		PRINT '>> Truncating: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;
		
		PRINT '>> Inserting into: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM "FILE PATH"
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		
		SET @start_time = GETDATE();
		PRINT '>> Truncating: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;
		
		PRINT '>> Inserting into: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM "FILE PATH"
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		
		SET @start_time = GETDATE();
		PRINT '>> Truncating: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details;
		
		PRINT '>> Inserting into: bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM "FILE PATH"
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		
		PRINT '>> Loading ERP Tables';
		PRINT '================================================';
		
		SET @start_time = GETDATE();
		PRINT '>> Truncating: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;
		
		PRINT '>> Inserting into: bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM "FILE PATH"
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		
		SET @start_time = GETDATE();
		PRINT '>> Truncating: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;
		
		PRINT '>> Inserting into: bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM "FILE PATH"
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		
		SET @start_time = GETDATE();
		PRINT '>> Truncating: bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;
		
		PRINT '>> Inserting into: bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM "FILE PATH"
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
		
		SET @batch_end_time = GETDATE();
		PRINT '================================================';
		PRINT '>> Bronze layer loaded.';
		PRINT '>> Total load time: ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
	END TRY
	
	BEGIN CATCH
		PRINT '================================================';
		PRINT 'Error loading bronze layer';
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Number' + CAST(ERROR_NUMBER() AS NVARCHAR);
	END CATCH
END
