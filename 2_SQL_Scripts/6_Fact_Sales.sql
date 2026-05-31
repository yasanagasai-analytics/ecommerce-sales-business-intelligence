SELECT
s.Order_ID,
c.Customer_ID,
p.Product_ID,
r.Region_ID,
d1.Date_ID AS Order_Date_ID,
d2.Date_ID AS Ship_Date_ID,

s.Sales,
s.Profit,
s.Quantity,
s.Discount

INTO Fact_Sales

FROM dbo.sales_data_clean s

JOIN Dim_Customers c
ON s.Customer_ID=c.Customer_ID

JOIN Dim_Products p
ON s.Product_ID=p.Product_ID

JOIN Dim_Region r
ON s.City=r.City
AND s.State=r.State
AND s.Country=r.Country
AND s.Postal_Code=r.Postal_Code

JOIN Dim_Date d1
ON s.Order_Date=d1.Full_Date

JOIN Dim_Date d2
ON s.Ship_Date=d2.Full_Date;


ALTER TABLE Fact_Sales
ADD CONSTRAINT PK_Fact PRIMARY KEY (Order_ID, Product_ID);

ALTER TABLE Fact_Sales
ADD Sales_ID INT IDENTITY(1,1);

ALTER TABLE Fact_Sales
ADD CONSTRAINT PK_Fact PRIMARY KEY (Sales_ID);

ALTER TABLE Fact_Sales
ADD CONSTRAINT FK_Customer
FOREIGN KEY (Customer_ID)
REFERENCES Dim_Customers(Customer_ID);

ALTER TABLE Fact_Sales
ADD CONSTRAINT FK_Product
FOREIGN KEY (Product_ID)
REFERENCES Dim_Products(Product_ID);

ALTER TABLE Fact_Sales
ADD CONSTRAINT FK_Region
FOREIGN KEY (Region_ID)
REFERENCES Dim_Region(Region_ID);

ALTER TABLE Fact_Sales
ADD CONSTRAINT FK_Order_Date
FOREIGN KEY (Order_date_ID)
REFERENCES Dim_Date(Date_ID);

ALTER TABLE Fact_Sales
ADD CONSTRAINT FK_Ship_Date
FOREIGN KEY (Ship_Date_ID)
REFERENCES Dim_Date(Date_ID);

SELECT * FROM Fact_Sales;
