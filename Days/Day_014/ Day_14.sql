-- Day 14 – SQL LEFT JOIN

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

-- 1. Display all employees and their department names
select e.emp_name,d.department_name
from employees e
left join  departments d
on e.department_id=d.department_id;

-- 2. Display employee name, salary, and department
select e.emp_name,e.salary,d.department_name
from employees e
left join departments d
on e.department_id=d.department_id;

-- 3. Find employees who don't have a valid department
select e.emp_name,d.department_name
from employees e
left join departments d
on e.department_id=d.department_id
where e.department_id is null;

-- 4. Find employees earning more than 50,000
select e.emp_name,e.salary,d.department_name
from employees e
left join departments d
on e.department_id=d.department_id
where e.salary>50000;

-- 5. Display all employees sorted by salary
select e.emp_name,e.salary,d.department_name
from employees e
left join departments d
on e.department_id=d.department_id
order by e.salary desc;

-- 6. Count employees in each department
select d.department_name,count(e.emp_id) as employees
from departments d
left join employees e
on d.department_id=e.department_id
group by d.department_name;

-- 7. Find departments with no employees
select d.department_id,d.department_name
from  departments d
left join employees e
on d.department_id=e.department_id
where e.emp_id is null;

-- 8. Calculate average salary by department
select d.department_name,avg(e.salary) as avg_salary
from departments d
left join employees e
on d.department_id=e.department_id
group by d.department_name;

-- 9. Find the highest salary in each department
select d.department_name,max(e.salary) as max_salary
from departments d
left join employees e
on d.department_id=d.department_id
group by d.department_name;

-- 10. Find the lowest salary in each department
select d.department_name,min(e.salary) as min_salary
from departments d
left join employees e
on d.department_id=d.department_id
group by d.department_name;

-- 11. Find departments having more than 1 employee
select d.department_name,count(*) as employees
from departments d
left join employees e
on d.department_id=e.department_id
group by d.department_name
having employees>1;

-- 12. Display all employees with salary between 40,000 and 55,000
select e.emp_name,e.salary,d.department_name
from employees e
left join departments d
on d.department_id=e.department_id
where e.salary between 40000 and 55000;

-- 13. Replace NULL department with 'Not Assigned'
select e.emp_name,e.salary,coalesce(d.department_name,"Not Assined")as department
from employees e
left join departments d
on e.department_id=d.department_id;

-- 14. Find employees belonging to Data Analytics
select e.emp_id,e.emp_name,d.department_name
from employees e
left join departments d
on e.department_id=d.department_id
where d.department_name="Data Analytics";

-- 15. Find all employees and show whether their department exists
SELECT 
    e.emp_name,
    e.department_id,
    CASE
        WHEN d.department_id IS NULL THEN 'Invalid Department'
        ELSE 'Valid Department'
    END AS department_status
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id;


