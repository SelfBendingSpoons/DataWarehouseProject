/*
===============================================================
Create Database and Schemas
===============================================================

This script will check for any database named DataWarehouse, if one is found, it will delete it and create a new one with the same name.
It will then  connect to it and create the bronze, silver, and gold schemas that will be used throughout this project
*/

USE master;
GO

-- Drops 'DataWarehouse' database if present--
-- WARNING: THIS WILL REMOVE ALL DATA CURRENTLY IN THE DataWarehouse --
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse
END;
GO

-- Creates then begins using DataWarehouse --
CREATE DATABASE DataWarehouse;
GO
  
USE DataWarehouse;
GO


-- Creates schemas bronze, silver, and gold --
CREATE SCHEMA bronze;
GO
  
CREATE SCHEMA silver;
GO
  
CREATE SCHEMA gold;
GO

