-- Day 6 — SQL Subqueries

-- 1. Create Employees table
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
select * from employees6;

-- 1. Employees earning more than average salary
select * from employees6
where salary >(
select avg(salary)
from employees6
);

-- 2. Employee with highest salary
select * from employees6
where salary =(
select max(salary)
from employees6
);

-- 3. Employee with lowest salary
select * from employees6
where salary=(
select min(salary)
from employees6
);

-- 4. Second highest salary
select max(salary)
from employees6
where salary <(
select max(salary)
from employees6
);

-- 5. Employees earning more than Sandeep
select * from employees6
where salary>(
select salary
from employees6
where emp_name="sandeep"
);

-- 6. Employees earning less than Priya
select * from employees6
where salary <(
select salary
from employees6
where emp_name="priya"
);

-- 7. Employees working in the same department as Priya
select * from employees6
where department=(
select department
from employees6
where emp_name="priya"
);

-- 8. Employees with salary equal to IT department's maximum salary
select * from employees6
where salary=(
select max(salary)
from employees6
where department="IT"
);

-- 9. Employees with salary greater than IT average salary
select * from employees6
where salary>(
select avg(salary)
from employees6
where department="IT"
);

-- 10. Employees with experience greater than average experience
select * from employees6
where experience>(
select avg(experience)
from employees6
);

-- 11. Employees belonging to departments having salary > 80000
select * from employees6
where department in(
select department
from employees6
where salary>60000
);

-- 12. Employees whose salary is above Finance average
select * from employees6
where salary>(
select avg(salary)
from employees6
where department="Finace"
);

-- 13. Highest-paid employee in IT
select * from employees6
where department="IT"
and salary=(
select max(salary)
from employees6
where department ="IT"
);

-- 14. Employees whose salary is greater than all HR employees
select * from employees6
where salary >all(
select salary
from employees6
where department="HR"
);

-- 15. Employees whose salary is greater than at least one HR employee
select * from employees6
where salary>any(
select salary
from employees6
where department="HR"
);