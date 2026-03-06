/*

=======================================================================
Create Database & Schemas
=======================================================================
Script Structure:
  The script runs through the DataseBase to see if there's 'Olist_Table'. Drop the DB if exist and if not, it created a new db 'Olist_Store'
  Then the script created three schema within 'Olist_Store' DB, bronze, silver, and gold. 


WARNING:
    The script will delete the entire 'Olist_Store' or created a new one if not exist. make sure to have a backup when running the script below.

*/


USE master;

GO

-- Drop and recreate the 'DatWarehouse' database
IF EXISTS (SELECT 1 FROM  sys.database WHERE name = 'Olist_Store')
BEGIN
      ALTER DATABASE Olist_Store SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
      DROP DATABASE Olist_Store;
END;
GO


-- Create the 'Olist_Store' database
CREATE DATABASE Olist_Store;
GO

USE Olist_Store
GO

-- Create Schema
CREATE SCHEMA bronze
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
