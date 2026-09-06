-- SQL CTE — 15 Interview-Level Questions
-- day_9

CREATE TABLE employees6 (
    emp_id INT,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    salary INT,
    experience INT
);
select * from employees6;

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

-- 1.Create a CTE to find employees whose salary is greater than 60000.
with emp_salary as(
select * from employees6
where salary>60000
)
select * from emp_salary;

-- 2 Create a CTE that contains only IT employees.
with dept_emp as(
select * from employees6
where department="IT"
)
select * from dept_emp;

-- 3Create a CTE for employees having more than 4 years of experience.
with experience as(
select * from employees6
where experience>4
)
select * from experience;

-- Q4. Employees Above Average Salary
WITH avg_salary AS (
    SELECT AVG(salary) AS avg_sal
    FROM employees6
)
SELECT e.emp_name, e.salary
FROM employees6 e
CROSS JOIN avg_salary a
WHERE e.salary > a.avg_sal;

-- Q5. Average Salary by Department
with avg_salary as(
select department,avg(salary) as dept_avg
from employees6
group by department
)
select * from avg_salary;

-- Q6. Highest Salary
WITH highest_salary AS (
    SELECT MAX(salary) AS max_salary
    FROM employees6
)
SELECT e.emp_name, e.salary
FROM employees6 e
JOIN highest_salary h
    ON e.salary = h.max_salary;
    
    -- Q7. Second Highest Salary
    with salary_rank as(
    select emp_name,
           salary,dense_rank()over(order by salary desc) as rnk
           from employees6
           )
           select * from salary_rank
           where rnk=2;
           
-- Q8. Employee Count by Department
with emp_count as(
select department,count(*) as employees_count
from employees6
group by department
)
select * from emp_count;

-- Q9. Departments with Average Salary > 60,000
with departemt_avg as(
select department,avg(salary) as avg_salary
from employees6
group by department
)
select * from departemt_avg
where avg_salary>60000;

-- Q10. Employees Above Department Average
WITH dept_avg AS (
    SELECT
        department,
        AVG(salary) AS avg_salary
    FROM employees6
    GROUP BY department
)
SELECT
    e.emp_name,
    e.department,
    e.salary
FROM employees6 e
JOIN dept_avg d
    ON e.department = d.department
WHERE e.salary > d.avg_salary;

-- Q11. Highest Paid Employee in Each Department
with rank_salary as(
select *,dense_rank()over(partition by department order by salary desc) as highest_salary
from employees6
)
select* from rank_salary
where highest_salary=1;

-- Q12. Rank Employees by Salary
with rank_salary as (
select emp_name,
       salary,rank()over(order by salary desc) as rnk
        from employees6
        )
        select * from rank_salary;
        
-- Q13. Top 3 Highest Paid Employees
with ranked_salary as (
select *,dense_rank()over(order by salary desc) as highest
from employees6
)
select * from ranked_salary
where highest<=3;

-- Q14. Second Highest Salary in Each Department
with  second_highest as (
select emp_name,
       department,
       salary,dense_rank()over(partition by department order by salary desc) as rnk
       from employees6
       )
       select * from second_highest
       where rnk=2;
       
       
-- Q15. Above Department Average + Experience > 3
with dept_avg as(
select department,avg(salary) as avg_salary
from employees6
group by department
)
select e.emp_name,
       e.department,
       e.salary,
       e.experience
from employees6 e
join dept_avg d
on e.department=d.department
where e.salary>d.avg_salary
and  e.experience>3;
