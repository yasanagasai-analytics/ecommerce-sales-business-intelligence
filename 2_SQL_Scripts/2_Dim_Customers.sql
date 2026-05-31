SELECT DISTINCT
Customer_ID,
Customer_Name
INTO Dim_Customers
FROM dbo.sales_data_clean;

ALTER TABLE Dim_Customers
ADD CONSTRAINT PK_Customers PRIMARY KEY(Customer_ID);

SELECT * FROM Dim_Customers;