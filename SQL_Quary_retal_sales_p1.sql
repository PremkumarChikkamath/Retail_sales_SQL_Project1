-- SQL retail sale analysis 

-- Create Table
DROP TABLE retail_sales;

CREATE TABLE retail_sales
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

		