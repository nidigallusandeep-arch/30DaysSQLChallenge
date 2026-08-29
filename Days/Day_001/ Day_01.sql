--  Day 1 – SQL Problem Solving Challenge
-- What is a Table?
--  A table stores data in rows and columns.

-- Create employees Table
create database employees;
use employees;

CREATE TABLE employees1(
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    age INT,
    city VARCHAR(50)
);

INSERT INTO employees1 (emp_id, emp_name, department, salary, age, city)
VALUES
(1, 'Sandeep', 'IT', 60000, 25, 'Hyderabad'),
(2, 'Rahul', 'HR', 45000, 28, 'Bangalore'),
(3, 'Priya', 'IT', 75000, 30, 'Hyderabad'),
(4, 'Anjali', 'Finance', 55000, 27, 'Chennai'),
(5, 'Kiran', 'IT', 50000, 26, 'Hyderabad'),
(6, 'Ravi', 'HR', 40000, 32, 'Mumbai'),
(7, 'Sneha', 'Finance', 80000, 29, 'Bangalore'),
(8, 'Arjun', 'IT', 65000, 24, 'Pune'),
(9, 'Divya', 'Marketing', 48000, 31, 'Chennai'),
(10, 'Vijay', 'Marketing', 52000, 28, 'Hyderabad');


-- 1.Display all employees.
select * from employees1;

-- 2.Display only the emp_name and salary of all employees.
select emp_name,salary
from employees1;

-- 3.Find employees whose salary is greater than 50000.
select * from employees1
where salary>50000;

-- 4.Find all employees working in the IT department.
select * from employees1
where department="IT";

-- 5.Find employees whose age is greater than or equal to 28.
select * from employees1
where age>=28;

-- 6.Find employees who live in Hyderabad.
select * from employees1
where city ="hyderabad";

-- 7.Find employees whose salary is between 50000 and 70000.
select * from employees1
where salary between 50000 and 70000;

-- 8.Find employees who work in either IT or HR.
select * from employees1
where department in("IT","HR");

-- 9.Display all employees sorted by salary from highest to lowest.
select * from employees1
order by salary desc;

-- 10.Display the top 3 highest-paid employees.
select * from employees1
order by salary desc
limit 3;

-- 11.Find employees whose salary is less than 50,000.
select * from employees1
where salary<50000;

-- 12.Find employees who are from Hyderabad and whose salary is greater than 50,000.
select * from employees1
where department ="Hyderabad" and salary>50000;

-- 13.Find employees who are not working in the IT department.
select * from employees1
where department!="IT";

-- 14.Display employee names and salaries, sorted by salary from lowest to highest.
select emp_name,salary
from employees1
order by salary desc;








