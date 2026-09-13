
-- Day 16 – SQL FULL OUTER JOIN
-- FULL OUTER JOIN returns all rows from both tables, with matching rows combined and unmatched rows filled with NULLs.

-- MySQL does not directly support FULL OUTER JOIN.
-- In MySQL, we usually achieve it using LEFT JOIN + RIGHT JOIN + UNION.

use inner_;

select * from employees;
select * from departments;

-- 1. Display all employees and departments
select e.emp_name,d.department_name
from employees e
left join departments d
on e.department_id=d.department_id
union 
select e.emp_name,d.department_name
from employees e
right join departments d
on e.department_id=d.department_id;

-- 2. Display employee ID and department ID
select e.emp_id,d.department_id
from employees e
left join departments d
on e.department_id=d.department_id

union

select e.emp_id,d.department_id
from employees e
left join departments d
on e.department_id=d.department_id;

-- 3. Display employee name, salary and department
select e.emp_id,emp_name,d.department_name
from employees e
left join departments d
on e.department_id=d.department_id

union

select e.emp_id,emp_name,d.department_name
from employees e
right join departments d
on e.department_id=d.department_id;

-- 4. Find unmatched employees
select e.emp_name,d.department_name
from employees e
left join departments d
on e.department_id=d.department_id
where d.department_id is null;

-- 5. Find unmatched departments
select e.emp_name,d.department_name
from employees e
right join departments d
on e.department_id=d.department_id
where e.emp_id is null;

-- 6. Find all unmatched records
select e.emp_name,d.department_name
from employees e
left join departments d
on e.department_id=d.department_id
where d.department_id is null

union

select e.emp_name, d.department_name
from employees e 
right join departments d
on e.department_id=d.department_id
where e.emp_id is null;


-- 7. Display all records with salary
select e.emp_name,e.salary,d.department_name
from employees e
left join departments d
on e.department_id=d.department_id

union

select e.emp_name,e.salary,d.department_name
from employees e
right join departments d
on e.department_id=d.department_id;

-- 8. Count employees for each department
select d.department_name,count(*) as employees_count
from departments d
left join employees e
on e.department_id=d.department_id
group by d.department_name;

-- 9. Find departments with no employees
select d.department_name
from departments d
left join employees e
on e.department_id=d.department_id
where e.emp_id is null;

-- 10. Find employees with no department
select e.emp_name
from employees e
left join departments d
on e.department_id=d.department_id
where d.department_id is null;

-- 11. Show matching and unmatched records
SELECT
    e.emp_name,
    d.department_name,
    CASE
        WHEN e.emp_id IS NULL THEN 'Department Only'
        WHEN d.department_id IS NULL THEN 'Employee Only'
        ELSE 'Matched'
    END AS record_status
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id

UNION

SELECT
    e.emp_name,
    d.department_name,
    'Department Only' AS record_status
FROM employees e
RIGHT JOIN departments d
ON e.department_id = d.department_id
WHERE e.emp_id IS NULL;

-- 12. Find average salary by department
select d.department_name,avg(e.salary) as avg_salary
from employees e
left join departments d
on e.department_id=d.department_id
group by d.department_name;

-- 13. Find highest salary by department
select d.department_name,max(e.salary) as max_salary
from employees e
left join departments d
on d.department_id=d.department_id
group by d.department_name;

-- 14. Replace NULL values
SELECT
    COALESCE(e.emp_name, 'No Employee') AS employee_name,
    COALESCE(d.department_name, 'No Department') AS department_name
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.department_id

UNION

SELECT
    COALESCE(e.emp_name, 'No Employee') AS employee_name,
    COALESCE(d.department_name, 'No Department') AS department_name
FROM employees e
RIGHT JOIN departments d
ON e.department_id = d.department_id;

-- 15.Find records that exist in only one table
select e.emp_name,d.department_name
from employees e
left join departments d
on e.department_id=d.department_id
where d.department_id is null

union 

select e.emp_name,d.department_name
from employees e
right join departments d
on e.department_id=d.department_id
where e.emp_id is null;