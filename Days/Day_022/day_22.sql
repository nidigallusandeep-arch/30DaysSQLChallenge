-- SQL Day_22, CTE is an important interview topic.
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

-- 1 Find employees whose salary is greater than ₹60,000.
with employee_salary as(
select * from employees_da19
where salary>60000
)
select * from employees_day19;

-- 2.Find department-wise average salary.
with dept_avg_salary as(
select department,avg(salary) as avg_salary
from employees_day19
group by department
)
select * from  dept_avg_salary;

-- 3.Find departments where average salary is greater than ₹60,000.
with deprtmenmt_avg_salary as (
select  department,avg(salary) avg_salary
from employees_day19
group by department
)
select * from deprtmenmt_avg_salary
where avg_salary>60000;

-- 4.Find departments having more than 4 employees.
with dept_count as(
select department,count(*) as count_employee
from employees_day19
group by department
)
select * from dept_count
where count_employee>4;

-- 5.Find the highest salary in each department.
with highest_salary as (
select department,max(salary)as max_salary
from employees_day19
group by department
)
select * from highest_salary;

-- 6.Find the highest-paid employee in each department.
with rank_employees as(
select 
      emp_name,
      department,
      salary,
      rank()over(partition by department order by salary desc) as rnk
      from employees_day19
      )
      select emp_name,
             department,
             salary
             from rank_employees
             where rnk=1;
             
-- 7.If you want exactly one employee from each department:
with rank_employees as (
select    
      emp_name,
      department,
      salary,
      row_number()over(partition by department order by salary desc) as row_num
      from employees_day19
      )
      select emp_name,
			department,
            salary
            from rank_employees
            where row_num=1;


-- 8.Compare each department's average salary with the company average salary.
with dept_avg  as (
select department,avg(salary) avg_salary
from employees_day19
group by department
),
company_avg as(
select avg(salary) as overall_avg
from employees_day19
)
select d.department,
       d.avg_salary,
       c.overall_avg
       from dept_avg d
       cross join company_avg c;


-- 9.Show each employee along with their department's average salary.
with dept_avg as(
select department,avg(salary) as avg_salary
from employees_day19
group by department
)
select 
	e.emp_name,
    e.department,
    e.salary,
    d.avg_salary
from employees_day19 e
join dept_avg d
on e.department=d.department;

-- 10.Find employees who earn more than their department's average salary.
with dept_avg as(
select department,avg(salary) as avg_salary
from employees_day19
group by department
)
select e.emp_name,
       e.department,
       e.salary,
       d.avg_salary
from employees_day19 e
join dept_avg d
on e.department=d.department
where e.salary>d.avg_salary;


-- Find departments having more than 4 employees
with dept_count as(
select department,count(*) as employees_count
from employees_day19
group by department
)
select department,
        employees_count
        from dept_count
        where employees_count>4;
        
-- Find second-highest salary in each department
with second_highest_salary as (
select  
       emp_name,
       department,
       salary,
       dense_Rank()over(partition by department order by salary desc) as rnk
       from employees_day19
       )
       select emp_name,
			  department,
              salary
              from second_highest_salary
              where rnk=2;
-- Find top 2 employees in each department
with top_employees as (
select emp_name,
       department,
       salary,dense_rank()over(partition by department order by salary ) as top
       from employees_day19
       )
       select emp_name,
               department,
               salary
               from top_employees
               where top<=2;