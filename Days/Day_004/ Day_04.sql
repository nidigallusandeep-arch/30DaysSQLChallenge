-- Day 4 – GROUP BY & HAVING
-- 1. Create table
CREATE TABLE employees3 (
    emp_id INT,
    emp_name VARCHAR(50),
    department VARCHAR(50),
    salary INT
);
INSERT INTO employees3 VALUES
(1, 'Sandeep', 'IT', 50000),
(2, 'Ravi', 'IT', 60000),
(3, 'Priya', 'HR', 45000),
(4, 'Anil', 'HR', 55000),
(5, 'Kiran', 'Sales', 40000),
(6, 'Manoj', 'Sales', 50000),
(7, 'Arjun', 'IT', 70000),
(8, 'Sneha', 'HR', 65000);

select * from employees3;

-- 1. Department-wise employee count
select department,count(*) as employees_count
from employees3
group by department;

-- 2. Department-wise total salary
select department,sum(salary) as total_salary
from employees3
group by department;

-- 3. Department-wise average salary
select department,avg(salary) as avg_salary
from employees3
group by department;

-- 4. Department-wise maximum salary
select department,max(salary) as max_salary
from employees3
group by department;

-- 5. Department-wise minimum salary
select department,min(salary)as min_salary
from employees3
group by department;

-- 6. Departments having more than 2 employees
select department,count(*) as employees_count
from employees3
group by department
having employees_count>2;

-- 7. Departments having average salary > 50,000
select department,avg(salary) as avg_salary
from employees3
group by department
having avg_salary>50000;

-- 8. Departments having total salary > 150,000
select department,sum(salary) as total_salary
from employees3
group by department
having total_salary>150000;

-- 9. Departments where maximum salary > 60,000
select department,max(salary) as max_salary
from employees3
group by department
having max_salary>60000;

-- 10. Department-wise salary in descending order
select department,sum(salary) as total_salary
from employees3
group by department
order by total_salary desc;

-- 11. Department-wise average salary in descending order
select department,avg(salary) as avg_salary
from employees3
group by department
order by avg_salary desc;

-- 12. Count employees earning > 50,000 in each department
select department,count(*) as total_salary
from employees3
where salary>50000
group by department;

-- 13. Departments having at least one employee earning > 60,000
select department,count(*) as emp_count
from employees3
where salary>60000
group by department
having emp_count>=1;

-- 14. Department with the highest total salary
select department,sum(salary) as total_salary
from employees3
group by department
order by total_salary desc
limit 1;

-- 15. Departments whose average salary is between 45,000 and 60,000
select department,avg(salary) as avg_salary
from employees3
group by department
having avg_salary between 45000 and 60000;








