-- Day 7 — CTE (Common Table Expressions)

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

-- 1. Create table
select * from employees6;

-- 2. Basic CTE
WITH employee_data AS (
    SELECT
        emp_id,
        emp_name,
        department,
        salary
    FROM employees6
)
SELECT *
FROM employee_data;

-- 3. Employees with salary > 60000
with emp_salary as(
select * from employees6
where salary>60000
)
select * from emp_salary;

-- 4. Average salary
with avg_salary as(
select avg(salary)as salary_avg
from employees3
)
select * from avg_salary;

-- 5. Employees earning more than average
with salary_avg as(
select avg(salary) as avg_salary
from employees6
)
select emp_id,
       emp_name,
       department,
       salary
from employees6
where salary>(
select avg_salary
from salary_avg
);

-- 6. Department-wise average salary
with dept_avg as(
select department,avg(salary) as avg_salary
from employees6
group by department
)
select * from dept_avg;

-- 7. Departments with average salary > 60000
with department_avg as(
select department,avg(salary) as avg_salary
from employees6
group by department
)
select * from department_avg 
where avg_salary>60000;

-- 8. Highest salary
with highest_Salary as(
select max(salary)
from employees6
)
select * from highest_salary;

-- 9. Employee with highest salary
with highest_salary as(
select max(salary) as max_salary
from employees6
)
select emp_id,emp_name,department,salary
from employees6
where salary=(
select max_salary
from highest_salary);

-- 10. Second highest salary
with salary_data as(
select distinct salary
from employees6
)
select max(salary) as second_highest_salary
from salary_data
where salary <(
select max(salary)
from  employees6
);

-- 11. Department employee count
with department_count as(
select department,count(*) as employees_count
from employees6
group by department
)
select * from department_count
order by employees_count desc;

-- 12. Departments having more than 2 employees
with depatment_count as (
select department,count(*) as employees_count
from employees6
group by department
)
select * from depatment_count
where employees_count>2;

-- 13. Multiple CTEs
with department_avg as(
select department,avg(salary)as avg_salary
from employees6
group by department
),
highe_salary_department as(
select department,avg_salary
from department_avg
where avg_salary>60000
)
select * from highe_salary_department;

-- 14. CTE + JOIN
WITH department_avg AS (
    SELECT
        department,
        AVG(salary) AS avg_salary
    FROM employees6
    GROUP BY department
)
SELECT
    e.emp_name,
    e.department,
    e.salary,
    d.avg_salary
FROM employees6 e
JOIN department_avg d
    ON e.department = d.department;
    
-- 15. Employees earning more than their department average
WITH department_avg AS (
    SELECT
        department,
        AVG(salary) AS avg_salary
    FROM employees6
    GROUP BY department
)
SELECT
    e.emp_id,
    e.emp_name,
    e.department,
    e.salary,
    d.avg_salary
FROM employees6 e
JOIN department_avg d
    ON e.department = d.department
WHERE e.salary > d.avg_salary;


