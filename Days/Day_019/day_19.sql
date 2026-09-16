-- SQL Day_19 Plan — Advanced SQL
use std;

CREATE TABLE employees_day19 (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(30),
    salary INT,
    city VARCHAR(30),
    age INT,
    joining_date DATE
);

INSERT INTO employees_day19
(emp_id, emp_name, department, salary, city, age, joining_date)
VALUES
(1, 'Ravi', 'IT', 55000, 'Hyderabad', 25, '2022-06-15'),
(2, 'Suresh', 'IT', 70000, 'Bangalore', 28, '2021-03-20'),
(3, 'Priya', 'HR', 45000, 'Hyderabad', 26, '2023-01-10'),
(4, 'Anjali', 'HR', 60000, 'Chennai', 29, '2020-11-05'),
(5, 'Kiran', 'Finance', 75000, 'Mumbai', 31, '2019-08-12'),
(6, 'Rahul', 'IT', 70000, 'Hyderabad', 27, '2022-09-18'),
(7, 'Sneha', 'Finance', 65000, 'Bangalore', 25, '2021-07-22'),
(8, 'Arjun', 'IT', 85000, 'Chennai', 32, '2018-04-15'),
(9, 'Divya', 'HR', 50000, 'Hyderabad', 24, '2023-05-19'),
(10, 'Vijay', 'Finance', 75000, 'Mumbai', 30, '2020-02-25'),
(11, 'Manoj', 'IT', 60000, 'Bangalore', 26, '2022-12-01'),
(12, 'Swathi', 'HR', 65000, 'Chennai', 28, '2021-10-11'),
(13, 'Naveen', 'Finance', 55000, 'Hyderabad', 27, '2023-02-14'),
(14, 'Pooja', 'IT', 90000, 'Mumbai', 33, '2017-06-30'),
(15, 'Vamsi', 'HR', 60000, 'Bangalore', 29, '2020-09-17');

select * from employees_day19;

-- 1. Find all IT employees
select * from employees_day19
where department="IT";

-- 2. Find employees with salary greater than 60,000
select emp_name,salary
from employees_day19
where salary>60000;

-- 3. Find the highest salary
select max(salary) as highest_salary
from employees_day19;

-- 4. Find the second-highest salary
select max(salary) as second_highest_salary
from employees_day19
where salary<(
select max(salary) 
from employees_day19);

-- 5. Find average salary of each department
select department,avg(salary) as avg_salary
from employees_day19
group by department;

-- 6. Find departments having average salary > 60,000
select department,avg(salary) as avg_salary
from employees_day19
group by department
having avg_salary>60000;

-- 7. Rank employees based on salary
select emp_name,
       salary,
       department,rank()over(order by salary desc) as rnk
       from employees_day19;
       
-- 8. Rank employees within each department
select emp_name,
	   salary,
       department,rank()over(partition by department order by salary desc) as rnk
       from employees_day19;
       
-- 9. Find top 2 employees from each department
WITH ranked_employees AS (
select emp_name,
       salary,
       department,rank()over(partition by department order by salary desc) as rnk
       from employees_day19
       )
select * from ranked_employees
where rnk <=2;

-- 10. Find duplicate salaries
select salary,count(*) as employee_count
from employees_day19
group by salary
having employee_count>1;

-- 11. Use ROW_NUMBER()
select emp_name,
       salary,
       department,row_number()over(order by salary desc) as rnk
       from employees_day19;
       
-- 12. Use DENSE_RANK()
select emp_name,
       salary, 
       department,
       dense_rank()over(order by salary desc
       ) as rnk
from employees_day19;

-- 13. Find previous employee salary using LAG()
select emp_name,
       salary,
       lag(salary)over(order by emp_id) as lg
from employees_day19;

-- 14. Find next employee salary using LEAD()
select emp_name,
       salary,
       lead(salary)over(order by emp_id
       ) as led
from employees_day19;

-- 15. Find employees earning more than their department average
select emp_name,department,salary
from employees_day19 e
where salary >(
select avg(salary) 
from employees_day19
where department=e.department);       


