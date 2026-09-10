-- Day 13 – SQL INNER JOIN
create database inner_;
use inner_;

-- Employee Table

CREATE TABLE employees (
    emp_id INT,
    emp_name VARCHAR(50),
    department_id INT,
    salary INT
);

INSERT INTO employees VALUES
(1, 'Sandeep', 101, 50000),
(2, 'Rahul', 102, 60000),
(3, 'Priya', 101, 55000),
(4, 'Anil', 103, 45000),
(5, 'Kiran', 105, 40000);
select * from employees;

-- Department Table
CREATE TABLE departments (
    department_id INT,
    department_name VARCHAR(50)
);

INSERT INTO departments VALUES
(101, 'Data Analytics'),
(102, 'HR'),
(103, 'Finance'),
(104, 'Marketing');

select * from departments;


-- 1. Display employee name and department name
select e.emp_name,d.department_name
from employees e
inner join departments d
on e.department_id=d.department_id;

-- 2. Employees with salary greater than 45,000
select e.emp_name,e.salary,d.department_name
from employees e
inner join departments d
on e.department_id=d.department_id
where e.salary=45000;

-- 3. Find employees working in HR
select e.emp_name,d.department_name
from employees e
inner join departments d
on e.department_id=d.department_id
where d.department_name="HR";

-- 4. Find employees working in Data Analytics
select e.emp_name,d.department_name
from employees e
inner join departments d
on e.department_id=d.department_id
where d.department_name="Data Analytics";

-- 6. Find average salary by department
select d.department_name,avg(e.salary) as avg_salary
from employees e
inner join departments d
on d.department_id=d.department_id
group by d.department_name;

-- 7. Find maximum salary in each department
select d.department_name,max(e.salary) as max_salary
from employees e
inner join departments d
on e.department_id=d.department_id
group by d.department_name;

-- 8. Find minimum salary in each department
select d.department_name,min(e.salary) as min_salary
from employees e
inner join departments d
on d.department_id=e.department_id
group by d.department_name;

-- 9. Departments where average salary > 50,000
select d.department_name,avg(e.salary) as avg_salary
from employees e
inner join departments d
on d.department_id=e.department_id
group by d.department_name
having avg_salary>50000;

-- 10. Find highest-paid employee with department
select e.emp_name,e.salary,d.department_name
from employees e
inner join departments d
on e.department_id=d.department_id 
where e.salary<(
select max(salary) 
from employees);



