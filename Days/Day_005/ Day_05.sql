-- Day 5 - SQL JOINs

CREATE TABLE departments1(
    department_id INT,
    department_name VARCHAR(50)
);

CREATE TABLE employees3(
    emp_id INT,
    emp_name VARCHAR(50),
    department_id INT,
    salary INT
);

INSERT INTO departments1 VALUES
(1, 'IT'),
(2, 'HR'),
(3, 'Sales'),
(4, 'Finance');

select * from departments1;
select * from employees3;

INSERT INTO employees3 VALUES
(101, 'Sandeep', 1, 60000),
(102, 'Ravi', 1, 55000),
(103, 'Priya', 2, 50000),
(104, 'Anil', 3, 45000),
(105, 'Kiran', 3, 48000),
(106, 'Manoj', 5, 40000);

-- Example 1 — INNER JOIN
-- Employees with their department names
SELECT e.emp_name,
       d.department_name
FROM employees3 e
INNER JOIN departments1 d
ON e.department_id = d.department_id;

-- Example 2 — Show employee + salary + department
select e.emp_name,e.salary,d.department_name
from employees3 e
inner join departments1 d
on e.department_id=d.department_id;

-- Example 3 — Employees working in IT
select e.emp_name,e.salary
from employees3 e
inner join departments1 d
on e.department_id=d.department_id
where d.department_name="IT";

-- Example 4 — Salary > 50,000 with department
select e.emp_name,e.salary,d.department_name
from employees3 e
inner join departments1 d
on e.department_id=d.department_id
where e.salary>50000;

-- Example 5 — LEFT JOIN
-- Show all departments, even if no employee exists:
select d.department_name,e.salary
from departments1 d
left join employees3 e
on d.department_id=e.department_id;

-- Example 6 — Departments without employees
select d.department_name
from  departments1 d
left join employees3 e
on d.department_id=d.department_id
where e.emp_id is null;

-- 7. Employee count by department
select d.department_name,count(e.emp_id) as employees_count
from departments1 d
left join employees3 e
on d.department_id=d.department_id
group by d.department_name;

-- Example 8 — Total salary by department
select d.department_name,sum(e.salary) as total_salary
from departments1 d
inner join employees3 e
on d.department_id=e.department_id
group by d.department_name;

-- Example 9 — Average salary by department
select d.department_name,avg(e.salary) as avg_salary
from departments1 d
inner join employees3 e
on d.department_id = e.department_id
group by d.department_name;

-- Example 10 — Departments with average salary > 50,000
SELECT d.department_name,
       AVG(e.salary) AS average_salary
FROM departments1 d
INNER JOIN employees3 e
ON d.department_id = e.department_id
GROUP BY d.department_name
HAVING AVG(e.salary) > 50000;