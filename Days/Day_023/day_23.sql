-- SQL Day_23 — 20 Real Business JOIN Problems

use inner_;

CREATE TABLE employees1(
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department_id INT,
    salary INT,
    city VARCHAR(30)
);

INSERT INTO employees1
(emp_id, emp_name, department_id, salary, city)
VALUES
(1, 'Ravi', 101, 55000, 'Hyderabad'),
(2, 'Suresh', 102, 70000, 'Bangalore'),
(3, 'Priya', 103, 45000, 'Hyderabad'),
(4, 'Anjali', 101, 60000, 'Chennai'),
(5, 'Kiran', 104, 75000, 'Mumbai'),
(6, 'Rahul', 102, 70000, 'Hyderabad'),
(7, 'Sneha', 105, 65000, 'Bangalore'),
(8, 'Arjun', NULL, 85000, 'Chennai');

select * from employees1;


-- Create Departments Table
CREATE TABLE department(
    department_id INT PRIMARY KEY,
    department_name VARCHAR(50),
    location VARCHAR(30)
);

INSERT INTO department
(department_id, department_name, location)
VALUES
(101, 'IT', 'Hyderabad'),
(102, 'HR', 'Bangalore'),
(103, 'Finance', 'Hyderabad'),
(104, 'Marketing', 'Mumbai'),
(106, 'Sales', 'Chennai');

select * from department;

-- 1.Show employee name and department name
select e.emp_name,e.salary,e.city, d.department_name
from employees1 e
inner join department d
on e.department_id=d.department_id;


-- 2.Show employee name, salary and department
select e.emp_name,e.salary,d.department_name
from employees1 e
join department d
on e.department_id=d.department_id;

-- 3.Find employees working in IT
select e.emp_name,e.salary,d.department_name
from employees1 e
join department d
on e.department_id=d.department_id
where d.department_name="IT";

-- 4.Find employees working in Hyderabad department
select e.emp_name,d.department_name,d.location
from employees1 e
join department d
on e.department_id=d.department_id
where d.location="Hydereabad";

-- 5.Find employees earning more than ₹60,000
select e.emp_name ,e.salary, d.department_name
from employees1 e
join department d
on e.department_id=d.department_id
where e.salary>60000;

-- 6.Count employees in each department
select d.department_name,count(*) as employees_count
from department d
left join employees1 e
on d.department_id=e.department_id
group by d.department_name;

-- 7.Find total salary by department
select d.department_name,sum(e.salary) as total_salary
from department d
join employees1 e
on d.department_id=d.department_id
group by d.department_name;

-- 8.Find average salary by department
select d.department_name,avg(salary) as avg_salary
from department d
join employees1 e
on d.department_id=e.department_id
group by d.department_name;

-- 9.Departments with average salary > ₹60,000
select d.department_name,avg(e.salary) as avg_salary
from department d
join employees1 e
on d.department_id=d.department_id
group by d.department_name
having avg(e.salary)>60000;

-- 10.Find highest salary in each department
select d.department_name,max(e.salary) as max_salary
from department d
join employees1 e
on d.department_id=d.department_id
group by d.department_name;

-- 11Find employees who don't belong to any department
select e.emp_name,e.department_id
from employees1 e
left join department d
on e.department_id=d.department_id
where d.department_id is null;

-- 12.Find departments that don't have employees
select e.emp_name,d.department_name
from employees1 e
left join department d
on e.department_id=d.department_id
where e.emp_id is null;

-- 13.Find highest-paid employee in each department
with ranked_employees as (
select 
     e.emp_name,
     e.salary,
     e.department_id,
     rank()over(partition by e.department_id order by e.salary desc)as rnk
     from employees1 e
     )
select 
    r.emp_name,
    d.department_name,
    r.salary
from ranked_employees r
join department d
on r.department_id=d.department_id
where r.rnk=1;

-- 14 Find second-highest salary in each department
with second_highest as(
select 
     e.emp_name,
     e.salary,
     e.department_id,dense_rank()over(partition by e.department_id order by e.salary desc) as rnk
     from employees1 e
     )
select 
      s.emp_name,
      d.department_name,
      s.salary
from second_highest s
join department d
on s.department_id=d.department_id
where s.rnk=2;

-- 15. Find departments having more than 1 employee
select d.department_name,count(e.emp_id) as employees_count
from department d
join employees1 e
on d.department_id=e.department_id
group by d.department_name
having employees_count>1;

-- 16.Find department with the highest total salary
select d.department_name,sum(e.salary) as total_salary
from department d
join employees1 e
on d.department_id=e.department_id
group by d.department_name
order by total_salary desc
limit 1;

-- 16 Find employees whose salary is greater than their department average
WITH dept_avg AS (
    SELECT
        department_id,
        AVG(salary) AS avg_salary
    FROM employees1
    GROUP BY department_id
)
SELECT
    e.emp_name,
    d.department_name,
    e.salary,
    a.avg_salary
FROM employees1 e
JOIN dept_avg a
    ON e.department_id = a.department_id
JOIN department d
    ON e.department_id = d.department_id
WHERE e.salary > a.avg_salary;