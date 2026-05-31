
SELECT DISTINCT
Region,
City,
State,
Country,
Postal_Code
INTO Dim_Region
FROM dbo.sales_data_clean;

ALTER TABLE Dim_Region
ADD Region_ID INT IDENTITY(1,1);

ALTER TABLE Dim_Region
ADD CONSTRAINT PK_Region PRIMARY KEY(Region_ID);

SELECT * FROM Dim_Region;