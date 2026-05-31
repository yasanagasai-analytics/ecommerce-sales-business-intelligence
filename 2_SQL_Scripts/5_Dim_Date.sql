SELECT DISTINCT
Order_Date AS Full_Date
INTO Dim_Date
FROM dbo.sales_data_clean;

ALTER TABLE Dim_Date
ADD Date_ID INT IDENTITY(1,1);

ALTER TABLE Dim_Date
ADD
Year INT,
Month INT,
Month_Name VARCHAR(20),
Quarter INT;

UPDATE Dim_Date
SET Year=YEAR(Full_Date),
Month=MONTH(Full_Date),
Month_Name=DATENAME(Month, Full_Date),
Quarter=DATEPART(Quarter, Full_Date);

ALTER TABLE Dim_Date
ADD CONSTRAINT PK_Date PRIMARY KEY (Date_ID);

SELECT * FROM Dim_Date;