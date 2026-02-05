-- SELECTED THE DATABASE
USE projects;

-- TABLE CREATED
DROP TABLE IF EXISTS retail_sales;  
CREATE TABLE retail_sales
(
	transactions_id	INT PRIMARY KEY,
    sale_date DATE,
    sale_time TIME,
    customer_id	INT,
    gender VARCHAR(6),
    age INT,	
    category VARCHAR(11), 	
    quantity INT, 	
    price_per_unit INT,
    cogs INT,	
    total_sale INT
);

-- DISPLAY THE TABLE
SELECT * FROM retail_sales;

-- RECORD COUNT
SELECT COUNT(transactions_id) FROM retail_sales;

-- CUSTOMER COUNT
SELECT COUNT(DISTINCT customer_id) AS unique_customers FROM retail_sales;

-- CATEGORY COUNT
SELECT DISTINCT category FROM retail_sales;

-- query to retrieve all columns for sales made on '2022-11-05'
SELECT * FROM retail_sales WHERE sale_date = '2022-11-05';

-- query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022
SELECT * FROM retail_sales WHERE category = 'Clothing' AND quantity >= 4 
AND (sale_date BETWEEN '2022-11-01' AND '2022-11-30');

--  query to calculate the total sales (total_sale) for each category
SELECT category, SUM(total_sale) AS Total_Sales FROM retail_sales GROUP BY category;

-- query to find the average age of customers who purchased items from the 'Beauty' category
SELECT ROUND(AVG(age),2) AS Average_Age FROM retail_sales WHERE category = 'Beauty';

-- query to find all transactions where the total_sale is greater than 1000
SELECT * FROM retail_sales WHERE total_sale > 1000;

-- query to find the total number of transactions (transaction_id) made by each gender in each category
SELECT category, gender, COUNT(transactions_id) AS Total_Number_Of_Transaction 
FROM retail_sales GROUP BY category, gender ORDER BY category;

-- query to calculate the average sale for each month.
SELECT EXTRACT(YEAR FROM sale_date) AS sale_year, EXTRACT(MONTH FROM sale_date) AS sale_month, 
AVG(total_sale) AS Average_Sales FROM retail_sales GROUP BY sale_year, sale_date;

-- query to find the top 5 customers based on the highest total sales
SELECT customer_id, SUM(total_sale) AS Total_Sales 
FROM retail_sales GROUP BY customer_id ORDER BY Total_Sales DESC LIMIT 5;

-- query to find the number of unique customers who purchased items from each category
SELECT category, COUNT(DISTINCT customer_id) AS Unique_Customer
FROM retail_sales GROUP BY category;

-- query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
WITH CTE AS
(SELECT *,
CASE
		WHEN EXTRACT(HOUR FROM sale_time) < 12 THEN 'Morning'
        WHEN EXTRACT(HOUR FROM sale_time) BETWEEN 12 AND 17 THEN 'Afternoon'
        ELSE 'Evening'
END AS Shift_Time FROM retail_sales)
SELECT Shift_Time, COUNT(*) AS Total_Orders FROM CTE GROUP BY Shift_Time;

        
 








