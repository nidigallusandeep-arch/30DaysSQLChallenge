-- SQL Day_21 = GROUP BY + HAVING + Real Business Problems.
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

-- 1.How many employees are in each department?
select department,count(*) as employees
from employees_day19
group by department;

-- 2.What is the average salary in each department?
select department,avg(salary) as avg_salary
from employees_day19
group by department;

-- 3.What is the total salary expense for each department?
select department,sum(salary) as total_salary
from employees_day19
group by department;

-- 4.Which departments have more than 4 employees?
select department,count(*) as employees
from employees_day19
group by department
having employees>4;

-- 5 Which departments have an average salary above ₹60,000?
select department,avg(salary) as avg_salary
from employees_day19
group by department
having avg_salary>60000;

-- 6.What is the highest salary in each department?
select department,max(salary) as max_salary
from employees_day19
group by department;

-- 7.What is the lowest salary in each department?
select department,min(salary) as lowest_salary
from employees_day19
group by department;

-- 8.How many employees are working in each city?
select city,count(*) as employees
from employees_day19
group by city;

-- 9.Which cities have more than 3 employees?
select city,count(*) as employees
from employees_day19
group by city
having employees>3;

-- 10 Which departments have total salary expense greater than ₹3,00,000?
select department,sum(salary) as total_salary
from employees_day19
group by department
having total_salary>300000;

-- 11 Find departments where the highest salary is greater than ₹80,000
select department,max(salary) as highest_salary
from employees_day19
group by department
having highest_salary>80000;

-- 12.Find departments where the lowest salary is at least ₹55,000
select department,min(salary) as lowest_salary
from employees_day19
group by department
having lowest_salary<55000;

-- 13.Find departments with at least 5 employees and average salary above ₹60,000
select department,count(*) as employees,
AVG(salary) AS average_salary
from employees_day19
group by department
having count(*)>=5 and avg(salary)>50000;

-- 14.Find city-wise average salary and show only cities with average salary above ₹60,000
select city,avg(salary) as avg_salary
from employees_day19
group by city
having avg_salary>60000;

-- 15 Find departments where salary range is greater than ₹20,000
select department,
                 max(salary) as highest_salary,
                 min(salary) as lowest_salary,
                 max(salary) - min(salary) as salary_range
                 from employees_day19
                 group by department
                 having max(salary) -min(salary)>20000;