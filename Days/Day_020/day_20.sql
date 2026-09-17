-- SQL Day_20 15 Interview Questions
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

-- 1 Employees earning more than overall average salary
select emp_name,salary
from employees_day19
where salary>(
select avg(salary)
from employees_day19);

-- Employees earning more than their department average
select emp_name,department,salary
from employees_day19 e
where salary>(
select avg(salary)
from employees_day19
where department=e.department
);

-- 3,Highest-paid employee in each department
SELECT emp_name, department, salary
FROM (
    SELECT
        emp_name,
        department,
        salary,
        RANK() OVER (
            PARTITION BY department
            ORDER BY salary DESC
        ) AS highest_paid
    FROM employees_day19
) AS ranked_employees
WHERE highest_paid = 1;
 

-- 4 Second-highest salary in each department
select * from (
select *,dense_rank()over(partition by department order by salary desc) as second_highest
from employees_day19
)y
where second_highest=2;


-- 5.Top 3 highest-paid employees in each department
select * from (
select *,dense_rank()over(partition by department order by salary desc) as top
from employees_day19
)y
where top<=3;

-- 6.Departments whose average salary is greater than company average
select department,avg(salary) as avg_salary
from employees_day19
group by department
having avg_salary>(
select avg(salary)
from employees_day19);

-- 7. Employees having the same salary
select emp_name,salary
from employees_day19
where salary in(
select salary
from employees_day19
group by salary
having count(*)>1)
order by salary;

-- 8.Highest salary without using MAX()
select salary
from employees_day19
order by salary desc
limit 1;

-- 9.Third-highest salary
select salary
from(
select salary,dense_rank()over(order by salary desc) as rnk
from employees_day19
)y
where rnk=3;

-- 10.Employees earning more than Ravi
select emp_name,salary
from employees_day19
where salary>(
select salary
from employees_day19
where emp_name="Ravi");

-- Employees who joined before average joining date
SELECT emp_name, joining_date
FROM employees_day19
WHERE joining_date < (
    SELECT AVG(DATEDIFF(joining_date, '2000-01-01'))
    FROM employees_day19
);

-- 12.Salary difference from department average
SELECT
    emp_name,
    department,
    salary,
    AVG(salary) OVER (
        PARTITION BY department
    ) AS dept_avg_salary,
    salary - AVG(salary) OVER (
        PARTITION BY department
    ) AS salary_difference
FROM employees_day19;

-- 13.Previous employee salary using LAG()
SELECT
    emp_name,
    salary,
    LAG(salary) OVER (
        ORDER BY emp_id
    ) AS previous_salary
FROM employees_day19;

-- 14.Difference between current and previous salary
SELECT
    emp_name,
    salary,
    LAG(salary) OVER (
        ORDER BY emp_id
    ) AS previous_salary,
    salary - LAG(salary) OVER (
        ORDER BY emp_id
    ) AS salary_difference
FROM employees_day19;

-- 15.Cumulative salary for each department
SELECT
    emp_name,
    department,
    salary,
    SUM(salary) OVER (
        PARTITION BY department
        ORDER BY emp_id
    ) AS cumulative_salary
FROM employees_day19;