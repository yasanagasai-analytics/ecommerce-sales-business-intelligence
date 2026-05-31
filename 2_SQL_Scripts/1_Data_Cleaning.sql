SELECT COUNT(*) AS total_rows
FROM dbo.Sales_data;

SELECT TOP 10 *
FROM dbo.Sales_data;

SELECT * 
FROM dbo.Sales_data
WHERE Profit IS NULL;

SELECT Order_ID, COUNT(*) AS count_duplicates
FROM dbo.Sales_data
GROUP BY Order_ID
HAVING COUNT(*)>1;

SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='Sales_data';

SELECT *
FROM dbo.Sales_data
WHERE Order_ID IN (
SELECT Order_ID
FROM dbo.Sales_data
GROUP BY Order_ID
HAVING COUNT(*)>1)
ORDER BY Order_ID;

SELECT *,
ROW_NUMBER() OVER (
PARTITION BY
Order_ID, Product_ID, Sales, Quantity, Discount, Profit
ORDER BY Order_ID
) AS rn
FROM dbo.Sales_data;

SELECT *
INTO dbo.sales_data_clean
FROM (
SELECT *,
ROW_NUMBER() OVER (
PARTITION BY
Order_ID, Product_ID, Sales, Quantity, Discount, Profit
ORDER BY Order_ID
) AS rn
FROM dbo.Sales_data
) t
WHERE rn=1;

SELECT COUNT(*) 
FROM dbo.sales_data_clean;

WITH cte AS(
SELECT *,
ROW_NUMBER() OVER (
PARTITION BY
Order_ID, Product_ID, Sales, Quantity, Discount, Profit
ORDER BY Order_ID
)AS rn_check
FROM dbo.sales_data_clean
)
SELECT * 
FROM cte
WHERE rn_check>1;

SELECT COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='sales_data_clean';

UPDATE dbo.sales_data_clean
SET
Category=LTRIM(RTRIM(Category)),
State=LTRIM(RTRIM(State)),
City=LTRIM(RTRIM(City)),
Customer_Name=LTRIM(RTRIM(Customer_Name)),
Product_Name=LTRIM(RTRIM(Product_Name)),
Segment=LTRIM(RTRIM(Segment)),
Country=LTRIM(RTRIM(Country)),
Region=LTRIM(RTRIM(Region)),
Sub_Category=LTRIM(RTRIM(Sub_Category));

UPDATE dbo.sales_data_clean
SET
City=UPPER(LEFT(City,1)) + LOWER(SUBSTRING(City,2,LEN(City))),
State=UPPER(LEFT(State,1))+LOWER(SUBSTRING(State,2,LEN(State))),
Region=UPPER(LEFT(Region,1))+LOWER(SUBSTRING(Region,2,LEN(Region))),
Category=UPPER(LEFT(Category,1))+LOWER(SUBSTRING(Category,2,LEN(Category))),
sub_Category=UPPER(LEFT(Sub_Category,1))+LOWER(SUBSTRING(Sub_Category,2,LEN(Sub_Category)));

SELECT *
FROM dbo.sales_data_clean
WHERE Sales<0 OR Quantity<0;

SELECT *
FROM dbo.sales_data_clean
WHERE Discount<0 OR Discount>1;

SELECT *
FROM dbo.sales_data_clean
WHERE Order_Date>Ship_Date;

SELECT *
FROM dbo.sales_data_clean
WHERE Profit IS NULL
OR Sales IS NULL
OR Quantity IS NULL;

DELETE FROM dbo.sales_data_clean
WHERE Profit IS NULL;

SELECT COUNT(*) AS total_rows
FROM dbo.sales_data_clean;

SELECT TOP 10 Order_Date, Ship_Date
FROM dbo.sales_data_clean;




