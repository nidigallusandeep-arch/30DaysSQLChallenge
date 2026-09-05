-- Day 8 — Window Functions
 
 -- Main topics:-
-- ROW_NUMBER()
-- RANK()
-- DENSE_RANK()
-- LAG()
-- LEAD()
-- SUM() OVER()
-- AVG() OVER()
-- PARTITION BY
-- ORDER BY


CREATE TABLE employees6 (
    emp_id INT,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    experience INT
);

-- 2. Insert data
INSERT INTO employees6 VALUES
(1, 'Sandeep', 'IT', 60000, 3),
(2, 'Rahul', 'HR', 45000, 2),
(3, 'Priya', 'IT', 75000, 5),
(4, 'Anil', 'Finance', 55000, 4),
(5, 'Sneha', 'HR', 50000, 3),
(6, 'Kiran', 'IT', 90000, 7),
(7, 'Meena', 'Finance', 65000, 6),
(8, 'Arjun', 'Sales', 40000, 1),
(9, 'Divya', 'Sales', 70000, 5),
(10, 'Vijay', 'IT', 80000, 6);

-- 1. Create table
select * from employees6;

-- 1. Find the highest-paid employee
select emp_id,
       emp_name,
       department,
       salary from(
select *,rank()over(order by salary desc) as rnk
from employees6
)y
where rnk=1;

-- 2. Find the second-highest salary
select emp_id,emp_name,salary,department from(
select *,dense_rank()over(order by salary desc) as rnk
from employees6
)y
where rnk=2;

-- 3. Find the Nth highest salary
select emp_name,salary,department from(
select*,dense_rank()over(order by salary desc) as n_highest
from employees6
)y
where n_highest<=3;

-- 4. Rank employees by salary
select emp_id,
       emp_name,
       department
       salary,rank()over(order by salary desc) as rnk
       from employees6;
       
-- 5. Find top 3 employees from each department
select * from (
select emp_id,
       emp_name,
       department,
       salary,row_number()over(partition by department order by salary desc) as top
       from employees6
       )y
       where top<=3;
       
-- 6. Find highest-paid employee in each department
select * from (
select emp_name,
       department,
       salary,
       row_number()over(partition by department order by salary desc) as highest_salary
       from employees6
       )y
       where highest_salary=1;
       
-- 7. Find employees earning more than department average 
select * from (
select emp_id,emp_name,
	   department,
       salary,
       avg(salary)over(partition by department) as avg_dept
       from employees6
       )y
       where salary>avg_dept;

-- 8. Calculate salary difference from department average
select emp_name,
       department,
       salary,avg(salary)over(partition by department)as avg_salary,
	   salary - avg(salary)over(partition by department) as salary_difference
	   from employees6;
       
-- 9. Calculate department total salary
select emp_id,
       emp_name,
       department,
       salary,sum(salary)over(partition by department) as department_total
       from employees6;
       
-- 10. Calculate running total of salary
select emp_id,
       emp_name,
       department,sum(salary)over(order by emp_id) as running_total
       from employees6;
       
       
-- 11. Find previous employee salary using LAG()
select emp_id,
       emp_name,
       department,
       salary,lag(salary)over(order by emp_id)as prevoues_salary
       from employees6;
       
-- 12. Find next employee salary using LEAD()
select emp_id,
       emp_name,
       department,
       salary,lead(salary)over(order by emp_id) as next_salary
       from employees6;
	
-- 13. Find salary increase/decrease compared with previous employee
select emp_id,
       emp_name,
       department,
       salary,lag(salary)over(order by emp_id)as previous_salary,salary - lag(salary)over(order by emp_id)salary_change
       from employees6;
       
-- 14. Find duplicate salaries
select emp_id,
       emp_name,
       salary
from (
select *,count(*)over(partition by salary) as salary_count
from employees6
)y
where salary_count>1;

-- 15. Find employees with the same salary within department
select emp_id,
       emp_name,
       department,
       salary
from(
select *,count(*)over(partition by department,salary) as cnt
from employees6
)y
where cnt>1;

