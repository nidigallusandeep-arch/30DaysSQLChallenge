-- Day 27 = Real-Time SQL Case Studies

-- -- Day 27 — SQL Real-Time Case Studies

CREATE DATABASE day27_db;

USE day27_db;

CREATE TABLE sales (
    sale_id INT PRIMARY KEY,
    customer_id INT,
    product VARCHAR(50),
    category VARCHAR(30),
    quantity INT,
    price INT,
    sale_date DATE
);

INSERT INTO sales
VALUES
(1, 101, 'Laptop', 'Electronics', 1, 60000, '2024-01-10'),
(2, 102, 'Mouse', 'Electronics', 2, 1000, '2024-01-12'),
(3, 103, 'Keyboard', 'Electronics', 1, 2000, '2024-01-15'),
(4, 101, 'Mobile', 'Electronics', 1, 30000, '2024-02-05'),
(5, 104, 'Chair', 'Furniture', 2, 5000, '2024-02-10'),
(6, 105, 'Table', 'Furniture', 1, 12000, '2024-02-15'),
(7, 102, 'Laptop', 'Electronics', 1, 60000, '2024-03-01'),
(8, 103, 'Chair', 'Furniture', 1, 5000, '2024-03-05'),
(9, 101, 'Mouse', 'Electronics', 3, 1000, '2024-03-10'),
(10, 106, 'Mobile', 'Electronics', 2, 30000, '2024-03-15'),
(11, 104, 'Table', 'Furniture', 2, 12000, '2024-04-01'),
(12, 107, 'Laptop', 'Electronics', 1, 60000, '2024-04-10'),
(13, 105, 'Keyboard', 'Electronics', 2, 2000, '2024-04-15'),
(14, 106, 'Chair', 'Furniture', 1, 5000, '2024-05-01'),
(15, 108, 'Mobile', 'Electronics', 1, 30000, '2024-05-10');

select * from sales;

-- Q1. Calculate total sales amount
select sum(quantity*price)as total_sales
from sales;


-- Q2. Find total sales by product
select product,sum(quantity*price)as total_sales
from sales
group by product
order by total_sales desc;

-- Q3. Find total sales by category
select category,sum(quantity*price)as total_sales
from sales
group by category;

-- Q4. Find products with sales greater than ₹50,000
select product,sum(quantity*price)as total_sales
from sales
group by product
having total_sales>50000;


-- Q5. Find total quantity sold for each product
select product,sum(quantity)as total_quantity
from sales
group by product
order by total_quantity;

-- Q6. Find monthly sales
select MONTH(sale_date) AS sale_month,
    SUM(quantity * price) AS monthly_sales
FROM sales
GROUP BY MONTH(sale_date)
ORDER BY sale_month;


-- Q7. Find the highest-selling product
select product,max(quantity*price)as highest_selling
from sales
group by product
order by highest_selling desc
limit 1;

-- Q8. Find customers who spent more than ₹50,000
SELECT
    customer_id,
    SUM(quantity * price) AS total_spent
FROM sales
GROUP BY customer_id
HAVING SUM(quantity * price) > 50000;

-- Q9. Find each customer's number of orders
select customer_id,count(*) as order_count
from sales
group by customer_id
order by order_count desc;

-- Q10. Find average order value
select avg(quantity*price) as avg_orders
from sales;

-- Q11. Rank products based on sales
WITH product_sales AS (
    SELECT
        product,
        SUM(quantity * price) AS total_sales
    FROM sales
    GROUP BY product
)
SELECT
    product,
    total_sales,
    DENSE_RANK() OVER (
        ORDER BY total_sales DESC
    ) AS sales_rank
FROM product_sales;

-- Q12. Find top 3 products
WITH product_sales AS (
    SELECT
        product,
        SUM(quantity * price) AS total_sales
    FROM sales
    GROUP BY product
),
ranked_products AS (
    SELECT
        product,
        total_sales,
        DENSE_RANK() OVER (
            ORDER BY total_sales DESC
        ) AS rnk
    FROM product_sales
)
SELECT
    product,
    total_sales,
    rnk
FROM ranked_products
WHERE rnk <= 3;

-- Q13. Find customer's highest purchase
WITH customer_sales AS (
    SELECT
        customer_id,
        SUM(quantity * price) AS total_spent
    FROM sales
    GROUP BY customer_id
)
SELECT
    customer_id,
    total_spent
FROM customer_sales
WHERE total_spent = (
    SELECT MAX(total_spent)
    FROM customer_sales
);

-- Q14. Categorize customers based on spending
WITH customer_sales AS (
    SELECT
        customer_id,
        SUM(quantity * price) AS total_spent
    FROM sales
    GROUP BY customer_id
)
SELECT
    customer_id,
    total_spent,
    CASE
        WHEN total_spent >= 60000 THEN 'Premium'
        WHEN total_spent >= 30000 THEN 'Regular'
        ELSE 'Basic'
    END AS customer_category
FROM customer_sales;

-- Find the top 3 customers based on total spending and categorize them.
WITH customer_sales AS (
    SELECT
        customer_id,
        SUM(quantity * price) AS total_spent
    FROM sales
    GROUP BY customer_id
),
ranked_customers AS (
    SELECT
        customer_id,
        total_spent,
        DENSE_RANK() OVER (
            ORDER BY total_spent DESC
        ) AS rnk
    FROM customer_sales
)
SELECT
    customer_id,
    total_spent,
    CASE
        WHEN total_spent >= 60000 THEN 'Premium'
        WHEN total_spent >= 30000 THEN 'Regular'
        ELSE 'Basic'
    END AS customer_category
FROM ranked_customers
WHERE rnk <= 3
ORDER BY total_spent DESC;



