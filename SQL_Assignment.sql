show databases;
use world;
show tables;

CREATE TABLE IF NOT EXISTS sales(
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    tax_pct FLOAT(6,4) NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT(11,9),
    gross_income DECIMAL(12, 4),
    rating DECIMAL(3,1));
    
LOAD DATA  INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/walmart_dataset.csv' INTO TABLE sales FIELDS TERMINATED BY ',' ENCLOSED BY '"' IGNORE 1 ROWS;


select * from sales;

-- 1. How many unique cities does the data have?

select distinct(city) as city from sales;

-- 2. In which city is each branch?

  select branch,count(city) as city
  from sales
  group by branch;
  
  -- 3. How many unique product lines does the data have? 
  
  select distinct(product_line) from sales;
  
  -- 4. What is the most common payment method?
  
select payment,count(unit_price) as unit_price
from sales
group by payment
order by payment desc limit 1;

-- 5. What is the most selling product line?

select product_line,sum(total) as price
from sales
group by product_line
order by price desc limit 1;
  
-- 6. What is the total revenue by month?

select extract(month from date) as month,sum(total) as revanue
from sales
group by month
order by revanue desc limit 1;

-- 7. What month had the largest COGS?

select extract(month from date) as month,sum(cogs) as cogs
from sales
group by month
order by cogs desc limit 1;

-- 8. What product line had the largest revenue?

select product_line,sum(total) as price
from sales
group by product_line
order by price desc limit 1 ;     
  
-- 9. What is the city with the largest revenue?  

select city,sum(total) as price
from sales
group by city
order by price desc limit 1;      
  
-- 10. What product line had the largest tax_pct?

select product_line,sum(tax_pct) as tax_pct
from sales
group by product_line
order by tax_pct desc limit 1;  
  
-- 11. Fetch each product line and add a column to those product line showing "Good", "Bad". Good if its greater than average sales.

select product_line ,
case
when TOTAL > (SELECT avg(total) FROM SALES)  then 'Good'
else 'Bad'
end as 'NEW'
from sales;

-- 12. Which branch sold more products than average product sold?

select branch, count(product_line) as product_line
from sales
group by branch
limit 1;

-- 13. What is the most common product line by gender?

select gender,count(product_line) as product_line
from sales
group by gender
order by product_line desc limit 1; 

-- 14. What is the average rating of each product line?    

select product_line,avg(rating) as rating
from sales
group by product_line;

-- 15. Number of sales made in each time of the day per weekday.

select extract(hour from time) as time_of_day , extract(day from date) as date_of_day , count(quantity) as quantity
from sales
group by time_of_day , date_of_day; 

-- 16. Which of the customer types brings the most revenue?

select customer_type , sum(total) as revanue
from sales
group by customer_type
order by customer_type;
  
-- 17. Which city has the largest tax percent/ VAT (Value Added Tax)?

select city , max(tax_pct) as tax_pct
from sales
group by city
order by tax_pct desc;

-- 18. Which customer type pays the most in VAT?

select customer_type , count(tax_pct) as tax_pct
from sales
group by customer_type
order by tax_pct desc ;

-- 19. How many unique customer types does the data have?

select distinct(customer_type) from sales;

-- 20. How many unique payment methods does the data have?

select distinct(payment) from sales;

-- 21. What is the most common customer type?

select customer_type , count(quantity) as quantity
from sales
group by customer_type;

-- 22. What is the gender of most of the customers?

select gender , count(customer_type)
from sales
group by gender;

-- 23. What is the gender distribution per branch?

select branch , count(gender) as gender
from sales
group by branch; 

-- 24. Which time of the day do customers give most ratings?

select extract(hour from time) as rating_hour , count(rating) as rating
from sales
group by rating_hour; 
  
-- 25. Which time of the day do customers give most ratings per branch?

select branch , extract(hour from time) as branch_hour , count(rating) as rating  
from sales
group by branch , branch_hour;

-- 26. Which day fo the week has the best avg ratings?

select extract(day from date) as day , avg(rating) as rating
from sales
group by day
order by rating desc limit 1;

-- 27. Which day of the week has the best average ratings per branch?    
   
select branch , extract(day from date) as day , avg(rating) as rating  
from sales
group by branch , day
order by rating desc limit 1;  
   
select * from sales;