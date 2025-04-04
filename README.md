# Retail_sales_SQL_Project1
A Basic SQL Project For Beginning. 

Project Title: Retail Sales Analysis
Level: Beginner
Database: SQL_Project_p1

This exercise aims to showcase proficiency in SQL, particularly for data exploration, cleansing, and retail sales analysis. Participants will construct a retail sales database, conduct exploratory data analysis (EDA), and utilize SQL queries to address practical business inquiries. This project is well-suited for individuals beginning their data analysis training, providing an opportunity to strengthen their fundamental SQL abilities.

Objectives 
1. Set up a retail sales database: Create and populate a retail sales database with the provided sales data.
2. Data Cleaning: Identify and remove any records with missing or null values.
3. Exploratory Data Analysis (EDA): Perform basic exploratory data analysis to understand the dataset.
4. Business Analysis: Use SQL to answer specific business questions and derive insights from the sales data.

Project Structure
1. Database Creation: The project starts by creating a database named pSQL_Project_p1
2. Table Creation: A table named retail_sales is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.



-- SQL retail sale analysis 

-- Create Table
DROP TABLE retail_sales;

''' CREATE TABLE retail_sales
	(
	 transactions_id INT PRIMARY KEY, 	
	 sale_date DATE ,
	 sale_time TIME,
	 customer_id INT,
	 gender VARCHAR(15),
	 age INT,
	 category VARCHAR(25),
	 quantity INT,
	 price_per_unit FLOAT,
	 cogs FLOAT,
	 total_sale FLOAT 
	);
	
SELECT * FROM retail_sales ;

SELECT COUNT(*) FROM retail_sales ;


-- DATA CLEANING

-- Checking for NULL value in the table

SELECT * FROM retail_sales
WHERE transactions_id IS NULL 
	OR  sale_date IS NULL 
	OR sale_time IS NULL 
	OR customer_id IS NULL 
	OR gender IS NULL 
	OR age IS NULL               -- There are Null values IN age
	OR category IS NULL 
	OR quantity IS NULL             -- There are Null values IN age
	OR price_per_unit IS NULL      -- There are Null values IN age
	OR cogs IS NULL      -- There are Null values IN age
	OR total_sale IS NULL ;     -- There are Null values IN age

-- Deleting a null values in the table 

DELETE FROM retail_sales 
	WHERE transactions_id IS NULL 
	OR  sale_date IS NULL 
	OR sale_time IS NULL 
	OR customer_id IS NULL 
	OR gender IS NULL 
	OR age IS NULL              
	OR quantity IS NULL           
	OR price_per_unit IS NULL
	OR cogs IS NULL      
	OR total_sale IS NULL ;
	
	
-- DATA EXPLORATION

-- How many sale we have 

SELECT COUNT(*) AS total_sale FROM retail_sales ;

-- How many Unique costumer we have 

SELECT COUNT(DISTINCT customer_id) 
	FROM retail_sales ;

-- How many catogery we have 

SELECT DISTINCT category 
	FROM retail_sales ;

-- DATA ANALYSIS 

-- Q1 Write a SQL query to retrieve all columns for sales made on '2022-11-05:

SELECT * FROM retail_sales
	WHERE sale_date = '2022-11-05' ;
	
-- Q2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:	


SELECT * FROM retail_sales 
	WHERE category = 'Clothing'
		AND 
			TO_CHAR(sale_date, 'YYYY-MM') = '2022-11' 
		AND 
			quantity >= 4;
			
			
-- Q3 Write a SQL query to calculate the total sales (total_sale) for each category.:

SELECT category, SUM(total_sale) AS Net_sale 
	FROM retail_sales
	GROUP BY category;
	
	
-- Q4 Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:

SELECT ROUND(AVG(age), 2) 
	FROM retail_sales 
	WHERE category = 'Beauty' ;
	
	
-- Q5 Write a SQL query to find all transactions where the total_sale is greater than 1000.:
 
SELECT transactions_id 
	FROM retail_sales
	WHERE total_sale > 1000 ;
 
 -- Q6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:
 
 SELECT COUNT(transactions_id), category, gender
 	FROM retail_sales
	GROUP BY category, gender
	ORDER BY COUNT(transactions_id);
	
-- Q7 **Write a SQL query to find the top 5 customers based on the highest total sales **:

SELECT customer_id, COUNT(total_sale)
	FROM retail_sales
	GROUP BY customer_id 
	ORDER BY COUNT(total_sale) DESC
	LIMIT 5 ;
	
-- Q8 Write a SQL query to find the number of unique customers who purchased items from each category.:

SELECT COUNT(DISTINCT customer_id), category
	FROM retail_sales 
	GROUP BY category ;
	
-- Q9 Calculate the percentage of sales per category:

SELECT category, 
	SUM(total_sale)* 100 /
		(SELECT SUM(total_sale) FROM retail_sales) AS percentage_of_sale 
	FROM retail_sales 
	GROUP BY Category ;
	
-- Q10 Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:


SELECT 
		year, month, avg_sale 
		FROM
(
	SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2 
) AS T1
WHERE rank = 1;



-- Q11 Find the month with the highest sales revenue by year:

SELECT 
	EXTRACT(YEAR FROM sale_date) AS year,
	EXTRACT(MONTH FROM sale_date) AS month,
	SUM(total_sale) AS revenue
	FROM retail_sales
	GROUP BY year, month
	ORDER BY revenue DESC
	LIMIT 2;
	

--Q13 Identify Peak Sales Hours (Busiest Time of the Day)

SELECT 
	EXTRACT(HOUR FROM sale_time) AS time,
	SUM(total_sale) as sale_amount
	FROM retail_sales
	GROUP BY time 
	ORDER BY sale_amount DESC;

	
	
-- Q14  Identify the Most Profitable Category

SELECT 
	category,
	SUM(total_sale - cogs) AS profit
FROM retail_sales
GROUP BY category 
	ORDER BY profit ;
	

-- Q15 Find Repeat Customers (Customers Who Made More Than 5 Purchases)

SELECT customer_id, COUNT(customer_id) AS purchase_count
FROM retail_sales
	GROUP BY customer_id
	HAVING COUNT(customer_id) > 5
	ORDER BY 2 DESC;
	
	
-- Q16  Find Customers Aged Between 30 and 50 

SELECT 
	customer_id
FROM retail_sales 
	WHERE age BETWEEN 20 AND 50;
	
-- Q17 Classify Customers into Age Groups 

SELECT customer_id, age, 
  CASE
  	WHEN age < 20 THEN 'teen'
	WHEN age BETWEEN 20 AND 40 THEN 'adult'
	WHEN age BETWEEN 40 AND 60 THEN 'middle_age'
	ELSE 'senior'
	END AS age_group
FROM retail_sales ;
	 
	 
-- Q18  Find Customers Who Spent More Than $5000

SELECT customer_id, SUM(total_sale) AS total_spend
FROM retail_sales
GROUP BY customer_id 
	HAVING SUM(total_sale) > 5000 
	ORDER BY total_spend DESC;


