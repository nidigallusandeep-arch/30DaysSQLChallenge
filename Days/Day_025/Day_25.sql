-- SQL Day 25 — 15 Interview Questions
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

-- 1 Categorize employees based on salary
select  
     emp_name,
     salary,
     case 
         when salary >= 80000 then "High Salary"
         when salary>= 60000 then "Medium Salary"
         else "Low Salary"
	end as salary_employees
    from employee_salary;
    
    
-- 2.Count employees in each salary category
select 
      case
         when salary>=80000 then "High Salary"
         when salary>=60000 then "Medium salary"
         else "low salary"
         end as emp_salary,
         count(*) as employee_count
from employee_salary
group by 
      case 
           when salary>=80000 then "High Salary"
           when salary>=60000 then "Medium salary"
           else "Low salary"
           end;
           
-- 3.Find department-wise salary category count
select
      department,
      case 
          when salary>=80000 then "High"
          when salary>=60000 then "Medium"
          else "Low"
          end as emp_salary,
          count(*) as employees_count
from employee_salary
group by department,
      case
      when salary>=80000 then "High"
      when salary>=60000 then "Medium"
      else "Low"
      end;

-- 4.Find employees who earn above department average
with dept_salary as (
select department ,avg(salary) as  avg_salary
from employee_salary
group by department)
SELECT
    e.emp_name,
    e.department,
    e.salary,
    d.avg_salary
FROM employee_salary e
JOIN dept_avg d
    ON e.department = d.department
WHERE e.salary > d.avg_salary;

-- 5.Find highest-paid employee in each department
with highest_salary as(
select emp_name,
	   salary,
       department,
       dense_rank()over(partition by department order by salary desc) as rnk
       from employee_salary
       )
       select * from highest_salary
       where rnk=1;
       
-- 6.Find employees whose salary is greater than ₹60,000 and classify them
select 
       emp_name,
       department,
       salary,
       case 
       when salary >=80000 then "Senior Salary"
       else 'Standard Salary'
	end as salary_level
from employee_salary
where salary>60000;

-- 7.Find department-wise total salary and classify department budget
WITH dept_salary AS (
    SELECT
        department,
        SUM(salary) AS total_salary
    FROM employee_salary
    GROUP BY department
)
SELECT
    department,
    total_salary,
    CASE
        WHEN total_salary >= 300000 THEN 'High Budget'
        WHEN total_salary >= 200000 THEN 'Medium Budget'
        ELSE 'Low Budget'
    END AS budget_category
FROM dept_salary;

-- 8.Find top 2 employees from each department
with top_salary as (
select 
      emp_name,
      salary,
      department,dense_Rank()over(partition by department order by salary desc) as rnk
      from employee_salary
      )
      select * from top_salary
      where rnk <=2;
      
-- 9.Find department-wise highest and lowest salary
select 
     department,
     max(salary) as highest_salary,
     min(salary) as lowest_salary,
     max(salary)-min(salary) as salary_range
from employee_salary
group by department;

-- 10.Find departments where salary range > ₹20,000
select 
    department,
    max(salary) as highest_salary,
    min(salary) as lowest_salary,
    max(salary)-min(salary) as salary_range
from employee_salary
group by department
having max(salary)-min(salary)>20000;

-- 11.Find previous employee salary
select
       emp_name,
       salary,lag(salary)over(order by emp_id) as previous_salary
       from employee_salary;

-- 12.Find running total salary
select 
      emp_name,
      salary,sum(salary)over(
      order by emp_id
      ) as running_salary
      from employee_salary;
      
-- 13.Find employee salary percentage within department
select 
     emp_name,
     department,
     salary,round(salary * 100.0/ sum(salary)over(PARTITION BY department),2) as salary_percentage
     from employee_salary;
     
-- 14.Find employees above company average salary
with company_avg_salary as(
select avg(salary) as avg_salary
from employee_salary
)
select
      e.emp_name,
      e.salary,
      c.avg_salary
from employee_salary e
cross join company_avg_salary c
where e.salary>c.avg_salary;

-- 15.Find the salary difference from department average
select 
      emp_name,
      salary,
      department,avg(salary)over(partition by department) as dept_avg,
      salary-avg(salary)over(partition by department) as salary_difference
from employee_salary;



     

      