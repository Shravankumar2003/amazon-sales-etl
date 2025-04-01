/*CREATE TABLE Amazon_Sales_Report (
    order_id VARCHAR(50),
    order_date DATE,
    status VARCHAR(50),
    fulfilment VARCHAR(50),
    sales_channel VARCHAR(50),
    ship_service_level VARCHAR(50),
    style VARCHAR(50),
    sku VARCHAR(50),
    category VARCHAR(50),
    size VARCHAR(50),
    asin VARCHAR(50),
    courier_status VARCHAR(200),
    quantity INT,
    currency VARCHAR(10),
    order_amount FLOAT,
    ship_city VARCHAR(100),
    ship_state VARCHAR(100),
    ship_postal_code VARCHAR(20),
    ship_country VARCHAR(50),
    promotion_ids VARCHAR(MAX),
    b2b VARCHAR(50),
    fulfilled_by VARCHAR(50),
    total_order_sales FLOAT
);*/


SELECT * FROM Amazon_Sales_Report


--The highest top 3 highest revenue generating categories
SELECT TOP 3 category, SUM(order_amount) AS revenue
FROM df_Amazon_Sales_Report
GROUP BY category
ORDER BY revenue DESC;


--The top 3 highest sales in the month 
SELECT 
    FORMAT(order_date, 'MMMM') AS year_month,
    SUM(total_order_sales) AS total_sales
FROM 
    df_Amazon_Sales_Report
GROUP BY 
    FORMAT(order_date, 'MMMM')
ORDER BY 
    total_sales DESC
OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY;

--Top 3 highest sales (States)
SELECT 
    ship_city,
    SUM(total_order_sales) AS total_sales
FROM 
    df_Amazon_Sales_Report
GROUP BY 
    ship_city
ORDER BY 
    total_sales DESC
OFFSET 0 ROWS FETCH NEXT 3 ROWS ONLY;


--Fulfilment split
SELECT 
    fulfilment,
    COUNT(order_id) AS total_orders,
    SUM(total_order_sales) AS total_sales
FROM 
    df_Amazon_Sales_Report
GROUP BY 
    fulfilment
ORDER BY 
    total_sales DESC;


--B2B vs B2C
SELECT 
    b2b,
    COUNT(order_id) AS total_orders,
    SUM(total_order_sales) AS total_sales
FROM 
    df_Amazon_Sales_Report
GROUP BY 
    b2b
ORDER BY 
    total_sales DESC;



--Average Order Value(AOV)
SELECT 
    AVG(total_order_sales) AS avg_order_value
FROM 
    df_Amazon_Sales_Report;


--RCA Underperforming status 
SELECT 
    status,
    COUNT(order_id) AS total_orders
FROM 
    df_Amazon_Sales_Report
WHERE 
    status IN ('Shipped - Lost in Transit', 'Shipped - Damaged', 'Shipped - Returned to Seller')
GROUP BY 
    status
ORDER BY 
    total_orders DESC;


--Cancelled Orders

SELECT 
    courier_status, 
    COUNT(order_id) AS total_orders
FROM 
    df_Amazon_Sales_Report
WHERE 
    courier_status = 'cancelled'
GROUP BY 
    courier_status;


---SIZE's with Percentages.
SELECT 
    size,
    COUNT(order_id) AS total_orders,
    SUM(total_order_sales) AS total_sales,
    SUM(total_order_sales) * 100.0 / SUM(SUM(total_order_sales)) OVER () AS sales_percentage
FROM 
    df_Amazon_Sales_Report
WHERE 
    size IS NOT NULL
GROUP BY 
    size
ORDER BY 
    total_sales DESC;


--Top 5 SKU's

SELECT 
    sku,
    SUM(total_order_sales) AS total_sales
FROM 
    df_Amazon_Sales_Report
GROUP BY 
    sku
ORDER BY 
    total_sales DESC
OFFSET 0 ROWS FETCH NEXT 5 ROWS ONLY;

--IND vs other (sales)
SELECT 
    ship_country,
    COUNT(order_id) AS total_orders,
    SUM(total_order_sales) AS total_sales
FROM 
    df_Amazon_Sales_Report
GROUP BY 
    ship_country
ORDER BY 
    total_sales DESC;


--Month over Month Growth comparision
SELECT 
    YEAR(order_date) AS year,
    MONTH(order_date) AS month,
    SUM(order_amount) AS total_sales,
    LAG(SUM(order_amount), 1) OVER (PARTITION BY YEAR(order_date) ORDER BY MONTH(order_date)) AS previous_month_sales,
    (SUM(order_amount) - LAG(SUM(order_amount), 1) OVER (PARTITION BY YEAR(order_date) ORDER BY MONTH(order_date))) * 100.0 / 
    LAG(SUM(order_amount), 1) OVER (PARTITION BY YEAR(order_date) ORDER BY MONTH(order_date)) AS month_over_month_growth
FROM 
    Amazon_Sales_Report
WHERE 
    YEAR(order_date) = 2022
GROUP BY 
    YEAR(order_date), MONTH(order_date)
ORDER BY 
    year, month;

	
	
