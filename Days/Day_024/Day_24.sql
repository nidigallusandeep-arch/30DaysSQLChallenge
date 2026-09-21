-- SQL Day_24 = Window Functions Interview Questions.
create database team;
use team;

CREATE TABLE employee_salary (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(30),
    salary INT,
    city VARCHAR(30),
    joining_date DATE
);

INSERT INTO employee_salary
(emp_id, emp_name, department, salary, city, joining_date)
VALUES
(1, 'Ravi',   'IT',      55000, 'Hyderabad', '2022-06-15'),
(2, 'Suresh', 'IT',      70000, 'Bangalore', '2021-03-20'),
(3, 'Rahul',  'IT',      70000, 'Hyderabad', '2022-09-18'),
(4, 'Arjun',  'IT',      85000, 'Chennai',   '2018-04-15'),
(5, 'Manoj',  'IT',      60000, 'Bangalore', '2022-12-01'),

(6, 'Priya',  'HR',      45000, 'Hyderabad', '2023-01-10'),
(7, 'Anjali', 'HR',      60000, 'Chennai',   '2020-11-05'),
(8, 'Divya',  'HR',      50000, 'Hyderabad', '2023-05-19'),
(9, 'Swathi', 'HR',      65000, 'Chennai',   '2021-10-11'),
(10,'Pooja',  'HR',      60000, 'Bangalore', '2020-09-17'),

(11,'Kiran',  'Finance', 75000, 'Mumbai',     '2019-08-12'),
(12,'Sneha',  'Finance', 65000, 'Bangalore', '2021-07-22'),
(13,'Vijay',  'Finance', 75000, 'Mumbai',     '2020-02-25'),
(14,'Naveen', 'Finance', 55000, 'Hyderabad', '2023-02-14'),
(15,'Varun',  'Finance', 60000, 'Chennai',   '2022-01-20');


select * from employee_salary;

-- 1. Give row number to all employees based on salary
select  
     emp_name,
     department,
     salary,
     row_number()over(order by salary desc) as rnk
     from employee_salary;
     
-- 2. Rank employees based on salary
select 
       emp_name,
       department,
       salary,rank()over(order by salary desc
       ) as rnk
       from employee_salary;

-- 3. Rank employees without gaps
select 
       emp_name,
       department,
       salary,dense_rank()over(order by salary desc) as rnk
       from employee_salary;

-- 4. Rank employees department-wise
select 
       emp_name,
       salary,
       department,rank()over(partition by department order by salary desc) as rnk
       from employee_salary;
       
-- 5. Find highest-paid employee in each department
with highest_salary as(
select
       emp_name,
       salary,
       department,rank()over(partition by department order by salary desc) as rnk
       from employee_salary
       )
select * from highest_salary
where rnk=1;


-- 6. Find second-highest salary in each department
with second_highest as(
select 
     emp_name,
     salary,
     department,dense_rank()over(partition by department order by salary desc) as rnk
     from employee_salary
     )
     select * from second_highest
     where rnk=2;
     
     
-- 7. Find top 2 employees from each department
with top_employees as(
select 
     emp_name,
     salary,
     department,dense_rank()over(partition by department order by salary desc) as rnk
     from employee_salary
     )
     select * from top_employees
     where rnk<=2;
     
-- 8. Find average salary of each department beside every employee
select 
       emp_name,
       salary,
       department,avg(salary)over(partition by department
       ) as dept_avg_salary
       from employee_salary;
       
-- 9. Find employees earning more than their department average
WITH data AS (
    SELECT
        emp_name,
        department,
        salary,
        AVG(salary) OVER (
            PARTITION BY department
        ) AS dept_avg
    FROM employee_salary
)
SELECT *
FROM data
WHERE salary > dept_avg;


-- 10. Find previous employee salary using LAG()
select 
     emp_name,
     salary,
     department,lag(salary)over(order by emp_id) as previos_salary
     from employee_salary;
     
-- 11. Find next employee salary using LEAD()
select 
      emp_name,
      salary,
      department,lead(salary)over(order by emp_id) as next_salary
      from employee_salary;
      
-- 12. Find salary difference from previous employee
SELECT
    emp_name,
    salary,
    LAG(salary) OVER (
        ORDER BY emp_id
    ) AS previous_salary,
    
    salary - LAG(salary) OVER (
        ORDER BY emp_id
    ) AS salary_difference
FROM employee_salary;


-- 13. Calculate running total salary
select 
       emp_name,
       salary,
       department,sum(salary)over(order by emp_id) as running_total_salary
       from employee_salary;
       
-- 14. Calculate department-wise running salary
select 
      emp_name,
      salary,
      department,sum(salary)over(partition by department order by emp_id)as dpt_running_salary
      from employee_salary;
      
-- 15. Find each employee's percentage contribution to department salary
SELECT
    emp_name,
    department,
    salary,
    ROUND(
        salary * 100.0 /
        SUM(salary) OVER (
            PARTITION BY department
        ),
        2
    ) AS salary_percentage
FROM employee_salary;