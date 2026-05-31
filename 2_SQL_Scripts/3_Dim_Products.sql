SELECT DISTINCT
Product_ID,
Product_Name,
Category,
Sub_Category
INTO Dim_Products
FROM dbo.sales_data_clean;

ALTER TABLE Dim_Products
ADD CONSTRAINT PK_Products PRIMARY KEY (Product_ID);

SELECT Product_ID, COUNT(*)
FROM Dim_Products
GROUP BY Product_id
HAVING COUNT(*)>1;

DROP TABLE Dim_Products;

SELECT 
Product_ID,
MAX(Product_Name) AS Product_Name,
MAX(Category) AS Category,
MAX(Sub_Category) AS Sub_Category
INTO Dim_Products
FROM dbo.sales_data_clean
GROUP BY Product_ID;

ALTER TABLE Dim_Products
ADD CONSTRAINT PK_Products PRIMARY KEY(Product_ID);

SELECT * FROM Dim_Products;