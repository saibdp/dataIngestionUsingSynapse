
IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'MyDelimitedTextFormat')
    CREATE EXTERNAL FILE FORMAT MyDelimitedTextFormat
WITH (
    FORMAT_TYPE = DELIMITEDTEXT,
    FORMAT_OPTIONS (
        FIELD_TERMINATOR = ',',  
        STRING_DELIMITER = '"',  
        FIRST_ROW = 2            
    )
);

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'MyDataLakeStorage')
  CREATE EXTERNAL DATA SOURCE MyDataLakeStorage
  WITH (
    LOCATION = 'abfss://raw@dlacc12432.dfs.core.windows.net'  
  );




CREATE EXTERNAL TABLE ProductCategory (
	[ ProductCategoryID] bigint,
	[ ParentProductCategoryID] bigint,
	[ Name] nvarchar(4000),
	[ rowguid] nvarchar(4000),
	[ ModifiedDate] date
	)
	WITH (
	LOCATION ='/SalesLT/ProductCategory/ProductCategory_*.csv', 
	DATA_SOURCE = MyDataLakeStorage,
	FILE_FORMAT = MyDelimitedTextFormat
	)
GO




SELECT * FROM ProductCategory