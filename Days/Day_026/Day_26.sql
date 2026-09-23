-- Day 26 – Advanced SQL Business Problems
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

-- 1.Employees who joined after 2022
select * from employee_salary
where joining_date>="2022-01-01";

-- 2.Calculate employee experience
select emp_name,
       joining_date,
       datediff(CURDATE(),joining_date)as experience_days
from employee_salary;

-- 3.Find joining year
select
       emp_name,
       joining_date,
       year(joining_date) as joining_year
       from employee_salary;
       
-- 4Count employees by joining year
select joining_date,count(*) as joining_year
from employee_salary
group by joining_date
order by joining_date;

-- 5.Salary category
select emp_name,
       salary,
       case
            when salary>=80000 then "High"
            when salary>60000 then "medium"
            else "Low"
		end as salary_category
        from employee_salary;
        
-- 6 Department-wise salary category count
select department,
 case
     when salary >=80000 then "High"
     when salary >=60000 then "Medium"
     else "Low"
	end as salary_category,
    count(*) as employee_count
    
from employee_salary
group by  department,
case
     when salary>=80000 then "High"
     when salary>=60000 then "Medium"
     else "Low"
	end;
    
-- 7.Highest salary employee in each department
with highest_salary as (
select 
     emp_name,
     salary,
     department,rank()over(partition by department order by salary desc) as rnk
     from employee_salary
     )
     select 
         emp_name,
         salary,
         department
         from highest_salary
         where rnk=1;
         
-- 8.Second highest salary in each department
with second_higest_salary as(
select 
       emp_name,
       salary,
       department,
       dense_rank()over(partition by department order by salary desc
       ) as rnk
       from employee_salary
       )
       select 
             emp_name,
             salary,
             department
             from second_higest_salary
             where rnk=2;
             

-- 9Employees earning above department average
WITH dept_avg AS (
    SELECT
        department,
        AVG(salary) AS avg_salary
    FROM employee_salary
    GROUP BY department
)
SELECT
    e.emp_name,
    e.department,
    e.salary,
    d.avg_salary
FROM employee_salary e
JOIN dept_avg d
    ON e.department = d.department
WHERE e.salary > d.avg_salary;

-- 10.Salary difference from previous employee
select 
      emp_name,
      department,
      salary-lag(salary)over(order by emp_id)as salary_difference
      from employee_salary;
      
-- 11 Department-wise salary difference
select 
      emp_name,
      department,
      salary-lag(salary)over(partition by department order by salary)as salary_differece
      from employee_salary;
      
-- 12.Running salary total
select 
     emp_name,
     salary,sum(salary)over(order by emp_id) as running_salary
     from employee_salary;
     
-- 13.Department running total
select 
      emp_name,
      department,
      salary,sum(salary)over(partition by department order by salary) as running_salary
      from employee_salary;
      

-- Salary percentage of department
SELECT
    emp_name,
    department,
    salary,
    ROUND(
        salary * 100.0 /
        SUM(salary) OVER (PARTITION BY department),
        2
    ) AS salary_percentage
FROM employee_salary;

-- 15.Find the top 2 highest-paid employees from each department who joined after 2020.
with filtered_employees as(
select 
      emp_name,
      department,
      salary,
      joining_date
from employee_salary
where joining_date>"2020-01-01"
),
ranked_employees as (
select 
        emp_name,
        department,
        salary,
        joining_date,dense_Rank()over(partition by department order by salary desc)as rnk
        from filtered_employees
)
select
       emp_name,
       department,
       salary,
       joining_date
from ranked_employees
where rnk<=2
order by department,salary desc;