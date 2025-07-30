--SQL Retail Sales Analysis
Create database 01_Case_Study;

--- Create Table
DROP TABLE IF EXISTS retail_Sales ;

create table retail_sales(
					transactions_id	int PRIMARY KEY,
					sale_date       date,
					sale_time       time,
					customer_id	    int,
					gender	        varchar(15),
					age	            int,
					category        varchar(15),
					quantity	    int,
					price_per_unit  float,
					cogs            float,
					total_sale      float
				           );  
--Checking Inserted Data

select * from retail_sales;

select count(*) from retail_sales ;

--Analyzing Data 

--Checking Null Values

select * from retail_sales
where transactions_id is null
or
sale_date is null
or 
sale_time is null
or 
gender is null
or 
age is null
or 
category is null
or 
quantity is null
or
 price_per_unit is null
or
 cogs is null
or
 total_sale is null ;

--Removing Null Values

delete from retail_sales
where 
quantity is null
or
price_per_unit is null
or
cogs is null
or
total_sale is null ;

--Data exploration

-- How many sales we have ?
select count(*) from retail_sales ; 

-- How many customers we have ?
select count (distinct customer_id) as total_customers from retail_sales ;

-- How many categories we have ?
select count(distinct category ) as Categories from retail_sales ;

-- Data Analysis 

--01.Write a SQL query to retrieve all columns for sales made on '2022-11-05:
select * from retail_sales;

select * from retail_sales
where sale_date = '2022-11-05';

--02.Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:

select * from retail_sales
where category = 'Clothing' 
and to_char(sale_date,'YYYY-MM')='2022-11'
and quantity >= 4 
;

--03.Write a SQL query to calculate the total sales (total_sale) for each category.:
select category , sum(total_sale) as total_sales
from retail_sales
group by category;

--04.Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
select round(avg(age),2) as average_age  from retail_sales
where category = 'Beauty' ; 

--05.Write a SQL query to find all transactions where the total_sale is greater than 1000.:

select * from retail_sales
where total_sale > 1000 ;

--06.Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:

select category,gender,count(transactions_id)
from retail_sales 
group by 1,2
order by 1 ;


--07.**Write a SQL query to find the top 5 customers based on the highest total sales **:

select customer_id,
sum(total_sale) as total_sales 
from retail_sales
group by 1
order by 2 desc 
limit 5 ;

--08.Write a SQL query to find the number of unique customers who purchased items from each category.:

select category, count( distinct customer_id) as unique_customers
from retail_sales
group by category;

--9.Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17):
select * from retail_sales ;

with hourly_sale
as
(
select *,
	case
	   when extract (hour from sale_time ) < 12 then 'Morning'
	   when extract (hour from sale_time ) between 12 and 17 then 'Afternoon'
	   else 'Evening'
	end as shift 
from retail_sales
) select 
shift,
count(*) as total_orders
from hourly_sale
group by shift ; 
 
