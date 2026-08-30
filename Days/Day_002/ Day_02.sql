# Day 2 – SQL Problem Solving
-- Today let's work with Aggregate Functions + GROUP BY + HAVING.
use car;
CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    product VARCHAR(50),
    category VARCHAR(50),
    quantity INT,
    price INT,
    sale_date DATE
);

INSERT INTO sales
(sale_id, customer_name, product, category, quantity, price, sale_date)
VALUES
(1, 'Sandeep', 'Laptop', 'Electronics', 1, 60000, '2026-01-05'),
(2, 'Rahul', 'Mouse', 'Electronics', 2, 1000, '2026-01-08'),
(3, 'Priya', 'Keyboard', 'Electronics', 1, 2500, '2026-01-10'),
(4, 'Anjali', 'Chair', 'Furniture', 2, 5000, '2026-01-12'),
(5, 'Kiran', 'Table', 'Furniture', 1, 8000, '2026-01-15'),
(6, 'Ravi', 'Laptop', 'Electronics', 1, 65000, '2026-01-18'),
(7, 'Sneha', 'Chair', 'Furniture', 3, 4500, '2026-01-20'),
(8, 'Arjun', 'Monitor', 'Electronics', 2, 12000, '2026-01-22'),
(9, 'Divya', 'Table', 'Furniture', 2, 7500, '2026-01-25'),
(10, 'Vijay', 'Mouse', 'Electronics', 5, 900, '2026-01-28'),
(11, 'Sandeep', 'Monitor', 'Electronics', 1, 15000, '2026-02-02'),
(12, 'Rahul', 'Chair', 'Furniture', 1, 5500, '2026-02-05'),
(13, 'Priya', 'Laptop', 'Electronics', 2, 58000, '2026-02-08'),
(14, 'Anjali', 'Table', 'Furniture', 1, 9000, '2026-02-10'),
(15, 'Kiran', 'Keyboard', 'Electronics', 3, 2200, '2026-02-12');

select * from sales;


-- Day 2 – 15 Problems

-- Q1. Find the total number of sales.
select count(*) as total_sales
from sales;

-- Q2. Total quantity of products sold
select sum(quantity)as total_quantity
from sales;

-- Q3. Average product price
SELECT AVG(price) AS average_price
FROM sales;

-- Q4. Highest product price
select max(price) as max_price
from sales;

-- Q5. Lowest product price
select min(price) as lowest_price
from sales;

-- GROUP BY
-- Q6. Total quantity sold for each product
select product,sum(quantity) as total_quantity
from sales
group by product;

-- Q7. Number of sales for each category
select category,count(*) as total_sales
from sales
group by category;

-- Q8. Average price for each category
select category,avg(price)as avg_price
from sales
group by category;

-- Q9. Total quantity sold by each customer
select customer_name,sum(quantity) as total_quantity
from sales
group by customer_name;

-- Q10. Highest price for each product
select product,max(price)as highest_price
from sales
group by product;

-- HAVING
-- 11. Products whose total quantity > 2
select product,sum(quantity) as total_quantity
from sales
group by product
having total_quantity>2;

-- Q12. Categories having more than 5 total products
select category,
       SUM(quantity) AS total_quantity
from sales
group by category
having total_quantity>5;

-- Q13. Customers who made more than 1 purchase
select customer_name,count(*) as purchas
from sales
group by customer_name
having purchas>1;

--  Q14. Product with highest total quantity
select product,max(quantity) as total_quantity
from sales
group by product
order by total_quantity desc
limit 1;

-- Q15. Top 3 products based on total sales amount
select product,sum(quantity*price)total_sales
from sales
group by product
order by total_sales desc
limit 3;




