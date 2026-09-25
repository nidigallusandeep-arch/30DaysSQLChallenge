-- Day 28 — SQL Real-Time Case Studies

CREATE DATABASE day27_db;

USE day27_db;

CREATE TABLE employees (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(30),
    salary INT,
    city VARCHAR(30),
    age INT,
    joining_date DATE
);

INSERT INTO employees
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
    
    select * from employees;
    
-- Q1.Display employees earning more than ₹60,000.
select * from employees
where salary>60000;

-- Q2.Find employees working in the IT department.
select * from employees
where department="IT";

-- Q3.Find the second-highest salary in the company.
select max(salary)
from employees
where salary<(
select max(salary)
from employees);

-- Q4.Calculate the average salary of each department.
select department,avg(salary) as avg_salary
from employees
group by department;

-- Q5.Find departments with an average salary above ₹60,000.
select department,avg(salary) as avg_salary
from employees
group by department
having avg_salary>60000;

-- Q6.Find the highest-paid employee in each department.
select department,max(salary) as highest_paid
from employees
group by department;

-- Q7.Find the top 2 distinct salaries in each department.
with ranked_salary as (
select emp_name,
       department,
       salary,dense_rank()over(partition by department order by salary desc) as rnk
       from employees
       )
       select 
            emp_name,
            emp_name,
            salary
	from ranked_salary
    where rnk<=2
    order by department,salary desc;
    
-- Q8. Employees earning above their department's average salary
select 
     emp_name,
     department,
     salary
from employees e
where salary>(
select avg(salary)
from employees
where department=e.department);

-- Q9. Count employees in each city
select city,count(*) as employees_count
from employees
group by city
order by employees_count desc;

-- Q10. Employees who joined after January 1, 2022
select 
       emp_id,
       emp_name,
       salary,
       department,
       joining_date
from employees
where joining_date>"2022-01-01";

-- Q11. Total salary expenditure for each department
select department,sum(salary) as total_salary
from employees
group by department
order by total_salary desc;

-- Q12. Categorize employees into High, Medium and Low salary groups
-- - Let's use:
-- >= 80000 → High
-- >= 60000 → Medium
-- < 60000 → Low

select emp_name,salary,
  case 
       when salary>=80000 then "High"
       when salary>=60000 then "Medium"
       else "Low"
       end as salary_category
       from employees;
       
-- Q13. Rank employees within each department using DENSE_RANK()
select emp_name,
	   salary,
       department,dense_rank()over(partition by department order by salary desc) as rnk
       from employees;
       
-- Q14. Running total of salaries within each department
select emp_name,
       salary,
       department,sum(salary)over(partition by department) as running_total
       from employees;
       
-- Q15. Salary difference from previous employee using LAG()
select 
       emp_name,
       salary,
       department,lag(salary)over(order by salary)as previous_salary,
       salary-lag(salary)over(order by salary) as salary_difference
       from employees;