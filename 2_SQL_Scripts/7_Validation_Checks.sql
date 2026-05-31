EXEC sp_help 'Dim_Customers';
EXEC sp_help 'Dim_products';
EXEC sp_help 'Dim_Region';
EXEC sp_help 'Fact_Sales';

SELECT 
    t.name AS table_name,
    c.name AS column_name
FROM sys.indexes i
JOIN sys.index_columns ic ON i.object_id = ic.object_id AND i.index_id = ic.index_id
JOIN sys.columns c ON ic.object_id = c.object_id AND ic.column_id = c.column_id
JOIN sys.tables t ON i.object_id = t.object_id
WHERE i.is_primary_key = 1;


SELECT 
F.name AS FK_name,
OBJECT_Name(f.parent_object_id) AS table_name
FROM sys.foreign_keys f;

SELECT *
FROM Fact_Sales
WHERE Customer_ID IS NULL
OR Product_ID IS NULL
OR Region_ID IS NULL
OR Order_Date_ID IS NULL;

SELECT COUNT(*) 
FROM dbo.sales_data_clean;

SELECT COUNT(*) 
FROM Fact_Sales;

SELECT Sales_ID, COUNT(*)
FROM Fact_Sales
GROUP BY Sales_ID
HAVING COUNT(*)>1;
