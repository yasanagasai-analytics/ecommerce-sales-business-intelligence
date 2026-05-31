-- SQL ANALYSIS: (BUSINESS INSIGHTS)

--1.Total Sales Overview
SELECT 
SUM(Sales) AS Total_Sales,
COUNT(*) AS Total_Orders
FROM Fact_Sales;

--2.Sales by Category
SELECT
P.Category,
SUM(f.Sales) AS Total_Sales
FROM Fact_Sales f
JOIN Dim_Products p 
ON f.Product_ID=p.Product_ID
GROUP BY p.Category
ORDER BY Total_Sales DESC;

--3.Sales by State
SELECT 
r.State,
SUM(f.Sales) AS total_sales
FROM Fact_Sales f
JOIN Dim_Region r 
ON f.Region_ID=r.Region_ID
GROUP BY r.State
ORDER BY total_sales DESC;

--4.Monthly Sales Trend
SELECT 
d.Year,
d.Month,
SUM(f.sales) AS monthly_sales
FROM Fact_Sales f
JOIN Dim_Date d 
ON f.Order_Date_ID=d.Date_ID
GROUP BY d.Year, d.Month
Order by d.Year, d.Month;

--5.Top Products
SELECT TOP 5
p.Product_Name,
SUM(f.Sales) AS total_sales
FROM Fact_Sales f
JOIN Dim_Products p 
ON f.Product_ID=p.Product_ID
GROUP BY p.Product_Name
ORDER BY total_sales DESC;

--6.Customer Analysis
SELECT 
c.Customer_Name,
COUNT(f.Sales_ID) AS total_orders,
SUM(f.Sales) AS total_spent
FROM Fact_Sales f
JOIN Dim_Customers c 
ON f.Customer_ID=c.Customer_ID
GROUP BY C.Customer_Name
ORDER BY total_spent DESC;

--7.CTE:Category -Wise Sales Analysis
WITH Category_Sales AS(
SELECT
p.Category,
SUM(f.sales) AS total_sales
FROM Fact_Sales f
JOIN Dim_Products p 
ON f.Product_ID=p.Product_ID
GROUP BY p.Category
)
SELECT *
FROM Category_Sales
ORDER BY total_sales DESC;

--8.Ranking:Top Products per Category
SELECT *
FROM (
SELECT
p.Category,
p.Product_Name,
SUM(f.Sales) AS total_sales,
RANK() OVER (
PARTITION BY p.Category 
ORDER BY SUM(f.Sales) Desc) AS rank_no
FROM Fact_Sales f
JOIN Dim_Products p 
ON f.Product_ID=p.Product_ID
GROUP BY p.Category, p.Product_Name
)t
WHERE rank_no<=3;

--9.ROW_NUMBERS:Unique Product Ranking
SELECT
p.Product_Name,
SUM(f.Sales) AS total_sales,
ROW_NUMBER() OVER (
ORDER BY SUM(f.Sales) DESC) AS row_num
FROM Fact_Sales f
JOIN Dim_Products p 
ON f.Product_ID=p.Product_ID
GROUP BY p.Product_Name;

--10.CASE WHEN:Sales Segmentation
SELECT
Sales,
CASE 
WHEN Sales>1000 THEN 'High Value'
WHEN Sales BETWEEN 500 AND 1000 THEN 'Medium Value'
ELSE 'Low Value'
END AS Order_category
FROM Fact_Sales;

--11.Monthly Growth Analysis (LAG)
WITH monthly_sales AS (
SELECT 
d.Year,
d.Month,
SUM(f.Sales) AS total_sales
FROM Fact_Sales f
JOIN Dim_Date d 
ON f.Order_Date_ID=d.Date_ID
GROUP BY d.Year, d.Month
)
SELECT *,
LAG(total_sales) OVER (
ORDER BY Year, Month) AS prev_month,
((total_sales - LAG(total_sales) OVER (
ORDER BY Year, Month))* 100.0
/ LAG(total_sales) OVER (
ORDER BY Year, Month)) AS growth_percentage
FROM monthly_sales;

--12.Repeat Customers
SELECT 
Customer_ID,
COUNT(*) AS Order_Count
FROM Fact_Sales
GROUP BY Customer_ID
HAVING COUNT(*)>1;

SELECT TOP 10 *
FROM Dim_Region;

--13.Average Order Value
SELECT
SUM(Sales)/COUNT(Sales_ID) AS avg_order_value
FROM Fact_Sales;

--14.Repeat VS New Customers
SELECT 
    CASE 
        WHEN COUNT(*) = 1 THEN 'One-time'
        ELSE 'Repeat'
    END AS customer_type,
    COUNT(*) AS customer_count
FROM Fact_Sales
GROUP BY Customer_ID;

--15.Top Customers
SELECT TOP 10
Customer_ID,
SUM(Sales) AS total_spent
FROM Fact_Sales
GROUP BY Customer_ID
ORDER BY total_spent DESC;

--16.Shipping Delay Analysis
SELECT 
    AVG(DATEDIFF(day, od.full_date, sd.full_date)) AS avg_shipping_days
FROM Fact_Sales f
JOIN Dim_Date od 
ON f.Order_Date_ID = od.Date_ID
JOIN Dim_Date sd 
ON f.Ship_Date_ID = sd.Date_ID

--17.Contribution % by Category
WITH category_sales AS (
    SELECT 
        p.category,
        SUM(f.sales) AS total_sales
    FROM Fact_Sales f
    JOIN Dim_Products p 
    ON f.product_id = p.product_id
    GROUP BY p.category
)
SELECT 
    category,
    total_sales,
    (total_sales * 100.0 / SUM(total_sales) OVER()) AS contribution_percent
FROM category_sales;
SELECT TOP 10* 
FROM sales_data_clean;